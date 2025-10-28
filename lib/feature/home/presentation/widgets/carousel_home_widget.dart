import 'package:financial_project/feature/home/domain/model/image_data.dart';
import 'package:financial_project/feature/home/presentation/widgets/hero_layout_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarouselHomeWidget extends StatefulWidget {
  const CarouselHomeWidget({super.key});

  @override
  State<CarouselHomeWidget> createState() => _CarouselHomeWidgetState();
}

class _CarouselHomeWidgetState extends State<CarouselHomeWidget> {
  final CarouselController _carouselController = CarouselController(
    initialItem: 1,
  );

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 20.h),
      child: CarouselView.weighted(
        controller: _carouselController,
        itemSnapping: true,
        flexWeights: const <int>[1, 7, 1],
        children: ImageData.values.map((ImageData imageData) {
          return HeroLayoutCard(imageData: imageData);
        }).toList(),
      ),
    );
  }
}
