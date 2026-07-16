import 'package:app/features/buy_a_car/presentation/providers/car_filter_state.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filter_dialog_base.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ModelFilterDialog extends ConsumerStatefulWidget {
  final String? selectedMake;
  final String? selectedModel;
  final Function(String?) onApply;

  const ModelFilterDialog({
    super.key,
    this.selectedMake,
    this.selectedModel,
    required this.onApply,
  });

  @override
  ConsumerState<ModelFilterDialog> createState() => _ModelFilterDialogState();
}

class _ModelFilterDialogState extends ConsumerState<ModelFilterDialog> {
  String? _selectedModel;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedModel = widget.selectedModel;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterOptions = ref.watch(filterOptionsProvider);
    final theme = Theme.of(context);

    if (widget.selectedMake == null) {
      return FilterDialogBase(
        title: t.buy_a_car.filters.model,
        content: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              t.buy_a_car.filters.select_make_first,
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        onApply: () => Navigator.of(context).pop(),
      );
    }

    return FilterDialogBase(
      title: t.buy_a_car.filters.model,
      content: filterOptions.when(
        data: (options) {
          final models = options.models[widget.selectedMake] ?? [];
          final filteredModels = _searchQuery.isEmpty
              ? models
              : models
                    .where(
                      (m) =>
                          m.toLowerCase().contains(_searchQuery.toLowerCase()),
                    )
                    .toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  style: GoogleFonts.poppins(
                    color: theme.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: t.buy_a_car.filters.search_models,
                    hintStyle: GoogleFonts.poppins(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.54,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.54,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.primaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              Expanded(
                child: filteredModels.isEmpty
                    ? Center(
                        child: Text(
                          t.buy_a_car.filters.no_models_found,
                          style: GoogleFonts.poppins(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.54,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredModels.length,
                        itemBuilder: (context, index) {
                          final model = filteredModels[index];
                          return FilterOptionTile(
                            label: model,
                            isSelected: _selectedModel == model,
                            onTap: () => setState(() {
                              _selectedModel = _selectedModel == model
                                  ? null
                                  : model;
                            }),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => ShimmerSkeletons.cardSkeleton(),
        error: (_, _) => Center(
          child: Text(
            t.buy_a_car.filters.failed_to_load_models,
            style: GoogleFonts.poppins(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
            ),
          ),
        ),
      ),
      onApply: () {
        Navigator.of(context).pop();
        widget.onApply(_selectedModel);
      },
      onClear: widget.selectedModel != null
          ? () {
              Navigator.of(context).pop();
              widget.onApply(null);
            }
          : null,
    );
  }
}
