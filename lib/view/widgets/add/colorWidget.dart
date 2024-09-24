import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({super.key, required this.activecolorcode});
  final int activecolorcode;

  final List<int> _colorCodes = const [
    0XFF4A47A3,
    0XFF0C7B93,
    0xFF892CDC,
    0XFFBC6FF1,
    0xFFF4ABC4,
    0XFFC70039,
    0xFF8FBC8F,
    0xFFFA8072,
    0XFF4D4C7D,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      height: 70,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => _getItemDesign(index, context),
          separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
          itemCount: _colorCodes.length),
    );
  }

  Widget _getItemDesign(int index, BuildContext context) {
    return InkWell(
      onTap: () =>
        WriteDataCubit.get(context).updateColorCode(_colorCodes[index]),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: activecolorcode == _colorCodes[index]
              ? Border.all(color: ColorManager.white, width: 2)
              : null,
          color: Color(_colorCodes[index]),
        ),
        child: activecolorcode == _colorCodes[index]
            ? const Center(
                child: Icon(
                  Icons.done,
                  color: ColorManager.white,
                ),
              )
            : null,
      ),
    );
  }
}
