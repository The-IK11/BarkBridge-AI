class FaqScreenModel {
  final bool? success;
  final String? message;
  final List<FaqCategory>? data;
  final int? code;

  FaqScreenModel({this.success, this.message, this.data, this.code});

  factory FaqScreenModel.fromJson(Map<String, dynamic> json) {
    return FaqScreenModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<FaqCategory>.from(
              (json['data'] as List).map((item) => FaqCategory.fromJson(item)),
            )
          : null,
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
      'code': code,
    };
  }
}

class FaqCategory {
  final int? id;
  final String? name;
  final String? slug;
  final String? status;
  final List<FaqItem>? faqs;

  FaqCategory({this.id, this.name, this.slug, this.status, this.faqs});

  factory FaqCategory.fromJson(Map<String, dynamic> json) {
    return FaqCategory(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'],
      faqs: json['faqs'] != null
          ? List<FaqItem>.from(
              (json['faqs'] as List).map((item) => FaqItem.fromJson(item)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'status': status,
      'faqs': faqs?.map((item) => item.toJson()).toList(),
    };
  }
}

class FaqItem {
  final int? id;
  final int? faqCategoryId;
  final String? question;
  final String? answer;
  final String? status;

  FaqItem({
    this.id,
    this.faqCategoryId,
    this.question,
    this.answer,
    this.status,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      id: json['id'],
      faqCategoryId: json['faq_category_id'],
      question: json['question'],
      answer: json['answer'],
      status: json['status'],
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
