class FaqScreenModel {
  final bool success;
  final String message;
  final List<FaqCategory> data;
  final int code;

  FaqScreenModel({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });

  factory FaqScreenModel.fromJson(Map<String, dynamic> json) {
    return FaqScreenModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<FaqCategory>.from(
              (json['data'] as List).map((item) => FaqCategory.fromJson(item)),
            )
          : [],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
      'code': code,
    };
  }
}

class FaqCategory {
  final int id;
  final String name;
  final String slug;
  final String status;
  final List<FaqItem> faqs;

  FaqCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.faqs,
  });

  factory FaqCategory.fromJson(Map<String, dynamic> json) {
    return FaqCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      status: json['status'] ?? '',
      faqs: json['faqs'] != null
          ? List<FaqItem>.from(
              (json['faqs'] as List).map((item) => FaqItem.fromJson(item)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'status': status,
      'faqs': faqs.map((item) => item.toJson()).toList(),
    };
  }
}

class FaqItem {
  final int id;
  final int faqCategoryId;
  final String question;
  final String answer;
  final String status;

  FaqItem({
    required this.id,
    required this.faqCategoryId,
    required this.question,
    required this.answer,
    required this.status,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      id: json['id'] ?? 0,
      faqCategoryId: json['faq_category_id'] ?? 0,
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'faq_category_id': faqCategoryId,
      'question': question,
      'answer': answer,
      'status': status,
    };
  }
}
