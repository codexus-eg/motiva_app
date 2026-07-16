import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class RejectOrderDto {
  final String? reason;

  const RejectOrderDto({this.reason});

  Map<String, dynamic> toJson() => {if (reason != null) 'reason': reason};
}

class CompleteOrderDto {
  final double finalPrice;

  const CompleteOrderDto({required this.finalPrice});

  Map<String, dynamic> toJson() => {'finalPrice': finalPrice};

  FormData toFormData(String orderId, List<XFile> documents) {
    final formData = FormData();
    formData.fields.add(MapEntry('orderId', orderId));
    formData.fields.add(MapEntry('finalPrice', finalPrice.toString()));
    for (int i = 0; i < documents.length; i++) {
      formData.files.add(MapEntry(
        'document_$i',
        MultipartFile.fromFileSync(documents[i].path, filename: documents[i].name),
      ));
    }
    return formData;
  }
}

class AssignOperatorDto {
  final String orderId;
  final String operatorId;

  const AssignOperatorDto({required this.orderId, required this.operatorId});

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'operatorId': operatorId,
  };
}

class BaseOrderActionDto {
  final String orderId;

  const BaseOrderActionDto({required this.orderId});

  Map<String, dynamic> toJson() => {'orderId': orderId};
}
