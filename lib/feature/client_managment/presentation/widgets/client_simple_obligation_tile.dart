import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/utils.dart';
import 'package:financial_project/feature/client_managment/data/repo/client_repo_impl.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_obligation.dart';
import 'package:financial_project/feature/client_managment/domain/model/client_simplified_regime.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/clients_obligations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClientSimpleObligationTile extends StatefulWidget {
  final double capital;
  final ClientObligation obligation;
  const ClientSimpleObligationTile({
    super.key,
    required this.capital,
    required this.obligation,
  });

  @override
  State<ClientSimpleObligationTile> createState() =>
      _ClientSimpleObligationTileState();
}

class _ClientSimpleObligationTileState
    extends State<ClientSimpleObligationTile> {
  ClientSimplifiedRegime? simplifiedRegime;

  @override
  void initState() {
    super.initState();
    loadSimpleRegime();
  }

  @override
  Widget build(BuildContext context) {
    if (simplifiedRegime != null) {
      return Card(
        child: SizedBox(
          width: 80.w,
          height: 15.75.h,
          child: simplifiedRegime == null
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            simplifiedRegime!.category,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.75.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Inicio: ${Utils.dueDateString(widget.obligation.periodStart)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.55,
                                ),
                              ),
                              Text(
                                'Fin: ${Utils.dueDateString(widget.obligation.periodEnd)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.55,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Plazo: ${Utils.dueDateString(widget.obligation.dueDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.55,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                simplifiedRegime!.minCapital.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.95.sp,
                                ),
                              ),
                              Text(
                                simplifiedRegime!.maxCapital.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.95.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.obligation.status.toUpperCase(),
                            style: statusStyle(widget.obligation.status),
                          ),
                          Text(
                            widget.obligation.paymentAmount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.15.sp,
                            ),
                          ),
                          ElevatedButton(
                            child: Text('Pagar'),
                            onPressed: () async {
                              if (widget.obligation.status == 'pendiente') {
                                final res = await ClientRepoImpl()
                                    .updatePayedObligation(widget.obligation);
                                if (res.success) {
                                  _updateObligations();
                                }
                              } else {
                                _showMessage();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void loadSimpleRegime() async {
    final response = await ClientRepoImpl().getClientSimplifiedRegime(
      widget.capital,
    );
    if (response.success) {
      setState(() {
        simplifiedRegime = response.data!;
      });
    }
  }

  TextStyle statusStyle(String status) {
    switch (status) {
      case 'pendiente':
        return TextStyle(
          fontSize: 13.79.sp,
          fontWeight: FontWeight.w600,
          color: Colors.green,
        );
      case 'cumplido':
        return TextStyle(
          fontSize: 13.79.sp,
          fontWeight: FontWeight.w600,
          color: Colors.deepPurple,
        );
      case 'vencido':
        return TextStyle(
          fontSize: 13.79.sp,
          fontWeight: FontWeight.w600,
          color: Colors.redAccent,
        );
      default:
        return TextStyle(
          fontSize: 13.79.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black45,
        );
    }
  }

  void _showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar('Obligación ya cancelada', Colors.redAccent),
    );
  }

  void _updateObligations() {
    Provider.of<ClientsObligationsProvider>(
      context,
      listen: false,
    ).setClientObligations(widget.obligation.clientId);
  }
}
