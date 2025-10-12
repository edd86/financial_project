import 'package:financial_project/feature/balance/domain/model/balance_asset.dart';
import 'package:financial_project/feature/balance/presentation/provider/balance_assets_provider.dart';
import 'package:financial_project/feature/balance/presentation/widget/balance_asset_modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BalanceAssetsPage extends StatelessWidget {
  final int balanceId;
  const BalanceAssetsPage({required this.balanceId, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BalanceAssetsProvider>().setBalanceAssets(balanceId);
    return Scaffold(
      appBar: AppBar(title: Text('Balance General'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.78.w),
        child: Column(
          children: [
            Text(
              'Activos',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.15.h),
            Expanded(
              child: Consumer<BalanceAssetsProvider>(
                builder: (context, snapshot, child) {
                  final balanceAssetRes = snapshot.balanceAssets;
                  if (!balanceAssetRes.success) {
                    return Center(child: Text(balanceAssetRes.message));
                  }
                  final assets = balanceAssetRes.data ?? [];
                  return ListView.builder(
                    itemCount: assets.length,
                    itemBuilder: (context, index) {
                      final asset = snapshot.balanceAssets.data?[index];
                      return ListTile(
                        title: Text(
                          asset?.name ?? '',
                          style: TextStyle(
                            fontSize: 15.25.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${asset?.amount ?? ''} bs.',
                          style: TextStyle(
                            fontSize: 14.25.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: Colors.black54,
                          ),
                          onPressed: () => _showBalanceForm(context, asset!),
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

  void _showBalanceForm(BuildContext context, BalanceAsset asset) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (context) {
        return BalanceAssetModalBottom(balanceAsset: asset);
      },
    );
  }
}
