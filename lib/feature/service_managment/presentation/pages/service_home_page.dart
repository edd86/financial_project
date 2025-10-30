import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/service_managment/presentation/provider/services_provider.dart';
import 'package:financial_project/feature/service_managment/presentation/widgets/services_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceHomePage extends StatefulWidget {
  const ServiceHomePage({super.key});

  @override
  State<ServiceHomePage> createState() => _ServiceHomePageState();
}

class _ServiceHomePageState extends State<ServiceHomePage> {
  @override
  void initState() {
    super.initState();
    // Llamar al método después de que el widget se haya construido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServicesProvider>(context, listen: false).setResService();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: Consumer<ServicesProvider>(
        builder: (context, provider, child) {
          final servicesRes = provider.resService;
          if (servicesRes.success) {
            final services = provider.resService.data;
            if (services!.isEmpty) {
              return Center(child: Text('No existen servicios registrados'));
            }
            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServicesTile(service: services[index]);
              },
            );
          }
          return Center(child: Text(servicesRes.message));
        },
      ),
    );
  }
}
