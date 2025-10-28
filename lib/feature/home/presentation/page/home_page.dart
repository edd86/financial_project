import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/home/presentation/widgets/carousel_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: GlobalWidgets.customDrawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.65.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/img/cpa_gif.gif'),
            SizedBox(height: 2.8.h),
            CarouselHomeWidget(),
            SizedBox(height: 2.8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40.w,
                  child: ExpansionTile(
                    title: Text(
                      'Obligaciones Tributarias',
                      style: TextStyle(fontSize: 13.7.sp),
                    ),
                    children: [
                      Text(
                        'Régimen General: emite factura, declara IVA, IT e IUE. Régimen Simplificado: no emite factura, paga cuota fija bimensual.',
                        style: TextStyle(fontSize: 12.5.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 40.w,
                  child: ExpansionTile(
                    title: Text(
                      'Ratios Financieros',
                      style: TextStyle(fontSize: 13.7.sp),
                    ),
                    children: [
                      Text(
                        'Miden la salud y el rendimiento de una empresa. Son útiles porque convierten datos contables brutos en indicadores claros para diagnosticar, comparar y tomar decisiones.',
                        style: TextStyle(fontSize: 12.5.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
