import 'package:app/features/buy_a_car/presentation/widgets/filter_dialog_base.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class MileageFilterDialog extends StatefulWidget {
  final int? mileageFrom;
  final int? mileageTo;
  final Function(int?, int?) onApply;

  const MileageFilterDialog({
    super.key,
    this.mileageFrom,
    this.mileageTo,
    required this.onApply,
  });

  @override
  State<MileageFilterDialog> createState() => _MileageFilterDialogState();
}

class _MileageFilterDialogState extends State<MileageFilterDialog> {
  int? _selectedIndex;

  static final List<_MileageRange> _ranges = [
    _MileageRange(label: t.buy_a_car.filters.mileage_any, from: null, to: null),
    _MileageRange(label: t.buy_a_car.filters.under_50k, from: 0, to: 50000),
    _MileageRange(
      label: t.buy_a_car.filters.range_50k_100k,
      from: 50000,
      to: 100000,
    ),
    _MileageRange(
      label: t.buy_a_car.filters.range_100k_150k,
      from: 100000,
      to: 150000,
    ),
    _MileageRange(label: t.buy_a_car.filters.over_150k, from: 150000, to: null),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = _findSelectedIndex();
  }

  int? _findSelectedIndex() {
    for (int i = 0; i < _ranges.length; i++) {
      if (_ranges[i].from == widget.mileageFrom &&
          _ranges[i].to == widget.mileageTo) {
        return i;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FilterDialogBase(
      title: t.buy_a_car.filters.mileage,
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: _ranges.length,
        itemBuilder: (context, index) {
          final range = _ranges[index];
          final isSelected = _selectedIndex == index;
          return FilterOptionTile(
            label: range.label,
            isSelected: isSelected,
            onTap: () => setState(() {
              _selectedIndex = index;
            }),
          );
        },
      ),
      onApply: () {
        Navigator.of(context).pop();
        if (_selectedIndex != null) {
          widget.onApply(
            _ranges[_selectedIndex!].from,
            _ranges[_selectedIndex!].to,
          );
        } else {
          widget.onApply(null, null);
        }
      },
      onClear: (widget.mileageFrom != null || widget.mileageTo != null)
          ? () {
              Navigator.of(context).pop();
              widget.onApply(null, null);
            }
          : null,
    );
  }
}

class _MileageRange {
  final String label;
  final int? from;
  final int? to;

  const _MileageRange({required this.label, this.from, this.to});
}
