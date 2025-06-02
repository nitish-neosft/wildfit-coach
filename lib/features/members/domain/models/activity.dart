enum ActivityType {
  workout,
  cardio,
  class_,
  assessment,
}

class Activity {
  final String name;
  final ActivityType type;
  final DateTime time;

  Activity({
    required this.name,
    required this.type,
    required this.time,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'] as String,
      type: ActivityType.values.firstWhere(
        (e) => e.toString() == 'ActivityType.${json['type']}',
      ),
      time: DateTime.parse(json['time'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'time': time.toIso8601String(),
    };
  }
}
