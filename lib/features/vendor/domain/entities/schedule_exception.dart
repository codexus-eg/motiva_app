class ScheduleException {
  final String id;
  final String vendorId;
  final DateTime date;
  final bool isClosed;
  final String? startTime;
  final String? endTime;
  final String? reason;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ScheduleException({
    required this.id,
    required this.vendorId,
    required this.date,
    required this.isClosed,
    this.startTime,
    this.endTime,
    this.reason,
    required this.createdAt,
    required this.updatedAt,
  });

  ScheduleException copyWith({
    String? id,
    String? vendorId,
    DateTime? date,
    bool? isClosed,
    String? startTime,
    String? endTime,
    String? reason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduleException(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      date: date ?? this.date,
      isClosed: isClosed ?? this.isClosed,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'date': date.toIso8601String().split('T')[0],
      'isClosed': isClosed,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ScheduleException.fromJson(Map<String, dynamic> json) {
    return ScheduleException(
      id: json['id'] as String,
      vendorId: json['vendorId'] as String,
      date: DateTime.parse(json['date'] as String),
      isClosed: json['isClosed'] as bool? ?? true,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      reason: json['reason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  String toString() =>
      'ScheduleException(id: $id, vendorId: $vendorId, date: $date, isClosed: $isClosed, startTime: $startTime, endTime: $endTime, reason: $reason)';
}

class CreateScheduleExceptionParams {
  final DateTime date;
  final bool isClosed;
  final String? startTime;
  final String? endTime;
  final String? reason;

  const CreateScheduleExceptionParams({
    required this.date,
    this.isClosed = true,
    this.startTime,
    this.endTime,
    this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String().split('T')[0],
      'isClosed': isClosed,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (reason != null) 'reason': reason,
    };
  }
}
