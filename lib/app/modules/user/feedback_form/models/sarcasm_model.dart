class Sarcasm {
  final bool isSarcasm;
  final double probability;

  Sarcasm({
    required this.isSarcasm,
    this.probability = 0.0,
  });

  factory Sarcasm.fromJson(Map<String, dynamic> json) {
    return Sarcasm(
      isSarcasm: json['is_sarcasm'] as bool,
      probability: (json['probability'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
