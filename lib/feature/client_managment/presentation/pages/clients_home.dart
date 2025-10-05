import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_home_provider.dart';
import 'package:financial_project/feature/client_managment/presentation/widgets/client_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClientsHome extends StatelessWidget {
  const ClientsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 1.75.h);
    final heightCard = 100.h / 3.95;
    final clientsHomeProvider = Provider.of<ClientsHomeProvider>(
      context,
      listen: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clientes',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.searchClient),
          ),
        ],
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 1.75.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nuevos clientes',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 13.89.sp, fontWeight: FontWeight.w500),
            ),
            spacer,
            SizedBox(
              height: heightCard,
              child:
                  clientsHomeProvider.clientsHome?.newClients.isNotEmpty == true
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          clientsHomeProvider.clientsHome?.newClients.length ??
                          0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.clientPage,
                            arguments: clientsHomeProvider
                                .clientsHome!
                                .newClients[index],
                          ),
                          child: ClientCard(
                            client: clientsHomeProvider
                                .clientsHome!
                                .newClients[index],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No hay clientes registrados.')),
            ),
            spacer,
            Text(
              'Régimen simplificado',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 13.89.sp, fontWeight: FontWeight.w500),
            ),
            spacer,
            SizedBox(
              height: heightCard,
              child:
                  clientsHomeProvider
                          .clientsHome
                          ?.simplifiedClients
                          .isNotEmpty ==
                      true
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          clientsHomeProvider
                              .clientsHome
                              ?.simplifiedClients
                              .length ??
                          0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.clientPage,
                            arguments: clientsHomeProvider
                                .clientsHome!
                                .simplifiedClients[index],
                          ),
                          child: ClientCard(
                            client: clientsHomeProvider
                                .clientsHome!
                                .simplifiedClients[index],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No hay clientes registrados.')),
            ),
            spacer,
            Text(
              'Régimen General',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 13.89.sp, fontWeight: FontWeight.w500),
            ),
            spacer,
            SizedBox(
              height: heightCard,
              child:
                  clientsHomeProvider.clientsHome?.generalClients.isNotEmpty ==
                      true
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          clientsHomeProvider
                              .clientsHome
                              ?.generalClients
                              .length ??
                          0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.clientPage,
                            arguments: clientsHomeProvider
                                .clientsHome!
                                .generalClients[index],
                          ),
                          child: ClientCard(
                            client: clientsHomeProvider
                                .clientsHome!
                                .generalClients[index],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No hay clientes registrados.')),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.clientForm);
        },
      ),
    );
  }
}
