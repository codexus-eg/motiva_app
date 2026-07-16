import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

enum SortOption {
  mostRecent('most_recent', 'Most Recent'),
  highest('highest', 'Highest'),
  lowest('lowest', 'Lowest');

  final String value;
  final String label;

  const SortOption(this.value, this.label);

  String translatedLabel(BuildContext context) {
    final t = Translations.of(context).reviews.display;
    switch (this) {
      case SortOption.mostRecent:
        return t.sort_most_recent;
      case SortOption.highest:
        return t.sort_highest;
      case SortOption.lowest:
        return t.sort_lowest;
    }
  }
}

class SortDropdown extends StatelessWidget {
  final SortOption selectedSort;
  final Function(SortOption) onSortSelected;

  const SortDropdown({
    super.key,
    required this.selectedSort,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SortOption>(
          value: selectedSort,
          onChanged: (option) {
            if (option != null) {
              onSortSelected(option);
            }
          },
          items: SortOption.values.map((option) {
            return DropdownMenuItem<SortOption>(
              value: option,
              child: Text(option.translatedLabel(context)),
            );
          }).toList(),
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 14,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: theme.colorScheme.onSurface,
          ),
          dropdownColor: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
