import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/core/response.dart';
import 'package:financial_project/feature/balance/data/repo/balance_sheet_repo_impl.dart';
import 'package:financial_project/feature/balance/domain/model/balance_client.dart';
import 'package:financial_project/feature/balance/domain/model/balance_sheet.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_sheet_list_provider.dart';
import 'package:financial_project/feature/balance/presentation/widget/alert_dialog_options.dart';
import 'package:financial_project/feature/balance/presentation/widget/balance_edit_modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceClientTile extends StatefulWidget {
  final BalanceSheet balanceSheet;
  final BalanceClient balanceClient;
  const BalanceClientTile({
    super.key,
    required this.balanceSheet,
    required this.balanceClient,
  });

  @override
  State<BalanceClientTile> createState() => _BalanceClientTileState();
}

class _BalanceClientTileState extends State<BalanceClientTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 9.68.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 8.75.w,
              child: Icon(
                Icons.balance,
                size: 20.78.sp,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(
              width: 38.83.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.balanceClient.businessName,
                    style: TextStyle(
                      fontSize: 14.78.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.balanceClient.nitCi,
                    style: TextStyle(
                      fontSize: 13.78.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.balanceSheet.period.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.78.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30.7.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 8.650.w,
                    height: 4.95.h,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, size: 17.78.sp),
                      color: Colors.white,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialogOptions(
                          balanceSheetId: widget.balanceSheet.id!,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 8.65.w,
                    height: 4.95.h,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit, size: 17.78.sp),
                      color: Colors.white,
                      onPressed: () => _showModalBottom(
                        widget.balanceSheet,
                        widget.balanceClient,
                      ),
                    ),
                  ),
                  Container(
                    width: 8.65.w,
                    height: 4.95.h,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.delete, size: 17.78.sp),
                      color: Colors.white,
                      onPressed: () async {
                        final res = await BalanceSheetRepoImpl()
                            .deleteBalanceSheet(widget.balanceSheet);
                        if (res.success) {
                          _updateProvider();
                        }
                        _showMessage(res);
                      },
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

  void _showMessage(Response res) {
    ScaffoldMessenger.of(context).showSnackBar(
      GlobalWidgets.customSnackBar(
        res.message,
        res.success ? Colors.deepPurple : Colors.redAccent,
      ),
    );
  }

  void _updateProvider() {
    Provider.of<BalanceSheetListProvider>(
      context,
      listen: false,
    ).getBalanceSheets();
  }

  void _showModalBottom(
    BalanceSheet balanceSheet,
    BalanceClient balanceClient,
  ) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
    ),
    builder: (context) => BalanceEditModalBottom(
      balanceClient: balanceClient,
      balanceSheet: balanceSheet,
    ),
  );
}
