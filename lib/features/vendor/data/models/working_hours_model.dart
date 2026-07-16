import 'package:app/features/vendor/domain/entities/working_hours.dart';

class DayScheduleModel {
  final DaySchedule daySchedule;

  const DayScheduleModel({required this.daySchedule});

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleModel(
      daySchedule: DaySchedule.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return daySchedule.toJson();
  }
}

class WorkingHoursModel {
  final WorkingHours workingHours;

  const WorkingHoursModel({required this.workingHours});

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) {
    return WorkingHoursModel(
      workingHours: WorkingHours.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return workingHours.toJson();
  }
}
