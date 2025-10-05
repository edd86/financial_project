import 'package:financial_project/feature/client_managment/data/model/client_model.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';

class ClientMapper {
  static ClientModel toModel(Client client) {
    return ClientModel(
      id: client.id,
      businessName: client.businessName,
      taxId: client.taxId,
      capital: client.capital,
      regimeType: client.regimeType,
      activity: client.activity,
      description: client.description,
      baseProductPrice: client.baseProductPrice,
    );
  }

  static Client toEntity(ClientModel clientModel) {
    return Client(
      id: clientModel.id,
      businessName: clientModel.businessName,
      taxId: clientModel.taxId,
      capital: clientModel.capital,
      regimeType: clientModel.regimeType,
      activity: clientModel.activity,
      description: clientModel.description,
      baseProductPrice: clientModel.baseProductPrice,
    );
  }
}
