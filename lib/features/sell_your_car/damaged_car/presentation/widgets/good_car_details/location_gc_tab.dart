import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/constants.dart';
import 'package:app/core/utils/error_display.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/shared/ui/inputs/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class LocationGcTab extends StatefulWidget {
  final VoidCallback onContinue;

  const LocationGcTab({super.key, required this.onContinue});

  @override
  State<LocationGcTab> createState() => _LocationGcTabState();
}

class _LocationGcTabState extends State<LocationGcTab> {
  final _countryOptions = AppConstants.countryOptions;

  final List<String> _cityOptions = ['Kuwait City', 'Al Jahra', 'Hawalli'];
  String? _selectedCountry;
  String? _selectedCity;

  late String hintLocation;

  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    hintLocation = Translations.of(
      context,
    ).sell_your_car.location_tab.pick_location;
  }

  double? latitude;
  double? longitude;
  GeoPoint initPosition = GeoPoint(latitude: 29.3759, longitude: 47.9774);

  Future<void> pickLocation() async {
    if (!mounted) return;

    try {
      GeoPoint? pickedPoint = await showSimplePickerLocation(
        zoomOption: ZoomOption(initZoom: 20),
        contentPadding: EdgeInsets.all(5),
        context: context,
        title: Translations.of(
          context,
        ).sell_your_car.location_tab.select_location_title,
        textConfirmPicker: Translations.of(
          context,
        ).sell_your_car.location_tab.select,
        textCancelPicker: Translations.of(
          context,
        ).sell_your_car.location_tab.cancel,
        initPosition: initPosition,
      );

      if (pickedPoint != null) {
        latitude = pickedPoint.latitude;
        longitude = pickedPoint.longitude;

        await getAddress(latitude!, longitude!);
      }
    } on PlatformException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${Translations.of(context).sell_your_car.location_tab.failed_picker}: ${e.message}',
            ),
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${Translations.of(context).sell_your_car.location_tab.failed_picker}: $e',
            ),
          ),
        );
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      initPosition = GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  Future<void> getAddress(double lat, double lon) async {
    try {
      final response = await dio.get(
        "https://nominatim.openstreetmap.org/reverse",
        queryParameters: {"format": "json", "lat": lat, "lon": lon},
        options: Options(headers: {"User-Agent": "FlutterApp"}),
      );

      final address = response.data["address"];

      final city =
          address["city"] ?? address["town"] ?? address["village"] ?? "";

      final country = address["country"] ?? "";

      setState(() {
        hintLocation = "$city, $country";
      });
    } catch (e, stackTrace) {
      AppLogger.error('getAddress failed', error: e, stackTrace: stackTrace);
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomDropdown<String>(
            hintText: Translations.of(
              context,
            ).sell_your_car.location_tab.country,
            value: _selectedCountry,
            items: _countryOptions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _selectedCountry = val),
          ),
          const Gap(AppSpacing.lg),
          CustomDropdown<String>(
            hintText: Translations.of(context).sell_your_car.location_tab.city,
            value: _selectedCity,
            items: _cityOptions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _selectedCity = val),
          ),
          const Gap(AppSpacing.lg),
          GestureDetector(
            onTap: pickLocation,
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFFFE8C00)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      hintLocation,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          GradientButton(
            text: Translations.of(context).sell_your_car.location_tab.kContinue,
            onTap: widget.onContinue,
          ),
          Gap(AppSpacing.xl),
        ],
      ),
    );
  }
}
