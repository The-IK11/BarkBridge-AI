class GetCreditsModel {
  final bool? success;
  final String? message;
  final CreditData? data;
  final int? code;

  GetCreditsModel({this.success, this.message, this.data, this.code});

  factory GetCreditsModel.fromJson(Map<String, dynamic> json) {
    return GetCreditsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CreditData.fromJson(json['data'] as Map<String, dynamic>)
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

class CreditData {
  final int? credits;
  final int? freeCredit;

  CreditData({
    this.credits,
    this.freeCredit,
  });

  factory CreditData.fromJson(Map<String, dynamic> json) {
    return CreditData(
      credits: json['credits'] as int?,
      freeCredit: json['free_credit'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'credits': credits,
      'free_credit': freeCredit,
    };
  }
}
