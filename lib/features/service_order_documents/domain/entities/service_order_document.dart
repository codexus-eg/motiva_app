class ServiceOrderDocument {
  final String id;
  final String serviceOrderId;
  final String documentType;
  final String fileUrl;
  final String originalFilename;
  final DateTime createdAt;

  const ServiceOrderDocument({
    required this.id,
    required this.serviceOrderId,
    this.documentType = '',
    required this.fileUrl,
    this.originalFilename = '',
    required this.createdAt,
  });

  factory ServiceOrderDocument.fromJson(Map<String, dynamic> json) {
    return ServiceOrderDocument(
      id: json['id'] as String,
      serviceOrderId: json['serviceOrderId'] as String,
      documentType: json['documentType'] as String? ?? '',
      fileUrl: json['fileUrl'] as String,
      originalFilename: json['originalFilename'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  static List<ServiceOrderDocument> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) =>
            ServiceOrderDocument.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}