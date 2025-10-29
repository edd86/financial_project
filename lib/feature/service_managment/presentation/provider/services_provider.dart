import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/service_managment/data/repo/service_repo_impl.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_entity.dart';
import 'package:flutter/material.dart';

class ServicesProvider extends ChangeNotifier {
  Response<List<ServiceEntity>> _resService = Response.success([]);

  Response<List<ServiceEntity>> get resService => _resService;

  void setResService() async {
    _resService = await ServiceRepoImpl().getServices();
    notifyListeners();
  }

  Future<Response<ServiceEntity>> updateService(ServiceEntity service) async {
    final res = await ServiceRepoImpl().updateService(service);
    if (res.success) {
      setResService();
      return Response.success(res.data!, message: res.message);
    } else {
      _resService = Response.error(res.message);
      return Response.error(res.message);
    }
  }
}
