class PdfModel {
  final String id;
  final String name;
  final String url;

  PdfModel({
    required this.id,
    required this.name,
    required this.url,
  });

  factory PdfModel.fromJson(Map<String, dynamic> json) {
    return PdfModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}
