
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';

abstract class ThemeManager{

  static ThemeData getAppTheme(){
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.black,
      appBarTheme:const AppBarTheme(
        elevation: 0,
        color: ColorManager.black,
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
       // to change color of line that in time and icons 
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.black,
        ),
      ),
    );
  } 

}