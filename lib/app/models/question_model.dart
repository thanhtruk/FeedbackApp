class QuestionModel {
  String? title;
  String? id;
  String? field;
  List<String>? fieldDetails;
  String? status;
  String? createdAt;
  String? response;
  String? content;

  QuestionModel({
    this.title,
    this.id,
    this.field,
    this.fieldDetails,
    this.status,
    this.createdAt,
    this.response,
    this.content,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    print(json['clausesSentiment'].runtimeType);
    return QuestionModel(
      title: json['title'] as String?,
      id: json['id'] as String?,
      field: json['field'] as String?,
      fieldDetails: (json['field_detail'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      response: json['response'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'field': field,
      'field_detail': fieldDetails,
      'status': status,
      'response': response,
      'content': content,
    };
  }
}
