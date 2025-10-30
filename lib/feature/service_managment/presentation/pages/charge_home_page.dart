import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/service_managment/data/repo/service_repo_impl.dart';
import 'package:flutter/material.dart';

class ChargeHomePage extends StatefulWidget {
  const ChargeHomePage({super.key});

  @override
  State<ChargeHomePage> createState() => _ChargeHomePageState();
}

class _ChargeHomePageState extends State<ChargeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cargos'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
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
                  subtitle: Text(services[index].serviceName),
                  leading: Text(services[index].serviceLog.amount.toString()),
                );
              },
            );
          }
          return Center(child: Text('No existen registros'));
        },
      ),
    );
  }
}
