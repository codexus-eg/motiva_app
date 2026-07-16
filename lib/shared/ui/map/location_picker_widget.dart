// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:app/core/theme/spacing.dart';

class LocationPickerWidget extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;
  final String? initialAddress;
  final Function(double lat, double lng, String? address) onLocationSelected;

  const LocationPickerWidget({
    super.key,
    this.initialLat,
    this.initialLng,
    this.initialAddress,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  late MapController _mapController;
  GeoPoint? _selectedPoint;
  String? _selectedAddress;
  bool _isLoading = false;
  bool _isLoadingAddress = false;
  bool _isInitialized = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    setState(() => _isLoading = true);

    GeoPoint? initialPoint;

    if (widget.initialLat != null && widget.initialLng != null) {
      initialPoint = GeoPoint(
        latitude: widget.initialLat!,
        longitude: widget.initialLng!,
      );
      _selectedAddress = widget.initialAddress;
    } else {
      final position = await _getCurrentLocation();
      if (position != null) {
        initialPoint = GeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      }
    }

    if (initialPoint != null) {
      _selectedPoint = initialPoint;
    }

    _mapController = MapController(initPosition: initialPoint);

    setState(() {
      _isLoading = false;
      _isInitialized = true;
    });
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showServiceDisabledDialog();
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog();
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedDialog();
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('Error getting location: $e');
      return null;
    }
  }

  void _showServiceDisabledDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Location Services Disabled',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Location services are turned off. Please enable them in your device settings to use your current location.',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: Text(
              'Open Settings',
              style: GoogleFonts.poppins(color: const Color(0xFFFE8C00)),
            ),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Location Permission Required',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'We need location access to find services near you. You can grant permission in settings, or select a location manually on the map.',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Select Manually',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text(
              'Open Settings',
              style: GoogleFonts.poppins(color: const Color(0xFFFE8C00)),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json',
      );
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['display_name'] != null) {
          return data['display_name'] as String;
        }
      }
    } catch (e) {
      debugPrint('Geocoding error: $e');
    }
    // Fallback to coordinates if geocoding fails
    return 'Location at ${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}';
  }

  void _onMapMoved(GeoPoint center) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      _selectedPoint = center;

      // Show loading state while fetching address
      setState(() {
        _isLoadingAddress = true;
      });

      final address = await _getAddressFromCoordinates(
        _selectedPoint!.latitude,
        _selectedPoint!.longitude,
      );

      if (mounted) {
        setState(() {
          _selectedAddress = address;
          _isLoadingAddress = false;
        });
        widget.onLocationSelected(
          _selectedPoint!.latitude,
          _selectedPoint!.longitude,
          address,
        );
      }
    });
  }

  Future<void> _goToCurrentLocation() async {
    setState(() => _isLoading = true);

    final position = await _getCurrentLocation();

    if (position != null && mounted) {
      final point = GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      try {
        // On web, add delay to ensure iframe JS bridge is ready
        if (kIsWeb) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
        await _mapController.moveTo(point, animate: true);
        _onMapMoved(point);
        setState(() => _isLoading = false);
      } catch (e) {
        debugPrint('Error moving to location: $e');
        setState(() => _isLoading = false);
        if (mounted && kIsWeb) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Map not ready. Please try again in a moment.'),
            ),
          );
        }
      }
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not get current location. Please enable location services.',
            ),
          ),
        );
      }
    }
  }

  void _confirmLocation() {
    if (_selectedPoint != null) {
      widget.onLocationSelected(
        _selectedPoint!.latitude,
        _selectedPoint!.longitude,
        _selectedAddress,
      );
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Location',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: Color(0xFFFE8C00)),
            onPressed: _isLoading ? null : _goToCurrentLocation,
            tooltip: 'Use current location',
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildMap(),
          if (_isLoading) _buildLoadingOverlay(),
          // Static centered marker overlay (Uber-style)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFFFE8C00),
                  size: 48,
                ),
                // Offset to align pin tip with center
                Gap(AppSpacing.lg),
              ],
            ),
          ),
          _buildBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    if (!_isInitialized) {
      return const Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
      );
    }

    return OSMFlutter(
      controller: _mapController,
      osmOption: OSMOption(
        userTrackingOption: const UserTrackingOption(
          enableTracking: false,
          unFollowUser: false,
        ),
        zoomOption: const ZoomOption(
          initZoom: 15,
          minZoomLevel: 3,
          maxZoomLevel: 19,
        ),
      ),
      onMapIsReady: (isReady) async {
        if (isReady && _selectedPoint != null) {
          // Trigger initial address lookup for the center position
          _onMapMoved(_selectedPoint!);
        }
      },
      onMapMoved: (region) {
        _onMapMoved(region.center);
      },
    );
  }

  Widget _buildLoadingOverlay() {
    final theme = Theme.of(context);
    return Positioned(
      top: 16,
      left: 0,
      right: 0,
      child: Center(
        child: Card(
          color: theme.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Processing...',
              style: GoogleFonts.poppins(color: theme.colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    final theme = Theme.of(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected Location',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const Gap(AppSpacing.sm),
              _buildLocationInfo(),
              const Gap(AppSpacing.lg),
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    final theme = Theme.of(context);
    if (_selectedPoint != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFFFE8C00), size: 20),
              const Gap(AppSpacing.sm),
              Expanded(
                child: _isLoadingAddress
                    ? Text(
                        'Finding address...',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    : Text(
                        _selectedAddress ?? 'Unknown location',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ],
          ),
          if (!_isLoadingAddress) ...[
            const Gap(AppSpacing.sm),
            Text(
              'Coordinates: ${_selectedPoint!.latitude.toStringAsFixed(4)}, ${_selectedPoint!.longitude.toStringAsFixed(4)}',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ],
        ],
      );
    }

    return Text(
      'Move the map to select a location',
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _selectedPoint != null && !_isLoading
            ? _confirmLocation
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFE8C00),
          disabledBackgroundColor: const Color(0xFF383A42),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Confirm Location',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
