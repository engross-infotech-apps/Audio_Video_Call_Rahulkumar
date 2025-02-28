import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';

class DocumentTypeModel implements Decodable<DocumentTypeModel> {
  int? documentTypeId;
  String? documentName;
  LookupModelPO? modelPO;

  DocumentTypeModel({
    this.documentTypeId,
    this.documentName,
    this.modelPO,
  });

  @override
  DocumentTypeModel decode(json) {
    documentTypeId = json["DocumentTypeId"];
    documentName = json["DocumentName"];
    modelPO = LookupModelPO(
      id: json["DocumentTypeId"],
      name: json["DocumentName"],
    );
    return this;
  }

  factory DocumentTypeModel.fromMap(Map<String, dynamic> json) =>
      DocumentTypeModel(
        documentTypeId: json["DocumentTypeId"],
        documentName: json["DocumentName"],
        modelPO: LookupModelPO(
          id: json["DocumentTypeId"],
          name: json["DocumentName"],
        ),
      );

  Map<String, dynamic> toMap() => {
        "DocumentTypeId": documentTypeId,
        "DocumentName": documentName,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}
