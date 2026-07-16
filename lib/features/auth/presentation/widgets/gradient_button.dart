import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isPrimary;
  final double? width;
  final double height;
  final TextStyle? textStyle;

  const GradientButton({
    super.key,
    required this.text,
    this.onTap,
    this.isPrimary = true,
    this.width = double.infinity,
    this.height = 56,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isPrimary
                ? const [Color(0xFFE28C37), Color(0xFF854609)]
                : const [Color(0xFF969595), Color(0xFF272727)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9E1D1D).withValues(alpha: 0.32),
              offset: const Offset(0, 8),
              blurRadius: 24,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style:
              textStyle ??
              const TextStyle(
                fontFamily:
                    'Poppins', // Using Poppins as fallback for display font
                fontSize: 24,
                fontWeight: FontWeight.w900, // Extra bold for display feel
                color: Colors.white,
                letterSpacing: 1.0,
              ),
        ),
      ),
    );
  }
}
