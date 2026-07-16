import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_specs_tab/body_panel_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_specs_tab/engine_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_specs_tab/inspection_report_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_specs_tab/paint_condition_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_specs_tab/transmission_tab.dart';
import 'package:flutter/material.dart';

class CarSpecsTab extends StatefulWidget {
  final VoidCallback onContinue;
  final void Function(String transmission) onTransmissionSelected;
  final void Function(String engine) onEngineSelected;
  final void Function(String? inspectionReportUrl) onInspectionReportUploaded;
  final void Function(String paintCondition) onPaintConditionSelected;
  final void Function(String bodyPanelDamage) onBodyPanelDamageSelected;

  const CarSpecsTab({
    super.key,
    required this.onContinue,
    required this.onTransmissionSelected,
    required this.onEngineSelected,
    required this.onInspectionReportUploaded,
    required this.onPaintConditionSelected,
    required this.onBodyPanelDamageSelected,
  });

  @override
  State<CarSpecsTab> createState() => _CarSpecsTabState();
}

class _CarSpecsTabState extends State<CarSpecsTab> {
  int carSpecsIndex = 0;

  void goToNextStack() {
    setState(() {
      carSpecsIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: carSpecsIndex,
                children: [
                  TransmissionTab(
                    onContinue: goToNextStack,
                    onTransmissionSelected: widget.onTransmissionSelected,
                  ),
                  EngineTab(
                    onContinue: goToNextStack,
                    onEngineSelected: widget.onEngineSelected,
                  ),
                  InspectionReportTab(
                    onContinue: goToNextStack,
                    onWantsInspectionChanged: (_) {},
                    onInspectionReportUploaded:
                        widget.onInspectionReportUploaded,
                  ),
                  PaintConditionTab(
                    onContinue: goToNextStack,
                    onPaintConditionSelected: widget.onPaintConditionSelected,
                  ),
                  BodyPanelTab(
                    onContinue: widget.onContinue,
                    onBodyPanelDamageSelected: widget.onBodyPanelDamageSelected,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
