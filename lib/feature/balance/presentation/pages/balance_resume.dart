import 'package:financial_project/feature/balance/data/repo/balance_sheet_repo_impl.dart';
import 'package:financial_project/feature/balance/presentation/pages/balance_assets_page.dart';
import 'package:financial_project/feature/balance/presentation/pages/balance_liabilities_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  final String category;
  final double value;

  _ChartData(this.category, this.value);
}

class BalanceResume extends StatelessWidget {
  final int balanceId;
  const BalanceResume({required this.balanceId, super.key});

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(height: 2.5.h);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resumen',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.5.sp),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: BalanceSheetRepoImpl().getBalanceResume(balanceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            final balanceResume = snapshot.data!.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balance General',
                    style: TextStyle(
                      fontSize: 18.75.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spacer,
                  Card(
                    child: SizedBox(
                      height: 10.75.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.2.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Activos',
                                  style: TextStyle(fontSize: 16.85.sp),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.launch,
                                    size: 15.65.sp,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BalanceAssetsPage(
                                        balanceId: balanceId,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${balanceResume!.totalAssets} bs.',
                              style: TextStyle(
                                fontSize: 20.78.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  spacer,
                  Card(
                    child: SizedBox(
                      height: 10.75.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.2.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pasivos',
                                  style: TextStyle(fontSize: 16.85.sp),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.launch,
                                    size: 15.65.sp,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BalanceLiabilitiesPage(
                                            balanceId: balanceId,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${balanceResume.totalLiabilities} bs.',
                              style: TextStyle(
                                fontSize: 20.78.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  spacer,
                  Card(
                    child: SizedBox(
                      height: 10.75.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.2.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Patrimonio neto',
                              style: TextStyle(fontSize: 16.85.sp),
                            ),
                            Text(
                              '${balanceResume.totalEquity} bs.',
                              style: TextStyle(
                                fontSize: 20.78.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  spacer,
                  Text(
                    'Activos vs Pasivos',
                    style: TextStyle(
                      fontSize: 18.75.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: 25.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 1.5.h,
                          horizontal: 5.w,
                        ),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                            interval:
                                balanceResume.totalAssets >
                                    balanceResume.totalLiabilities
                                ? balanceResume.totalAssets / 10
                                : balanceResume.totalLiabilities / 10,
                            maximum:
                                balanceResume.totalAssets >
                                    balanceResume.totalLiabilities
                                ? balanceResume.totalAssets
                                : balanceResume.totalLiabilities,
                          ),
                          series: <CartesianSeries>[
                            ColumnSeries<_ChartData, String>(
                              dataSource: [
                                _ChartData(
                                  'Activos',
                                  balanceResume.totalAssets,
                                ),
                                _ChartData(
                                  'Pasivos',
                                  balanceResume.totalLiabilities,
                                ),
                              ],
                              xValueMapper: (_ChartData data, _) =>
                                  data.category,
                              yValueMapper: (_ChartData data, _) => data.value,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  spacer,
                  Text(
                    'Indicadores financieros',
                    style: TextStyle(
                      fontSize: 18.75.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spacer,
                  Card(
                    child: SizedBox(
                      height: 25.75.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.2.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Razón de liquidez',
                              style: TextStyle(fontSize: 16.85.sp),
                            ),
                            Text(
                              balanceResume.totalLiabilities == 0
                                  ? 'N/A'
                                  : (balanceResume.totalAssets /
                                            balanceResume.totalLiabilities)
                                        .toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 20.78.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Razón de endeudamiento',
                              style: TextStyle(fontSize: 16.85.sp),
                            ),
                            Text(
                              balanceResume.totalAssets == 0
                                  ? 'N/A'
                                  : (balanceResume.totalLiabilities /
                                            balanceResume.totalAssets)
                                        .toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 20.78.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.2.w),
                      child: Text(
                        'Estos indicadores muestran la salud financiera de la empresa, con un ratio de liquidez y endeudamiento que indican su capacidad para cubrir sus obligaciones y generar ingresos.',
                        style: TextStyle(
                          fontSize: 13.85.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text(snapshot.error.toString()));
          }
        },
      ),
    );
  }
}
