import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_condition_dc_tab/ft_chassis_issues_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_condition_dc_tab/ft_mechanical_issues_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_condition_dc_tab/ft_runs_and_drives_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_condition_dc_tab/ft_tires_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_condition_dc_tab/ft_warning_lights_dc_tab.dart';
import 'package:flutter/material.dart';

class FtCarConditionDCTab extends StatefulWidget {
  final void Function(String value) onChassisIssuesSelected;
  final void Function(String value) onMechanicalIssuesSelected;
  final void Function(String value) onWarningLightsSelected;
  final void Function(String value) onTiresConditionSelected;
  final void Function(bool value) onRunsAndDrivesSelected;

  const FtCarConditionDCTab({
    super.key,
    required this.onChassisIssuesSelected,
    required this.onMechanicalIssuesSelected,
    required this.onWarningLightsSelected,
    required this.onTiresConditionSelected,
    required this.onRunsAndDrivesSelected,
  });

  @override
  State<FtCarConditionDCTab> createState() => _FtCarConditionDCTabState();
}

class _FtCarConditionDCTabState extends State<FtCarConditionDCTab> {
  int carConditionIndex = 0;

  void goToNextStack() {
    setState(() {
      carConditionIndex++;
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
                index: carConditionIndex,
                children: [
                  FtChassisIssuesDCTab(
                    onContinue: goToNextStack,
                    onChassisIssuesSelected: widget.onChassisIssuesSelected,
                  ),
                  FtMechanicalIssuesDCTab(
                    onContinue: goToNextStack,
                    onMechanicalIssuesSelected: widget.onMechanicalIssuesSelected,
                  ),
                  FtWarningLightsDCTab(
                    onContinue: goToNextStack,
                    onWarningLightsSelected: widget.onWarningLightsSelected,
                  ),
                  FtTiresDCTab(
                    onContinue: goToNextStack,
                    onTiresConditionSelected: widget.onTiresConditionSelected,
                  ),
                  FtRunsAndDrivesDCTab(
                    onContinue: goToNextStack,
                    onRunsAndDrivesSelected: widget.onRunsAndDrivesSelected,
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
