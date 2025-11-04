import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/service_managment/data/repo/service_repo_impl.dart';
import 'package:financial_project/feature/service_managment/domain/model/service_log_entity.dart';
import 'package:financial_project/feature/service_managment/presentation/provider/services_total_amount_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChargeHomePage extends StatefulWidget {
  const ChargeHomePage({super.key});

  @override
  State<ChargeHomePage> createState() => _ChargeHomePageState();
}

class _ChargeHomePageState extends State<ChargeHomePage> {
  @override
  Widget build(BuildContext context) {
    final totalAmountProvider = Provider.of<ServicesTotalAmountProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Cargos'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Consumer<ServicesTotalAmountProvider>(
            builder: (context, provider, child) {
              return Text(
                '${provider.totalAmount.toStringAsFixed(2)} bs.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.85.sp,
                ),
              );
            },
          ),
        ],
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: FutureBuilder(
        future: ServiceRepoImpl().getServicesLog(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            final resTmp = snapshot.data;
            return Center(child: Text(resTmp!.message));
          }
          final response = snapshot.data;
          if (response != null) {
            final services = response.data;
            if (services!.isEmpty) {
              return Center(child: Text(response.message));
            }
            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(services[index].clientName),
                  subtitle: Text(
                    services[index].serviceName.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.85.sp,
                    ),
                  ),
                  leading: Text(
                    '${services[index].serviceLog.amount.toStringAsFixed(2)} bs.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.85.sp,
                    ),
                  ),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        services[index].serviceLog.isPayed
                            ? Colors.grey[600]
                            : Colors.deepPurple,
                      ),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    child: services[index].serviceLog.isPayed
                        ? Text('Pagado')
                        : Text('Cobrar'),
                    onPressed: () async {
                      if (!services[index].serviceLog.isPayed) {
                        final res = await ServiceRepoImpl()
                            .updateServiceLogPayed(services[index].serviceLog);
                        if (res.success) {
                          totalAmountProvider.getTotalAmount();
                          setState(() {});
                        }
                        _showMessage(res);
                      }
                    },
                  ),
                );
              },
            );
          }
          return Center(child: Text('No existen registros'));
        },
      ),
    );
  }

  void _showMessage(Response<ServiceLogEntity> res) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        res.message,
        res.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }
}
