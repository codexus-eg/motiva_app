class DaySchedule {
  final String open;
  final String close;

  const DaySchedule({required this.open, required this.close});

  DaySchedule copyWith({String? open, String? close}) {
    return DaySchedule(open: open ?? this.open, close: close ?? this.close);
  }

  Map<String, dynamic> toJson() {
    return {'Open': open, 'Close': close};
  }

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      open: (json['open']) as String,
      close: (json['close']) as String,
    );
  }

  @override
  String toString() => 'DaySchedule(open: $open, close: $close)';
}

class WorkingHours {
  final DaySchedule? monday;
  final DaySchedule? tuesday;
  final DaySchedule? wednesday;
  final DaySchedule? thursday;
  final DaySchedule? friday;
  final DaySchedule? saturday;
  final DaySchedule? sunday;

  const WorkingHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  WorkingHours copyWith({
    DaySchedule? monday,
    DaySchedule? tuesday,
    DaySchedule? wednesday,
    DaySchedule? thursday,
    DaySchedule? friday,
    DaySchedule? saturday,
    DaySchedule? sunday,
  }) {
    return WorkingHours(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    if (monday != null) result['monday'] = monday!.toJson();
    if (tuesday != null) result['tuesday'] = tuesday!.toJson();
    if (wednesday != null) result['wednesday'] = wednesday!.toJson();
    if (thursday != null) result['thursday'] = thursday!.toJson();
    if (friday != null) result['friday'] = friday!.toJson();
    if (saturday != null) result['saturday'] = saturday!.toJson();
    if (sunday != null) result['sunday'] = sunday!.toJson();
    return result;
  }

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      monday: (json['Monday'] ?? json['monday']) != null
          ? DaySchedule.fromJson(
              (json['Monday'] ?? json['monday']) as Map<String, dynamic>,
            )
          : null,
      tuesday: (json['Tuesday'] ?? json['tuesday']) != null
          ? DaySchedule.fromJson(
              (json['Tuesday'] ?? json['tuesday']) as Map<String, dynamic>,
            )
          : null,
      wednesday: (json['Wednesday'] ?? json['wednesday']) != null
          ? DaySchedule.fromJson(
              (json['Wednesday'] ?? json['wednesday']) as Map<String, dynamic>,
            )
          : null,
      thursday: (json['Thursday'] ?? json['thursday']) != null
          ? DaySchedule.fromJson(
              (json['Thursday'] ?? json['thursday']) as Map<String, dynamic>,
            )
          : null,
      friday: (json['Friday'] ?? json['friday']) != null
          ? DaySchedule.fromJson(
              (json['Friday'] ?? json['friday']) as Map<String, dynamic>,
            )
          : null,
      saturday: (json['Saturday'] ?? json['saturday']) != null
          ? DaySchedule.fromJson(
              (json['Saturday'] ?? json['saturday']) as Map<String, dynamic>,
            )
          : null,
      sunday: (json['Sunday'] ?? json['sunday']) != null
          ? DaySchedule.fromJson(
              (json['Sunday'] ?? json['sunday']) as Map<String, dynamic>,
            )
          : null,
    );
  }

  DaySchedule? getScheduleForDay(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return monday;
      case 'tuesday':
        return tuesday;
      case 'wednesday':
        return wednesday;
      case 'thursday':
        return thursday;
      case 'friday':
        return friday;
      case 'saturday':
        return saturday;
      case 'sunday':
        return sunday;
      default:
        return null;
    }
  }

  List<String> get offDays {
    final List<String> days = [];
    if (monday == null) days.add('Monday');
    if (tuesday == null) days.add('Tuesday');
    if (wednesday == null) days.add('Wednesday');
    if (thursday == null) days.add('Thursday');
    if (friday == null) days.add('Friday');
    if (saturday == null) days.add('Saturday');
    if (sunday == null) days.add('Sunday');
    return days;
  }

  @override
  String toString() =>
      'WorkingHours(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
}
