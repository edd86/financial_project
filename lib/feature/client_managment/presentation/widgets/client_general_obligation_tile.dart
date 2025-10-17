import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_general_regime.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_obligation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClientGeneralObligationTile extends StatefulWidget {
  final double capital;
  final ClientObligation obligation;
  const ClientGeneralObligationTile({
    super.key,
    required this.capital,
    required this.obligation,
  });

  @override
  State<ClientGeneralObligationTile> createState() =>
      _ClientGeneralObligationTileState();
}

class _ClientGeneralObligationTileState
    extends State<ClientGeneralObligationTile> {
  ClientGeneralRegime? generalRegime;
  bool isLoading = true;

  //TODO: Se queda en constante carga cuando hay datos

  @override
  void initState() {
    super.initState();
    loadGeneralRegime();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Card(
        child: SizedBox(
          width: 80.w,
          height: 15.75.h,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Card(
      child: SizedBox(
        width: 80.w,
        height: 15.75.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 18.75.w,
              child: Center(
                child: Text(
                  generalRegime?.name ?? 'N/A',
                  style: TextStyle(
                    fontSize: 15.85.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 65.8.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Periodicidad: ${generalRegime?.periodicity ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Fecha: ${Utils.dueDateString(widget.obligation.dueDate)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Porcentaje: ${generalRegime?.percentage != null ? generalRegime!.percentage.toStringAsFixed(0) : 'N/A'}%',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Monto: ${widget.obligation.paymentAmount}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadGeneralRegime() async {
    final response = await ClientRepoImpl().getClientGeneralRegime(
      widget.obligation.generalId!,
    );
    if (response.success) {
      setState(() {
        generalRegime = response.data!;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
