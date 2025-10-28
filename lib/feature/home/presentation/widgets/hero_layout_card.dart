import 'package:financial_project/feature/home/domain/model/image_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HeroLayoutCard extends StatelessWidget {
  final ImageData imageData;
  const HeroLayoutCard({required this.imageData, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        ClipRect(
          child: OverflowBox(
            maxWidth: 100.w * 7 / 8,
            minWidth: 100.w * 7 / 8,
            child: Image.asset(imageData.path, fit: BoxFit.cover, scale: 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                imageData.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: TextStyle(
                  fontSize: 17.85.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromARGB(120, 0, 0, 0),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                imageData.subtitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  backgroundColor: Color.fromARGB(120, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
