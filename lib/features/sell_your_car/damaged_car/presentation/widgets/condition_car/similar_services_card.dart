import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class SimilarServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const SimilarServiceCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
