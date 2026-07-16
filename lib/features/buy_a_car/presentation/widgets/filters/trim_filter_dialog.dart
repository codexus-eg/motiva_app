import 'package:app/features/buy_a_car/presentation/providers/car_filter_state.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filter_dialog_base.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class TrimFilterDialog extends ConsumerStatefulWidget {
  final String? selectedMake;
  final String? selectedModel;
  final String? selectedTrim;
  final Function(String?) onApply;

  const TrimFilterDialog({
    super.key,
    this.selectedMake,
    this.selectedModel,
    this.selectedTrim,
    required this.onApply,
  });

  @override
  ConsumerState<TrimFilterDialog> createState() => _TrimFilterDialogState();
}

class _TrimFilterDialogState extends ConsumerState<TrimFilterDialog> {
  String? _selectedTrim;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTrim = widget.selectedTrim;
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

    if (widget.selectedModel == null) {
      return FilterDialogBase(
        title: t.buy_a_car.filters.trim,
        content: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              t.buy_a_car.filters.select_model_first,
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
      title: 'Trim',
      content: filterOptions.when(
        data: (options) {
          final trims = options.trims[widget.selectedModel] ?? [];
          final filteredTrims = _searchQuery.isEmpty
              ? trims
              : trims
                    .where(
                      (t) =>
                          t.toLowerCase().contains(_searchQuery.toLowerCase()),
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
                    hintText: t.buy_a_car.filters.search_trims,
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
                child: filteredTrims.isEmpty
                    ? Center(
                        child: Text(
                          trims.isEmpty
                              ? t.buy_a_car.filters.no_trims_available
                              : t.buy_a_car.filters.no_trims_found,
                          style: GoogleFonts.poppins(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.54,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredTrims.length,
                        itemBuilder: (context, index) {
                          final trim = filteredTrims[index];
                          return FilterOptionTile(
                            label: trim,
                            isSelected: _selectedTrim == trim,
                            onTap: () => setState(() {
                              _selectedTrim = _selectedTrim == trim
                                  ? null
                                  : trim;
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
            t.buy_a_car.filters.failed_to_load_trims,
            style: GoogleFonts.poppins(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
            ),
          ),
        ),
      ),
      onApply: () {
        Navigator.of(context).pop();
        widget.onApply(_selectedTrim);
      },
      onClear: widget.selectedTrim != null
          ? () {
              Navigator.of(context).pop();
              widget.onApply(null);
            }
          : null,
    );
  }
}
