import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:flutter_application_1/enum/enumWords.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.label, required this.formkey});
  final String label;
  final GlobalKey<FormState> formkey;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: TextFormField(
        // when reload widget autofocus in textfiled
        autofocus: true,
         // change color of | when typing
        cursorColor: ColorManager.white,
        controller: textEditingController,
          maxLines: 2,
        minLines: 1,
        // send update to cubit every time you add char
        onChanged: (value) => WriteDataCubit.get(context).updateText(value),
        // check validate to you text
        validator: (value) {
          return _validator(value, WriteDataCubit.get(context).isArabic);
        },
       
        
      
        style: const TextStyle(color: ColorManager.white, fontSize: 20),
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: const TextStyle(color: ColorManager.white),
          ),
          hintText: widget.label,

          // enabledBorder:  in form,
          // focusedBorder:  in enteraction with textfiled,
          // errorBorder:  in error case,
          // focusedErrorBorder:  in error case and enter action with user,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: ColorManager.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: ColorManager.white, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ColorManager.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ColorManager.red, width: 2)),
        ),
      ),
    );
  }

  String? _validator(String? value, bool isArabic) {
    if (value == null || value.trim().isEmpty) {
      return "This Field Has not to be empty";
    }
    for (var i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notValid) {
        return "Char  ${value[i]} Not Valid";
      } else if (charType == CharType.arabic && isArabic == false) {
        return "Char  '${value[i]}' is not english Char";
      } else if (charType == CharType.english && isArabic == true) {
        return "Char '${value[i]}' is not arabic Char";
      }
    }
    return null;
  }

  CharType _getCharType(int asciiCode) {
    if ((asciiCode >= 65 && asciiCode <= 90) ||
        (asciiCode >= 97 && asciiCode <= 122)) {
      return CharType.english;
    } else if (asciiCode >= 1569 && asciiCode <= 1610) {
      return CharType.arabic;
    } else if (asciiCode == 32) {
      return CharType.space;
    }
    return CharType.notValid;
  }
}






