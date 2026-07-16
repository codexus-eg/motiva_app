import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AttributeValueWidget extends StatelessWidget {
  const AttributeValueWidget({super.key, required this.value});

  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final str = value?.toString() ?? '';
    final theme = Theme.of(context);
    if (str.startsWith('http')) {
      return GestureDetector(
        onTap: () => _launchUrl(str),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                str.split('/').last,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2196F3),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF2196F3),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.open_in_new,
              size: 14,
              color: Color(0xFF2196F3),
            ),
          ],
        ),
      );
    }
    return Text(
      _formatValue(value),
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _formatValue(dynamic value) {
    if (value == null) return 'N/A';
    final str = value.toString();
    return str
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}