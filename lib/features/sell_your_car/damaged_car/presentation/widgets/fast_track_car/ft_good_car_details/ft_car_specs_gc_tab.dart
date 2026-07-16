import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_good_car_details/ft_car_specs_gc_tab/ft_engine_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_good_car_details/ft_car_specs_gc_tab/ft_transmission_gc_tab.dart';
import 'package:flutter/material.dart';

class FtCarSpecsGCTab extends StatefulWidget {
  final void Function(String transmission) onTransmissionSelected;
  final void Function(String engineSize) onEngineSelected;
  final VoidCallback onEngineContinue;

  const FtCarSpecsGCTab({
    super.key,
    required this.onTransmissionSelected,
    required this.onEngineSelected,
    required this.onEngineContinue,
  });

  @override
  State<FtCarSpecsGCTab> createState() => _FtCarSpecsGCTabState();
}

class _FtCarSpecsGCTabState extends State<FtCarSpecsGCTab> {
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
                  FtTransmissionGCTab(
                    onContinue: goToNextStack,
                    onTransmissionSelected: widget.onTransmissionSelected,
                  ),
                  FtEngineGCTab(
                    onContinue: widget.onEngineContinue,
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