import 'package:financial_project/feature/client_managment/domain/model/client.dart';

class ClientsHomeEntity {
  List<Client> newClients;
  List<Client> simplifiedClients;
  List<Client> generalClients;

  ClientsHomeEntity({
    required this.newClients,
    required this.simplifiedClients,
    required this.generalClients,
  });
}
