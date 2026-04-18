class GetProfileDataModel {
  final bool? success;
  final String? message;
  final UserData? data;
  final int? code;

  GetProfileDataModel({this.success, this.message, this.data, this.code});

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    return GetProfileDataModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? UserData.fromJson(json['data'] as Map<String, dynamic>)
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

class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? avatar;
  final String? phone;
  final String? deviceToken;

  UserData({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.phone,
    this.deviceToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      deviceToken: json['device_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'phone': phone,
      'device_token': deviceToken,
    };
  }
}
