class DynamicPageModel {
  final bool? success;
  final String? message;
  final DynamicPageData? data;
  final int? code;

  DynamicPageModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory DynamicPageModel.fromJson(Map<String, dynamic> json) {
    return DynamicPageModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? DynamicPageData.fromJson(json['data']) : null,
      code: json['code'],
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

class DynamicPageData {
  final int? id;
  final String? pageTitle;
  final String? pageSlug;
  final String? pageContent;

  DynamicPageData({
    this.id,
    this.pageTitle,
    this.pageSlug,
    this.pageContent,
  });

  factory DynamicPageData.fromJson(Map<String, dynamic> json) {
    return DynamicPageData(
      id: json['id'],
      pageTitle: json['page_title'],
      pageSlug: json['page_slug'],
      pageContent: json['page_content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'page_title': pageTitle,
      'page_slug': pageSlug,
      'page_content': pageContent,
    };
  }
}
