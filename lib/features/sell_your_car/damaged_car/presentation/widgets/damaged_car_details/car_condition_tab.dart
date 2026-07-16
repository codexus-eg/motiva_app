import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_condition_tab/chassis_issues_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_condition_tab/mechanical_issues_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_condition_tab/runs_and_drives_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_condition_tab/tires_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/damaged_car_details/car_condition_tab/warning_lights_tab.dart';
import 'package:flutter/material.dart';

class CarConditionTab extends StatefulWidget {
  final VoidCallback onContinue;
  final void Function(String value) onChassisIssuesSelected;
  final void Function(String value) onMechanicalIssuesSelected;
  final void Function(String value) onWarningLightsSelected;
  final void Function(String value) onTiresConditionSelected;
  final void Function(bool value) onRunsAndDrivesSelected;

  const CarConditionTab({
    super.key,
    required this.onContinue,
    required this.onChassisIssuesSelected,
    required this.onMechanicalIssuesSelected,
    required this.onWarningLightsSelected,
    required this.onTiresConditionSelected,
    required this.onRunsAndDrivesSelected,
  });

  @override
  State<CarConditionTab> createState() => _CarConditionTabState();
}

class _CarConditionTabState extends State<CarConditionTab> {
  int carConditionIndex = 0;

  void goToNextStack() {
    setState(() {
      carConditionIndex++;
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
                index: carConditionIndex,
                children: [
                  ChassisIssuesTab(
                    onContinue: goToNextStack,
                    onChassisIssuesSelected: widget.onChassisIssuesSelected,
                  ),
                  MechanicalIssuesTab(
                    onContinue: goToNextStack,
                    onMechanicalIssuesSelected:
                        widget.onMechanicalIssuesSelected,
                  ),
                  WarningLightsTab(
                    onContinue: goToNextStack,
                    onWarningLightsSelected: widget.onWarningLightsSelected,
                  ),
                  TiresTab(
                    onContinue: goToNextStack,
                    onTiresConditionSelected: widget.onTiresConditionSelected,
                  ),
                  RunsAndDrivesTab(
                    onContinue: widget.onContinue,
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
