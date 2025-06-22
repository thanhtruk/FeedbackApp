class Field {
  String? lable;
  List<String>? fieldDetails;

  Field({this.lable, this.fieldDetails});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      lable: json['field'] as String?,
      fieldDetails: (json['field_detail'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
    );
  }
}
