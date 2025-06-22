class Sentiment {
  final String lable;
  final double probability;

  Sentiment({
    required this.lable,
    required this.probability,
  });

  factory Sentiment.fromJson(Map<String, dynamic> json) {
    return Sentiment(
      lable: json['sentiment'] as String,
      probability: (json['probability'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
