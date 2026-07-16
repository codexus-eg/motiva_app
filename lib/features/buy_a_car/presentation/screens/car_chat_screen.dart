import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CarChatScreen extends StatelessWidget {
  const CarChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const _ChatAppBar(),
            const Expanded(child: _ChatBody()),
            const _MessageInputSection(),
          ],
        ),
      ),
    );
  }
}

class _ChatAppBar extends StatelessWidget {
  const _ChatAppBar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            tooltip: SemanticLabels.backButton,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
          ),
          Expanded(
            child: Text(
              t.buy_a_car.car_chat.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Icon(Icons.search, color: theme.colorScheme.onSurface),
        ],
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Gap(AppSpacing.md),
              _RelatedSection(),
              Gap(AppSpacing.md),
              Divider(color: Colors.white24),
              Gap(AppSpacing.md),
              _PdfMessageCard(),
              Gap(AppSpacing.md),
              _TextMessage(),
              Gap(AppSpacing.md),
              _SenderInfo(),
              Gap(AppSpacing.lg),
              _VoiceMessageBubble(),
              Gap(AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _RelatedSection extends StatelessWidget {
  const _RelatedSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.buy_a_car.car_chat.this_message_relates_to,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.buy_a_car.car_chat.buy_a_car,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(AppSpacing.sm),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                child: Image.asset(
                  "assets/images/buy_car.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PdfMessageCard extends StatelessWidget {
  const _PdfMessageCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFE8C00).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            t.buy_a_car.car_chat.inspection_report_pdf,
            style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 16),
          ),
          Gap(AppSpacing.sm),
          Text(
            t.buy_a_car.car_chat.size_kb,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
            ),
          ),
          Gap(AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.buy_a_car.car_chat.download,
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(AppSpacing.sm),
              Icon(Icons.download, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}

class _TextMessage extends StatelessWidget {
  const _TextMessage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFE8C00).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "Please have a look at this inspection report.",
        style: TextStyle(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

class _SenderInfo extends StatelessWidget {
  const _SenderInfo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: Colors.orange,
          child: Text(
            t.buy_a_car.car_chat.sender_initial,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Gap(AppSpacing.md),
        Text(
          t.buy_a_car.car_chat.sender_name,
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
      ],
    );
  }
}

class _VoiceMessageBubble extends StatelessWidget {
  const _VoiceMessageBubble();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: List.generate(
                  25,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 3,
                    height: (index % 5 + 5) * 3,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: Colors.orange),
              ),
            ],
          ),
        ),
        Gap(AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.orange,
              child: Text(
                t.buy_a_car.car_chat.sender_initial,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Gap(AppSpacing.md),
            Text(
              t.buy_a_car.car_chat.you,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

class _MessageInputSection extends StatelessWidget {
  const _MessageInputSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: t.buy_a_car.car_chat.type_message,
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
                  ),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.54,
                        ),
                      ),
                      Gap(AppSpacing.sm),
                      Icon(
                        Icons.camera_alt_outlined,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.54,
                        ),
                      ),
                      Gap(AppSpacing.sm),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.orange, Color(0xFFCC6A00)],
              ),
            ),
            child: const Icon(Icons.mic, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
