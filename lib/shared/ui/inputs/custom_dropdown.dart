import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? semanticHint;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.semanticHint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
        child: semanticHint != null
            ? Semantics(
                hint: semanticHint,
                button: true,
                child: DropdownButton<T>(
                  value: value,
                  isExpanded: true,
                  hint: Text(
                    hintText,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.colorScheme.onSurface.withValues(
                      alpha: 0.5,
                    ), // Match design arrow color
                  ),
                  dropdownColor: theme
                      .colorScheme
                      .primaryContainer, // Dark background for dropdown menu
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: theme.colorScheme.onSurface,
                  ),
                  items: items,
                  onChanged: onChanged,
                ),
              )
            : DropdownButton<T>(
                value: value,
                isExpanded: true,
                hint: Text(
                  hintText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.5,
                  ), // Match design arrow color
                ),
                dropdownColor: theme
                    .colorScheme
                    .primaryContainer, // Dark background for dropdown menu
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: theme.colorScheme.onSurface,
                ),
                items: items,
                onChanged: onChanged,
              ),
      ),
    );
  }
}
