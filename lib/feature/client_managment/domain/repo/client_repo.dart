import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_general_regime.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_monthly_record.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_obligation.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_simplified_regime.dart';
import 'package:financial_project/feature/client_managment/domain/model/clients_home_entity.dart';

abstract class ClientRepo {
  Future<Response<Client>> addClient(Client client);
  Future<Response<ClientsHomeEntity>> getClientsHome();
  Future<Response<List<Client>>> searchClients(String nameNit);
  Future<Response<List<ClientObligation>>> getClientObligations(int clientId);
  Future<Response<ClientObligation>> assignClientSimpleObligation(
    Client client,
  );
  Future<Response<Client>> deleteClient(Client client);
  Future<Response<List<ClientObligation>>> assignClientGeneralObligation(
    ClientMonthlyRecord clientRecord,
  );
  Future<Response<ClientSimplifiedRegime>> getClientSimplifiedRegime(
    double capital,
  );
  Future<Response<ClientMonthlyRecord>> addClientMonthlyRecord(
    ClientMonthlyRecord clientRecord,
  );
  Future<Response<bool>> updatePayedObligation(
    ClientObligation clientObligation,
  );
  Future<Response<bool>> exitsRecord(String month, int year);
  Future<Response<ClientGeneralRegime>> getClientGeneralRegime(int regimeId);
  Future<Response<Client>> updateClient(Client client);
}
