import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/car_specs_gc_tab/engine_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/car_specs_gc_tab/transmission_gc_tab.dart';
import 'package:flutter/material.dart';

class CarSpecsGCTab extends StatefulWidget {
  final void Function(String transmission) onTransmissionSelected;
  final void Function(String engineSize) onEngineSelected;

  const CarSpecsGCTab({
    super.key,
    required this.onTransmissionSelected,
    required this.onEngineSelected,
  });

  @override
  State<CarSpecsGCTab> createState() => _CarSpecsGCTabState();
}

class _CarSpecsGCTabState extends State<CarSpecsGCTab> {
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
                  TransmissionGCTab(
                    onContinue: goToNextStack,
                    onTransmissionSelected: widget.onTransmissionSelected,
                  ),
                  EngineGCTab(
                    onEngineSelected: widget.onEngineSelected,
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
