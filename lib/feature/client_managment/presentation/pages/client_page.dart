import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_obligation.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_obligations_provider.dart';
import 'package:financial_project/feature/client_managment/presentation/widgets/client_detail.dart';
import 'package:financial_project/feature/client_managment/presentation/widgets/client_general_obligation_tile.dart';
import 'package:financial_project/feature/client_managment/presentation/widgets/client_simple_obligation_tile.dart';
import 'package:financial_project/feature/service_managment/data/repo/service_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClientPage extends StatefulWidget {
  final Client client;
  const ClientPage({super.key, required this.client});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  void initState() {
    super.initState();
    // Cargar las obligaciones al inicializar el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClientsObligationsProvider>(
        context,
        listen: false,
      ).setClientObligations(widget.client.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientObligationProvider = Provider.of<ClientsObligationsProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.85.w, vertical: 2.75.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 5.98.h,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Center(
                child: Text(
                  widget.client.businessName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.client.businessName.length <= 10
                        ? 18.89.sp
                        : 15.89.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.75.h,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 1.5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClientDetails(
                      subtitle: 'Nit - CI:',
                      detail: widget.client.taxId,
                    ),
                    ClientDetails(
                      detail: widget.client.regimeType.toUpperCase(),
                      subtitle: 'Regimen:',
                    ),
                    ClientDetails(
                      detail: widget.client.capital.toString(),
                      subtitle: 'Capital:',
                    ),
                    ClientDetails(
                      detail: widget.client.activity?.toUpperCase() ?? 'N/A',
                      subtitle: 'Actividad:',
                    ),
                    ClientDetails(
                      detail: widget.client.description ?? 'N/A',
                      subtitle: 'Descripción:',
                    ),
                    ClientDetails(
                      detail: widget.client.baseProductPrice != null
                          ? widget.client.baseProductPrice.toString()
                          : 'N/A',
                      subtitle: 'Producto promedio:',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                label: Text('Asignar Obligación'),
                icon: Icon(Icons.assignment),
                onPressed: () async {
                  if (Utils.hasObligationsPermissions()) {
                    if (widget.client.regimeType == 'simplificado') {
                      final response = await ClientRepoImpl()
                          .assignClientSimpleObligation(widget.client);
                      if (response.success) {
                        clientObligationProvider.setClientObligations(
                          widget.client.id!,
                        );
                        final resServiceLog = await ServiceRepoImpl()
                            .addServiceLog(widget.client.id!, 'obligaciones');
                        if (!resServiceLog.success) {
                          _showMessage(Response.error(resServiceLog.message));
                        }
                      }
                      _showMessage(response);
                    } else {
                      _generalFormPage(widget.client);
                    }
                  } else {
                    _showMessage(
                      Response(
                        success: false,
                        message:
                            'No tiene permiso para ejecutar esta funcionalidad.',
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Consumer<ClientsObligationsProvider>(
                builder: (context, provider, child) {
                  // Verificar si está cargando
                  if (provider.clientObligations == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final obligations = provider.clientObligations?.data ?? [];
                  if (obligations.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.assignment_outlined,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No se asignaron obligaciones a la empresa',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Actualizar'),
                            onPressed: () {
                              Provider.of<ClientsObligationsProvider>(
                                context,
                                listen: false,
                              ).setClientObligations(widget.client.id!);
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return widget.client.regimeType == 'simplificado'
                        ? ListView.builder(
                            itemCount: obligations.length,
                            itemBuilder: (context, index) {
                              return ClientSimpleObligationTile(
                                capital: widget.client.capital,
                                obligation: obligations[index],
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: obligations.length,
                            itemBuilder: (context, index) {
                              return ClientGeneralObligationTile(
                                capital: widget.client.capital,
                                obligation: obligations[index],
                              );
                            },
                          );
                  }
                  //}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(Response<ClientObligation> response) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        response.message,
        response.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _generalFormPage(Client client) {
    Navigator.pushNamed(
      context,
      AppRoutes.clientGeneralForm,
      arguments: client,
    );
  }
}
