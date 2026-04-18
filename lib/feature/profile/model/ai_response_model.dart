class AIResponseModel {
  final bool? success;
  final String? message;
  final AnalysisData? data;
  final int? code;

  AIResponseModel({this.success, this.message, this.data, this.code});

  factory AIResponseModel.fromJson(Map<String, dynamic> json) {
    return AIResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? AnalysisData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'code': code,
    };
  }
}

class AnalysisData {
  final bool? success;
  final BehaviorAnalysis? data;
  final String? model;

  AnalysisData({this.success, this.data, this.model});

  factory AnalysisData.fromJson(Map<String, dynamic> json) {
    return AnalysisData(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? BehaviorAnalysis.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      model: json['model'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data?.toJson(), 'model': model};
  }
}

class BehaviorAnalysis {
  final String? activity;
  final String? socialBehavior;
  final String? energyLevel;
  final List<String>? behavioralFlags;
  final String? enrichmentNeeds;
  final int? confidenceScore;

  BehaviorAnalysis({
    this.activity,
    this.socialBehavior,
    this.energyLevel,
    this.behavioralFlags,
    this.enrichmentNeeds,
    this.confidenceScore,
  });

  factory BehaviorAnalysis.fromJson(Map<String, dynamic> json) {
    List<String>? flags;

    if (json['behavioral_flags'] != null) {
      if (json['behavioral_flags'] is List) {
        // If it's already a list, convert to List<String>
        flags = List<String>.from(json['behavioral_flags'] as List);
      } else if (json['behavioral_flags'] is String) {
        // If it's a string, split by periods to create individual flags
        final flagString = json['behavioral_flags'] as String;
        flags = flagString
            .split('.')
            .where((flag) => flag.trim().isNotEmpty)
            .map((flag) => flag.trim())
            .toList();
      }
    }

    return BehaviorAnalysis(
      activity: json['activity'] as String?,
      socialBehavior: json['social_behavior'] as String?,
      energyLevel: json['energy_level'] as String?,
      behavioralFlags: flags,
      enrichmentNeeds: json['enrichment_needs'] as String?,
      confidenceScore: json['confidence_score'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'social_behavior': socialBehavior,
      'energy_level': energyLevel,
      'behavioral_flags': behavioralFlags,
      'enrichment_needs': enrichmentNeeds,
      'confidence_score': confidenceScore,
    };
  }
}
