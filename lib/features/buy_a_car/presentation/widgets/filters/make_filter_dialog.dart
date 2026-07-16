import 'package:app/features/buy_a_car/presentation/providers/car_filter_state.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filter_dialog_base.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MakeFilterDialog extends ConsumerStatefulWidget {
  final String? selectedMake;
  final Function(String?) onApply;

  const MakeFilterDialog({super.key, this.selectedMake, required this.onApply});

  @override
  ConsumerState<MakeFilterDialog> createState() => _MakeFilterDialogState();
}

class _MakeFilterDialogState extends ConsumerState<MakeFilterDialog> {
  String? _selectedMake;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedMake = widget.selectedMake;
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

    return FilterDialogBase(
      title: t.buy_a_car.filters.make,
      content: filterOptions.when(
        data: (options) {
          final filteredMakes = _searchQuery.isEmpty
              ? options.makes
              : options.makes
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
                    hintText: t.buy_a_car.filters.search_makes,
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
                child: filteredMakes.isEmpty
                    ? Center(
                        child: Text(
                          t.buy_a_car.filters.no_makes_found,
                          style: GoogleFonts.poppins(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.54,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredMakes.length,
                        itemBuilder: (context, index) {
                          final make = filteredMakes[index];
                          return FilterOptionTile(
                            label: make,
                            isSelected: _selectedMake == make,
                            onTap: () => setState(() {
                              _selectedMake = _selectedMake == make
                                  ? null
                                  : make;
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
            t.buy_a_car.filters.failed_to_load_makes,
            style: GoogleFonts.poppins(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
            ),
          ),
        ),
      ),
      onApply: () {
        Navigator.of(context).pop();
        widget.onApply(_selectedMake);
      },
      onClear: widget.selectedMake != null
          ? () {
              Navigator.of(context).pop();
              widget.onApply(null);
            }
          : null,
    );
  }
}
