import 'package:app/features/buy_a_car/presentation/widgets/filter_dialog_base.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class TransmissionFilterDialog extends StatefulWidget {
  final String? transmission;
  final Function(String?) onApply;

  const TransmissionFilterDialog({
    super.key,
    this.transmission,
    required this.onApply,
  });

  @override
  State<TransmissionFilterDialog> createState() =>
      _TransmissionFilterDialogState();
}

class _TransmissionFilterDialogState extends State<TransmissionFilterDialog> {
  String? _selectedTransmission;

  static final List<_TransmissionOption> _options = [
    _TransmissionOption(label: t.buy_a_car.filters.any, value: null),
    _TransmissionOption(
      label: t.buy_a_car.filters.automatic,
      value: 'AUTOMATIC',
    ),
    _TransmissionOption(label: t.buy_a_car.filters.manual, value: 'MANUAL'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedTransmission = widget.transmission;
  }

  @override
  Widget build(BuildContext context) {
    return FilterDialogBase(
      title: t.buy_a_car.filters.transmission,
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: _options.length,
        itemBuilder: (context, index) {
          final option = _options[index];
          final isSelected = _selectedTransmission == option.value;
          return FilterOptionTile(
            label: option.label,
            isSelected: isSelected,
            onTap: () => setState(() {
              _selectedTransmission = option.value;
            }),
          );
        },
      ),
      onApply: () {
        Navigator.of(context).pop();
        widget.onApply(_selectedTransmission);
      },
      onClear: widget.transmission != null
          ? () {
              Navigator.of(context).pop();
              widget.onApply(null);
            }
          : null,
    );
  }
}

class _TransmissionOption {
  final String label;
  final String? value;

  const _TransmissionOption({required this.label, this.value});
}
