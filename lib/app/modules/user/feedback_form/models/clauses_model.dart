class Clauses {
  final List<String> all_clauses;

  Clauses({required this.all_clauses});

  factory Clauses.fromJson(Map<String, dynamic> json) {
    return Clauses(
      all_clauses: (json['all_clauses'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
    );
  }
}
