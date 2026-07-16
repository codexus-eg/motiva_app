import 'package:app/core/network/dio_client.dart';
import 'package:app/features/vendor/data/models/vendor_profile_model.dart';
import 'package:app/features/vendor/domain/entities/schedule_exception.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/features/vendor/domain/entities/vendor_status.dart';
import 'package:app/features/vendor/domain/entities/working_hours.dart';

abstract class VendorRemoteDataSource {
  Future<VendorProfile?> getProfile();
  Future<VendorProfile> updateProfile(Map<String, dynamic> data);
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

class VendorRemoteDataSourceImpl implements VendorRemoteDataSource {
  final DioClient _dioClient;

  VendorRemoteDataSourceImpl(this._dioClient);

  @override
  Future<VendorProfile?> getProfile() async {
    final response = await _dioClient.dio.get('/api/vendors/profile');
    final data = response.data;

    if (data is Map<String, dynamic> && data['profile'] != null) {
      final profileJson = data['profile'];
      if (profileJson == null) return null;
      return VendorProfileModel.fromJson(profileJson).vendorProfile;
    }

    return null;
  }

  @override
  Future<VendorProfile> updateProfile(Map<String, dynamic> data) async {
    final response = await _dioClient.dio.patch(
      '/api/vendors/profile',
      data: data,
    );
    final profileJson = response.data['profile'];
    return VendorProfileModel.fromJson(profileJson).vendorProfile;
  }

  @override
  Future<VendorProfile> updateAvailability(bool isAvailable) async {
    final response = await _dioClient.dio.patch(
      '/api/vendors/availability',
      data: {'isAvailable': isAvailable},
    );
    final profileJson = response.data['profile'];
    return VendorProfileModel.fromJson(profileJson).vendorProfile;
  }

  @override
  Future<VendorProfile> updateCapacity(int orderCapacity) async {
    final response = await _dioClient.dio.patch(
      '/api/vendors/capacity',
      data: {'orderCapacity': orderCapacity},
    );
    final profileJson = response.data['profile'];
    return VendorProfileModel.fromJson(profileJson).vendorProfile;
  }

  @override
  Future<VendorProfile> updateStatus(VendorStatus status) async {
    await _dioClient.dio.patch(
      '/api/vendors/me/status',
      data: {'status': status.apiValue},
    );
    final profile = await getProfile();
    if (profile == null) {
      throw Exception('Failed to fetch updated profile after status change');
    }
    return profile;
  }

  @override
  Future<VendorProfile> updateWorkingHours(WorkingHours workingHours) async {
    final response = await _dioClient.dio.patch(
      '/api/vendors/schedule/working-hours',
      data: {'workingHours': workingHours.toJson()},
    );
    final profileJson = response.data['profile'];
    return VendorProfileModel.fromJson(profileJson).vendorProfile;
  }

  @override
  Future<List<ScheduleException>> getScheduleExceptions() async {
    final response = await _dioClient.dio.get('/api/vendors/schedule');
    final data = response.data;

    if (data is Map<String, dynamic> && data['exceptions'] is List) {
      final exceptionsList = data['exceptions'] as List;
      return exceptionsList
          .map(
            (json) => ScheduleException.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    }

    return [];
  }

  @override
  Future<ScheduleException> createScheduleException(
    CreateScheduleExceptionParams params,
  ) async {
    final response = await _dioClient.dio.post(
      '/api/vendors/schedule',
      data: params.toJson(),
    );
    final exceptionJson = response.data['exception'] as Map<String, dynamic>;
    return ScheduleException.fromJson(exceptionJson);
  }

  @override
  Future<void> deleteScheduleException(String id) async {
    await _dioClient.dio.delete('/api/vendors/schedule/$id');
  }
}
