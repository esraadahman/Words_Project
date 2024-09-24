import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';

class ArabicOrEnglish extends StatelessWidget {
  final int colorcode;
  final bool isArabicSelected;
  const ArabicOrEnglish(
      {super.key, required this.colorcode, required this.isArabicSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        _getContainerDesign(true, context),
        size.width(10),
        _getContainerDesign(false, context),
      ],
    );
  }

  InkWell _getContainerDesign(bool buildIsArabic, BuildContext context) {
    return InkWell(
      onTap: () => WriteDataCubit.get(context).updateIsArabic(buildIsArabic),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: ColorManager.white),
          color: buildIsArabic == isArabicSelected
              ? ColorManager.white
              : Color(colorcode),
        ),
        child: Center(
          child: Text(
            buildIsArabic ? "ar" : "en",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !(buildIsArabic == isArabicSelected)
                  ? ColorManager.white
                  : Color(colorcode),
            ),
          ),
        ),
      ),
    );
  }
}
