class AnalyzedHistoryDataModel {
  final bool? success;
  final String? message;
  final AnalyzedHistoryPagination? data;
  final int? code;

  AnalyzedHistoryDataModel({this.success, this.message, this.data, this.code});

  factory AnalyzedHistoryDataModel.fromJson(Map<String, dynamic> json) {
    return AnalyzedHistoryDataModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? AnalyzedHistoryPagination.fromJson(json['data'])
          : null,
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
    'code': code,
  };
}

class AnalyzedHistoryPagination {
  final int? currentPage;
  final List<AnalyzedHistoryScanItem>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<AnalyzedHistoryPaginationLink>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  AnalyzedHistoryPagination({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory AnalyzedHistoryPagination.fromJson(Map<String, dynamic> json) {
    return AnalyzedHistoryPagination(
      currentPage: json['current_page'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AnalyzedHistoryScanItem.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => AnalyzedHistoryPaginationLink.fromJson(e))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'data': data?.map((e) => e.toJson()).toList(),
    'first_page_url': firstPageUrl,
    'from': from,
    'last_page': lastPage,
    'last_page_url': lastPageUrl,
    'links': links?.map((e) => e.toJson()).toList(),
    'next_page_url': nextPageUrl,
    'path': path,
    'per_page': perPage,
    'prev_page_url': prevPageUrl,
    'to': to,
    'total': total,
  };
}

class AnalyzedHistoryScanItem {
  final int? id;
  final int? userId;
  final String? mediaType;
  final String? fileHash;
  final String? filePath;
  final AnalyzedHistoryScanResult? result;
  final String? ipAddress;
  final String? modelUsed;
  final int? estimatedTokens;
  final bool? blocked;
  final String? blockReason;
  final String? createdAt;
  final String? updatedAt;

  AnalyzedHistoryScanItem({
    this.id,
    this.userId,
    this.mediaType,
    this.fileHash,
    this.filePath,
    this.result,
    this.ipAddress,
    this.modelUsed,
    this.estimatedTokens,
    this.blocked,
    this.blockReason,
    this.createdAt,
    this.updatedAt,
  });

  bool get isImage => mediaType == 'image';
  bool get isVideo => mediaType == 'video';

  factory AnalyzedHistoryScanItem.fromJson(Map<String, dynamic> json) {
    return AnalyzedHistoryScanItem(
      id: json['id'],
      userId: json['user_id'],
      mediaType: json['media_type'],
      fileHash: json['file_hash'],
      filePath: json['file_path'],
      result: json['result'] != null
          ? AnalyzedHistoryScanResult.fromJson(
              json['result'],
              json['media_type'],
            )
          : null,
      ipAddress: json['ip_address'],
      modelUsed: json['model_used'],
      estimatedTokens: json['estimated_tokens'],
      blocked: json['blocked'] != null
          ? (json['blocked'] == 1 || json['blocked'] == true)
          : null,
      blockReason: json['block_reason'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'media_type': mediaType,
    'file_hash': fileHash,
    'file_path': filePath,
    'result': result?.toJson(),
    'ip_address': ipAddress,
    'model_used': modelUsed,
    'estimated_tokens': estimatedTokens,
    'blocked': blocked != null ? (blocked! ? 1 : 0) : null,
    'block_reason': blockReason,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class AnalyzedHistoryScanResult {
  // ── Image-only fields ──
  final String? mood;
  final String? behavior;
  final AnalyzedHistoryBodyLanguage? bodyLanguage;
  final String? trainingInsight;
  final String? safetyAssessment;

  // ── Video-only fields ──
  final String? activity;
  final String? energyLevel;
  final String? socialBehavior;
  final List<String>? behavioralFlags;
  final String? enrichmentNeeds;

  // ── Shared fields ──
  final int? confidenceScore;
  final String? mediaType;

  AnalyzedHistoryScanResult({
    this.mood,
    this.behavior,
    this.bodyLanguage,
    this.trainingInsight,
    this.safetyAssessment,
    this.activity,
    this.energyLevel,
    this.socialBehavior,
    this.behavioralFlags,
    this.enrichmentNeeds,
    this.confidenceScore,
    this.mediaType,
  });

  bool get isImageResult => mediaType == 'image';
  bool get isVideoResult => mediaType == 'video';

  factory AnalyzedHistoryScanResult.fromJson(
    Map<String, dynamic> json,
    String? mediaType,
  ) {
    return AnalyzedHistoryScanResult(
      mediaType: mediaType,
      confidenceScore: json['confidence_score'],
      // Image fields
      mood: json['mood'],
      behavior: json['behavior'],
      bodyLanguage: json['body_language'] != null
          ? AnalyzedHistoryBodyLanguage.fromJson(json['body_language'])
          : null,
      trainingInsight: json['training_insight'],
      safetyAssessment: json['safety_assessment'],
      // Video fields
      activity: json['activity'],
      energyLevel: json['energy_level'],
      socialBehavior: json['social_behavior'],
      behavioralFlags: (json['behavioral_flags'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      enrichmentNeeds: _parseStringOrList(json['enrichment_needs']),
    );
  }

  Map<String, dynamic> toJson() => {
    'confidence_score': confidenceScore,
    'mood': mood,
    'behavior': behavior,
    'body_language': bodyLanguage?.toJson(),
    'training_insight': trainingInsight,
    'safety_assessment': safetyAssessment,
    'activity': activity,
    'energy_level': energyLevel,
    'social_behavior': socialBehavior,
    'behavioral_flags': behavioralFlags,
    'enrichment_needs': enrichmentNeeds,
  };

  /// Safely parses a JSON value that may arrive as either a `String` or a
  /// `List<dynamic>`. Lists are joined with newlines into a single string.
  static String? _parseStringOrList(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is List) return value.map((e) => e.toString()).join('\n');
    return value.toString();
  }
}

class AnalyzedHistoryBodyLanguage {
  final String? ears;
  final String? eyes;
  final String? tail;
  final String? mouth;
  final String? overallPosture;

  AnalyzedHistoryBodyLanguage({
    this.ears,
    this.eyes,
    this.tail,
    this.mouth,
    this.overallPosture,
  });

  factory AnalyzedHistoryBodyLanguage.fromJson(Map<String, dynamic> json) {
    return AnalyzedHistoryBodyLanguage(
      ears: json['ears'],
      eyes: json['eyes'],
      tail: json['tail'],
      mouth: json['mouth'],
      overallPosture: json['overall_posture'],
    );
  }

  Map<String, dynamic> toJson() => {
    'ears': ears,
    'eyes': eyes,
    'tail': tail,
    'mouth': mouth,
    'overall_posture': overallPosture,
  };
}

class AnalyzedHistoryPaginationLink {
  final String? url;
  final String? label;
  final int? page;
  final bool? active;

  AnalyzedHistoryPaginationLink({this.url, this.label, this.page, this.active});

  factory AnalyzedHistoryPaginationLink.fromJson(Map<String, dynamic> json) {
    return AnalyzedHistoryPaginationLink(
      url: json['url'],
      label: json['label'],
      page: json['page'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'url': url,
    'label': label,
    'page': page,
    'active': active,
  };
}
