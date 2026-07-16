import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/service-categories/presentation/providers/service_categories_provider.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-services/presentation/providers/vendor_services_provider.dart';
import 'package:app/features/vendor-services/presentation/screens/create_service_screen.dart';
import 'package:app/features/vendor-services/presentation/widgets/service_card.dart';
import 'package:app/shared/ui/dialogs/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class ServicesByCategorySection extends ConsumerWidget {
  final String categoryId;
  final List<VendorService> services;

  const ServicesByCategorySection({
    super.key,
    required this.categoryId,
    required this.services,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(serviceCategoriesProvider);
    final categoryName = _getCategoryName(categoryAsync.valueOrNull);

    final activeServices = services.where((s) => !s.isArchived).toList();
    final archivedServices = services.where((s) => s.isArchived).toList();
    final allServices = [...activeServices, ...archivedServices];
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.primaryContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  archivedServices.isNotEmpty
                      ? t.vendor_services.category_section.status_with_archived
                            .replaceAll(
                              '{active}',
                              activeServices.length.toString(),
                            )
                            .replaceAll(
                              '{archived}',
                              archivedServices.length.toString(),
                            )
                      : t.vendor_services.category_section.status.replaceAll(
                          '{active}',
                          activeServices.length.toString(),
                        ),
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(AppSpacing.md),
        ...allServices.map(
          (service) => ServiceCard(
            service: service,
            categoryName: categoryName,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateServiceScreen(
                    categoryId: service.categoryId,
                    existingService: service,
                  ),
                ),
              );
            },
            onEdit: service.isArchived
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateServiceScreen(
                          categoryId: service.categoryId,
                          existingService: service,
                        ),
                      ),
                    );
                  },
            onArchive: service.isArchived
                ? null
                : () => _confirmArchive(context, ref, service),
            onRestore: service.isArchived
                ? () => _confirmRestore(context, ref, service)
                : null,
          ),
        ),
      ],
    );
  }

  String _getCategoryName(List<ServiceCategory>? categories) {
    if (categories == null) return 'Services';
    final category = categories.where((c) => c.id == categoryId).firstOrNull;
    return category?.name ?? t.vendor_services.category_section.fallback_name;
  }

  Future<void> _confirmArchive(
    BuildContext context,
    WidgetRef ref,
    VendorService service,
  ) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: t.vendor_services.category_section.dialog.archive_title,
      message: t.vendor_services.category_section.dialog.archive_message
          .replaceAll('{name}', service.name),
      confirmText: t.vendor_services.category_section.dialog.archive_confirm,
      confirmColor: AppColors.red,
      icon: Icons.archive,
    );

    if (confirmed == true) {
      final success = await ref
          .read(vendorServicesNotifierProvider.notifier)
          .archiveService(service.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? t.vendor_services.category_section.snackbar.archive_success
                  : t.vendor_services.category_section.snackbar.archive_failed,
            ),
            backgroundColor: success ? AppColors.green : AppColors.red,
          ),
        );
      }
    }
  }

  Future<void> _confirmRestore(
    BuildContext context,
    WidgetRef ref,
    VendorService service,
  ) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: t.vendor_services.category_section.dialog.restore_title,
      message: t.vendor_services.category_section.dialog.restore_message
          .replaceAll('{name}', service.name),
      confirmText: t.vendor_services.category_section.dialog.restore_confirm,
      confirmColor: AppColors.green,
      icon: Icons.restore,
    );

    if (confirmed == true && context.mounted) {
      await _restoreService(context, ref, service);
    }
  }

  Future<void> _restoreService(
    BuildContext context,
    WidgetRef ref,
    VendorService service,
  ) async {
    final success = await ref
        .read(vendorServicesNotifierProvider.notifier)
        .restoreService(service.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? t.vendor_services.category_section.snackbar.restore_success
                : t.vendor_services.category_section.snackbar.restore_failed,
          ),
          backgroundColor: success ? AppColors.green : AppColors.red,
        ),
      );
    }
  }
}
