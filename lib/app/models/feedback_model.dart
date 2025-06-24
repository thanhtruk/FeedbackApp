class FeedbackModel {
  String? title;
  String? id;
  String? field;
  List<String>? fieldDetails;
  List<Map<String, String>>? clausesSentiment;
  String? status;
  String? createdAt;
  String? response;
  String? content;

  FeedbackModel({
    this.title,
    this.id,
    this.field,
    this.fieldDetails,
    this.clausesSentiment,
    this.status,
    this.createdAt,
    this.response,
    this.content,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      title: json['title'] as String?,
      id: json['id'] as String?,
      field: json['field'] as String?,
      fieldDetails: (json['field_detail'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      clausesSentiment: json['clauses_sentiment'] != null
          ? (json['clauses_sentiment'] as List<dynamic>)
              .map((e) => Map<String, String>.from(e as Map))
              .toList()
          : null,
      status: json['status'] as String?,
      createdAt: json['create_at'] as String?,
      response: json['response'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'field': field,
      'field_detail': fieldDetails,
      'clauses_sentiment': clausesSentiment,
      'status': status,
      'response': response,
      'content': content,
    };
  }
}
