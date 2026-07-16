import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String comingSoonLabel;
  final VoidCallback? onTap;
  final bool hideComingSoon;

  const RewardCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    this.comingSoonLabel = 'Coming Soon',
    this.onTap,
    this.hideComingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child:
                              CircularProgressIndicator(strokeWidth: 1.5),
                        );
                      },
                      errorBuilder: (_, _, _) => Container(
                        color: theme.colorScheme.primaryContainer,
                        child: const Icon(
                          Icons.directions_car,
                          color: Colors.grey,
                          size: 32,
                        ),
                      ),
                    ),
                    if (!hideComingSoon)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            comingSoonLabel,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
