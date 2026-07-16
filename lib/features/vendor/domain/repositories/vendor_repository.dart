import 'package:app/features/vendor/domain/entities/schedule_exception.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/features/vendor/domain/entities/vendor_status.dart';
import 'package:app/features/vendor/domain/entities/working_hours.dart';

class UpdateVendorParams {
  final String? businessName;
  final String? commercialLicenseNo;
  final String? logoUrl;
  final String? coverImageUrl;

  const UpdateVendorParams({
    this.businessName,
    this.commercialLicenseNo,
    this.logoUrl,
    this.coverImageUrl,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (businessName != null) map['businessName'] = businessName;
    if (commercialLicenseNo != null) {
      map['commercialLicenseNo'] = commercialLicenseNo;
    }
    if (logoUrl != null) map['logoUrl'] = logoUrl;
    if (coverImageUrl != null) map['coverImageUrl'] = coverImageUrl;
    return map;
  }
}

abstract class VendorRepository {
  Future<VendorProfile?> getProfile();
  Future<VendorProfile> updateProfile(UpdateVendorParams params);
  Future<VendorProfile> updateAvailability(bool isAvailable);
  Future<VendorProfile> updateCapacity(int orderCapacity);
  Future<VendorProfile> updateStatus(VendorStatus status);
  Future<VendorProfile> updateWorkingHours(WorkingHours workingHours);
  Future<List<ScheduleException>> getScheduleExceptions();
  Future<ScheduleException> createScheduleException(
    CreateScheduleExceptionParams params,
  );
  Future<void> deleteScheduleException(String id);
}
