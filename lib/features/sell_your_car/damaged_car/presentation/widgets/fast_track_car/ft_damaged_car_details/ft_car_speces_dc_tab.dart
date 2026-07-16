import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_specs_dc_tab/ft_body_panel_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_specs_dc_tab/ft_engine_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_specs_dc_tab/ft_inspection_report_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_specs_dc_tab/ft_paint_condition_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_specs_dc_tab/ft_transmission_dc_tab.dart';
import 'package:flutter/material.dart';

class FtCarSpecsDcTab extends StatefulWidget {
  final void Function(String transmission) onTransmissionSelected;
  final void Function(String engine) onEngineSelected;
  final void Function(String paintCondition) onPaintConditionSelected;
  final void Function(String bodyPanelDamage) onBodyPanelDamageSelected;
  final void Function(String? inspectionReportUrl) onInspectionReportUploaded;

  const FtCarSpecsDcTab({
    super.key,
    required this.onTransmissionSelected,
    required this.onEngineSelected,
    required this.onPaintConditionSelected,
    required this.onBodyPanelDamageSelected,
    required this.onInspectionReportUploaded,
  });

  @override
  State<FtCarSpecsDcTab> createState() => _FtCarSpecsDcTabState();
}

class _FtCarSpecsDcTabState extends State<FtCarSpecsDcTab> {
  int carSpecsIndex = 0;

  void goToNextStack() {
    setState(() {
      carSpecsIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: carSpecsIndex,
                children: [
                  FtTransmissionDCTab(
                    onContinue: goToNextStack,
                    onTransmissionSelected: widget.onTransmissionSelected,
                  ),
                  FtEngineDCTab(
                    onContinue: goToNextStack,
                    onEngineSelected: widget.onEngineSelected,
                  ),
                  FtInspectionReportDCTab(
                    onContinue: goToNextStack,
                    onInspectionReportUploaded: widget.onInspectionReportUploaded,
                  ),
                  FtPaintConditionDCTab(
                    onContinue: goToNextStack,
                    onPaintConditionSelected: widget.onPaintConditionSelected,
                  ),
                  FtBodyPanelDCTab(
                    onContinue: goToNextStack,
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
