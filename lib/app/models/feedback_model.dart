class FeedbackModel {
  String? title;
  String? id;
  String? field;
  List<String>? fieldDetails;
  Map<String, String>? clausesSentiment;
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
    print(json['clausesSentiment'].runtimeType);
    return FeedbackModel(
      title: json['title'] as String?,
      id: json['id'] as String?,
      field: json['field'] as String?,
      fieldDetails: (json['field_detail'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      clausesSentiment: json['clausesSentiment'] != null
          ? Map<String, String>.from(json['clausesSentiment'])
          : null,
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
      'clauses_sentiment': clausesSentiment,
      'status': status,
      'response': response,
      'content': content,
    };
  }
}
