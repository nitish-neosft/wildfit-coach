class MemberStats {
  final String memberId;
  final DateTime lastUpdated;
  final BodyMeasurements measurements;
  final List<WorkoutProgress> workoutProgress;
  final List<NutritionProgress> nutritionProgress;
  final VitalSigns vitalSigns;

  const MemberStats({
    required this.memberId,
    required this.lastUpdated,
    required this.measurements,
    required this.workoutProgress,
    required this.nutritionProgress,
    required this.vitalSigns,
  });

  factory MemberStats.fromJson(Map<String, dynamic> json) {
    return MemberStats(
      memberId: json['memberId'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      measurements: BodyMeasurements.fromJson(
          json['measurements'] as Map<String, dynamic>),
      workoutProgress: (json['workoutProgress'] as List)
          .map((e) => WorkoutProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      nutritionProgress: (json['nutritionProgress'] as List)
          .map((e) => NutritionProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      vitalSigns:
          VitalSigns.fromJson(json['vitalSigns'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'lastUpdated': lastUpdated.toIso8601String(),
      'measurements': measurements.toJson(),
      'workoutProgress': workoutProgress.map((e) => e.toJson()).toList(),
      'nutritionProgress': nutritionProgress.map((e) => e.toJson()).toList(),
      'vitalSigns': vitalSigns.toJson(),
    };
  }
}

class BodyMeasurements {
  final double weight;
  final double height;
  final double chest;
  final double waist;
  final double hips;
  final double arms;
  final double thighs;
  final double calves;
  final double bodyFatPercentage;
  final double muscleMass;

  const BodyMeasurements({
    required this.weight,
    required this.height,
    required this.chest,
    required this.waist,
    required this.hips,
    required this.arms,
    required this.thighs,
    required this.calves,
    required this.bodyFatPercentage,
    required this.muscleMass,
  });

  factory BodyMeasurements.fromJson(Map<String, dynamic> json) {
    return BodyMeasurements(
      weight: json['weight'] as double,
      height: json['height'] as double,
      chest: json['chest'] as double,
      waist: json['waist'] as double,
      hips: json['hips'] as double,
      arms: json['arms'] as double,
      thighs: json['thighs'] as double,
      calves: json['calves'] as double,
      bodyFatPercentage: json['bodyFatPercentage'] as double,
      muscleMass: json['muscleMass'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'height': height,
      'chest': chest,
      'waist': waist,
      'hips': hips,
      'arms': arms,
      'thighs': thighs,
      'calves': calves,
      'bodyFatPercentage': bodyFatPercentage,
      'muscleMass': muscleMass,
    };
  }
}

class WorkoutProgress {
  final DateTime date;
  final String workoutId;
  final String workoutName;
  final int completedSets;
  final int totalSets;
  final Map<String, double> weights;
  final int duration;
  final double caloriesBurned;

  const WorkoutProgress({
    required this.date,
    required this.workoutId,
    required this.workoutName,
    required this.completedSets,
    required this.totalSets,
    required this.weights,
    required this.duration,
    required this.caloriesBurned,
  });

  factory WorkoutProgress.fromJson(Map<String, dynamic> json) {
    return WorkoutProgress(
      date: DateTime.parse(json['date'] as String),
      workoutId: json['workoutId'] as String,
      workoutName: json['workoutName'] as String,
      completedSets: json['completedSets'] as int,
      totalSets: json['totalSets'] as int,
      weights: Map<String, double>.from(json['weights'] as Map),
      duration: json['duration'] as int,
      caloriesBurned: json['caloriesBurned'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'workoutId': workoutId,
      'workoutName': workoutName,
      'completedSets': completedSets,
      'totalSets': totalSets,
      'weights': weights,
      'duration': duration,
      'caloriesBurned': caloriesBurned,
    };
  }
}

class NutritionProgress {
  final DateTime date;
  final int totalCalories;
  final Map<String, double> macros;
  final int waterIntake;
  final List<String> supplements;
  final bool followedPlan;

  const NutritionProgress({
    required this.date,
    required this.totalCalories,
    required this.macros,
    required this.waterIntake,
    required this.supplements,
    required this.followedPlan,
  });

  factory NutritionProgress.fromJson(Map<String, dynamic> json) {
    return NutritionProgress(
      date: DateTime.parse(json['date'] as String),
      totalCalories: json['totalCalories'] as int,
      macros: Map<String, double>.from(json['macros'] as Map),
      waterIntake: json['waterIntake'] as int,
      supplements: (json['supplements'] as List).cast<String>(),
      followedPlan: json['followedPlan'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'totalCalories': totalCalories,
      'macros': macros,
      'waterIntake': waterIntake,
      'supplements': supplements,
      'followedPlan': followedPlan,
    };
  }
}

class VitalSigns {
  final int restingHeartRate;
  final int bloodPressureSystolic;
  final int bloodPressureDiastolic;
  final double bodyTemperature;
  final int respiratoryRate;
  final double oxygenSaturation;

  const VitalSigns({
    required this.restingHeartRate,
    required this.bloodPressureSystolic,
    required this.bloodPressureDiastolic,
    required this.bodyTemperature,
    required this.respiratoryRate,
    required this.oxygenSaturation,
  });

  factory VitalSigns.fromJson(Map<String, dynamic> json) {
    return VitalSigns(
      restingHeartRate: json['restingHeartRate'] as int,
      bloodPressureSystolic: json['bloodPressureSystolic'] as int,
      bloodPressureDiastolic: json['bloodPressureDiastolic'] as int,
      bodyTemperature: json['bodyTemperature'] as double,
      respiratoryRate: json['respiratoryRate'] as int,
      oxygenSaturation: json['oxygenSaturation'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restingHeartRate': restingHeartRate,
      'bloodPressureSystolic': bloodPressureSystolic,
      'bloodPressureDiastolic': bloodPressureDiastolic,
      'bodyTemperature': bodyTemperature,
      'respiratoryRate': respiratoryRate,
      'oxygenSaturation': oxygenSaturation,
    };
  }
}
