import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/public_marketplace/presentation/providers/public_marketplace_provider.dart';
import 'package:app/features/sell_your_car/data/models/models.dart';
import 'package:app/features/sell_your_car/presentation/providers/car_data_notifier.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SparePartsFilterSheet extends ConsumerStatefulWidget {
  final PublicProductFilter initialFilter;

  const SparePartsFilterSheet({super.key, required this.initialFilter});

  static Future<PublicProductFilter?> show(
    BuildContext context, {
    required PublicProductFilter initialFilter,
  }) {
    return showModalBottomSheet<PublicProductFilter>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SparePartsFilterSheet(initialFilter: initialFilter),
    );
  }

  @override
  ConsumerState<SparePartsFilterSheet> createState() =>
      _SparePartsFilterSheetState();
}

class _SparePartsFilterSheetState extends ConsumerState<SparePartsFilterSheet> {
  String? _make;
  String? _model;
  String _yearFrom = '';
  String _yearTo = '';
  String _brand = '';
  String _minPrice = '';
  String _maxPrice = '';

  List<CarMakeModel> _makes = [];
  List<CarModelModel> _models = [];
  bool _loadingMakes = false;
  bool _loadingModels = false;

  late final TextEditingController _brandController;
  late final TextEditingController _yearFromController;
  late final TextEditingController _yearToController;
  late final TextEditingController _minPriceController;
  late final TextEditingController _maxPriceController;

  @override
  void initState() {
    super.initState();
    _make = widget.initialFilter.make;
    _model = widget.initialFilter.model;
    _brand = widget.initialFilter.brand ?? '';
    _yearFrom = widget.initialFilter.yearFrom?.toString() ?? '';
    _yearTo = widget.initialFilter.yearTo?.toString() ?? '';
    _minPrice = widget.initialFilter.minPrice?.toString() ?? '';
    _maxPrice = widget.initialFilter.maxPrice?.toString() ?? '';
    _brandController = TextEditingController(text: _brand);
    _yearFromController = TextEditingController(text: _yearFrom);
    _yearToController = TextEditingController(text: _yearTo);
    _minPriceController = TextEditingController(text: _minPrice);
    _maxPriceController = TextEditingController(text: _maxPrice);
    _loadMakes();
    if (_make != null) {
      final initialMakeId = _makeIdForName(_make!);
      if (initialMakeId != null) _loadModels(initialMakeId);
    }
  }

  String? _makeIdForName(String makeName) {
    for (final m in _makes) {
      if (m.name == makeName) return m.id;
    }
    return null;
  }

  @override
  void dispose() {
    _brandController.dispose();
    _yearFromController.dispose();
    _yearToController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  Future<void> _loadMakes() async {
    setState(() => _loadingMakes = true);
    try {
      final dataSource = ref.read(carDataRemoteDataSourceProvider);
      final makes = await dataSource.getMakes();
      if (!mounted) return;
      setState(() {
        _makes = makes;
        _loadingMakes = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingMakes = false);
    }
  }

  Future<void> _loadModels(String makeId) async {
    setState(() => _loadingModels = true);
    try {
      final dataSource = ref.read(carDataRemoteDataSourceProvider);
      final models = await dataSource.getModelsByMake(makeId);
      if (!mounted) return;
      setState(() {
        _models = models;
        _loadingModels = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingModels = false);
    }
  }

  bool get _hasAnyValue =>
      _make != null ||
      _model != null ||
      _yearFrom.isNotEmpty ||
      _yearTo.isNotEmpty ||
      _brand.isNotEmpty ||
      _minPrice.isNotEmpty ||
      _maxPrice.isNotEmpty;

  void _reset() {
    setState(() {
      _make = null;
      _model = null;
      _yearFrom = '';
      _yearTo = '';
      _brand = '';
      _minPrice = '';
      _maxPrice = '';
      _brandController.clear();
      _yearFromController.clear();
      _yearToController.clear();
      _minPriceController.clear();
      _maxPriceController.clear();
      _models = [];
    });
  }

  PublicProductFilter _buildFilter() {
    return PublicProductFilter(
      make: _make,
      model: _model,
      yearFrom: int.tryParse(_yearFrom),
      yearTo: int.tryParse(_yearTo),
      brand: _brand.isEmpty ? null : _brand,
      partNumber: widget.initialFilter.partNumber,
      minPrice: double.tryParse(_minPrice),
      maxPrice: double.tryParse(_maxPrice),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }

  InputDecoration _filledDecoration({
    required String hintText,
    required ThemeData theme,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: theme.colorScheme.primaryContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      hintText: hintText,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              Translations.of(context)
                  .public_marketplace
                  .spare_parts
                  .filter_sheet
                  .title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            _buildLabel(Translations.of(context)
                .public_marketplace
                .spare_parts
                .filter_sheet
                .make_label),
            const SizedBox(height: 4),
            _loadingMakes
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: LinearProgressIndicator(),
                  )
                : DropdownButtonFormField<String>(
                    initialValue: _make,
                    isExpanded: true,
                    decoration: _filledDecoration(
                      hintText: 'Any make',
                      theme: theme,
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Any make'),
                      ),
                      ..._makes.map(
                        (m) => DropdownMenuItem<String>(
                          value: m.name,
                          child: Text(m.name),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _make = val;
                        _model = null;
                        _models = [];
                        if (val != null) {
                          final makeId = _makeIdForName(val);
                          if (makeId != null) _loadModels(makeId);
                        }
                      });
                    },
                  ),
            const SizedBox(height: 12),
            _buildLabel(Translations.of(context)
                .public_marketplace
                .spare_parts
                .filter_sheet
                .model_label),
            const SizedBox(height: 4),
            _loadingModels
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: LinearProgressIndicator(),
                  )
                : DropdownButtonFormField<String>(
                    initialValue: _model,
                    isExpanded: true,
                    decoration: _filledDecoration(
                      hintText: 'Any model',
                      theme: theme,
                    ),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Any model'),
                      ),
                      ..._models.map(
                        (m) => DropdownMenuItem<String>(
                          value: m.name,
                          child: Text(m.name),
                        ),
                      ),
                    ],
                    onChanged: _make == null
                        ? null
                        : (val) => setState(() => _model = val),
                  ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(Translations.of(context)
                          .public_marketplace
                          .spare_parts
                          .filter_sheet
                          .year_from_label),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _yearFromController,
                        keyboardType: TextInputType.number,
                        decoration: _filledDecoration(
                          hintText: 'e.g. 2018',
                          theme: theme,
                        ),
                        onChanged: (v) => _yearFrom = v,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(Translations.of(context)
                          .public_marketplace
                          .spare_parts
                          .filter_sheet
                          .year_to_label),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _yearToController,
                        keyboardType: TextInputType.number,
                        decoration: _filledDecoration(
                          hintText: 'e.g. 2023',
                          theme: theme,
                        ),
                        onChanged: (v) => _yearTo = v,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildLabel(Translations.of(context)
                .public_marketplace
                .spare_parts
                .filter_sheet
                .brand_label),
            const SizedBox(height: 4),
            TextField(
              controller: _brandController,
              decoration: _filledDecoration(hintText: 'e.g. Bosch', theme: theme),
              onChanged: (v) => _brand = v,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(Translations.of(context)
                          .public_marketplace
                          .spare_parts
                          .filter_sheet
                          .min_price_label),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _minPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: _filledDecoration(hintText: '0', theme: theme),
                        onChanged: (v) => _minPrice = v,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(Translations.of(context)
                          .public_marketplace
                          .spare_parts
                          .filter_sheet
                          .max_price_label),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _maxPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: _filledDecoration(
                          hintText: '999',
                          theme: theme,
                        ),
                        onChanged: (v) => _maxPrice = v,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(Translations.of(context)
                      .public_marketplace
                      .spare_parts
                      .filter_sheet
                      .cancel),
                ),
                if (_hasAnyValue) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _reset,
                    child: Text(Translations.of(context)
                        .public_marketplace
                        .spare_parts
                        .filter_sheet
                        .reset),
                  ),
                ],
                const SizedBox(width: 8),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () => Navigator.pop(context, _buildFilter()),
                  child: Text(Translations.of(context)
                      .public_marketplace
                      .spare_parts
                      .filter_sheet
                      .apply),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
