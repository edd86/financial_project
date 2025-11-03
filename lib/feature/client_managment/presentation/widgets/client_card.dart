// ignore_for_file: use_build_context_synchronously

import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  ClientCard({super.key, required this.client});

  final widthCard = 100.w / 2.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthCard,
      child: Card(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    client.businessName,
                    style: TextStyle(
                      fontSize: 13.95.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    client.taxId,
                    style: TextStyle(
                      fontSize: 13.8.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    client.regimeType.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13.8.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  client.activity == null
                      ? Text('')
                      : Text(
                          client.activity!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 13.8.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
            Positioned(
              bottom: 0.5.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 17.75.sp),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 17.75.sp),
                    onPressed: () async {
                      final response = await ClientRepoImpl().deleteClient(
                        client,
                      );
                      if (response.success) {
                        Provider.of<ClientsHomeProvider>(
                          context,
                          listen: false,
                        ).setClientsHome();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        GlobalWidgets.customSnackBar(
                          response.message,
                          response.success
                              ? Colors.deepPurple
                              : Colors.redAccent,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
