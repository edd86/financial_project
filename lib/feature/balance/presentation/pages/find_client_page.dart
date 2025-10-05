import 'package:financial_project/feature/balance/domain/model/balance_client.dart';
import 'package:financial_project/feature/balance/presentation/provider/clients_list_provider.dart';
import 'package:financial_project/feature/balance/presentation/widget/balance_modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FindClientPage extends StatefulWidget {
  const FindClientPage({super.key});

  @override
  State<FindClientPage> createState() => _FindClientPageState();
}

class _FindClientPageState extends State<FindClientPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar la búsqueda con cadena vacía para limpiar resultados anteriores
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientsListProvider>().setClients('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.95.w, vertical: 1.75.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar cliente',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<ClientsListProvider>().setClients('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                context.read<ClientsListProvider>().setClients(value);
              },
            ),
            SizedBox(height: 2.75.h),
            Expanded(
              child: Consumer<ClientsListProvider>(
                builder: (context, provider, child) {
                  final clients = provider.clients;
                  if (_searchController.text.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text('Ingrese un nombre para buscar clientes'),
                        ],
                      ),
                    );
                  } else if (clients.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 50,
                            color: Colors.orange,
                          ),
                          SizedBox(height: 10),
                          Text('No se encontraron clientes con ese nombre'),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: clients.length,
                    itemBuilder: (context, index) {
                      final client = clients[index];
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              client.businessName.substring(0, 1).toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            client.businessName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            _showBalanceForm(client);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBalanceForm(BalanceClient client) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        return BalanceModalBottom(client.id);
      },
    );
  }
}

/* void _showBalanceForm(BuildContext context, Client client) {.
    
  } */
