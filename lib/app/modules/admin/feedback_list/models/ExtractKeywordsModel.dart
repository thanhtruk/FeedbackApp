class ExtractKeywordsModel {
  final Map<String, int>? wordsCount;

  ExtractKeywordsModel({this.wordsCount});

  factory ExtractKeywordsModel.fromJson(Map<String, dynamic> json) {
    return ExtractKeywordsModel(
      wordsCount: (json['words_count'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as int),
      ),
    );
  }

  get wordsCountMap {
    return wordsCount ?? {};
  }
}
