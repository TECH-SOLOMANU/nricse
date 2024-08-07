class PDFModel {
  final String fileName;
  final String fileData;

  PDFModel({required this.fileName, required this.fileData});

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'fileData': fileData,
    };
  }

  factory PDFModel.fromJson(Map<String, dynamic> json) {
    return PDFModel(
      fileName: json['fileName'],
      fileData: json['fileData'],
    );
  }
}
