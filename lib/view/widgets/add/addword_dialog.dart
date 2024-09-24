import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';
import 'package:flutter_application_1/view/widgets/add/arabic_or_english.dart';
import 'package:flutter_application_1/view/widgets/add/colorWidget.dart';
import 'package:flutter_application_1/view/widgets/add/custom_form.dart';
import 'package:flutter_application_1/view/widgets/add/doneButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWordDialog extends StatelessWidget {
  AddWordDialog({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
        builder: (context, state) {
          return AnimatedContainer(
            decoration: BoxDecoration(
                color: Color(WriteDataCubit.get(context).colorCode),
                borderRadius: BorderRadius.circular(20)),
            duration: const Duration(milliseconds: 600),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  size.height(10),
                  ArabicOrEnglish(
                    colorcode: WriteDataCubit.get(context).colorCode,
                    isArabicSelected: WriteDataCubit.get(context).isArabic,
                  ),
                  ColorsWidget(
                      activecolorcode: WriteDataCubit.get(context).colorCode),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CustomForm(
                      label: "New Word",
                      formkey: formkey,
                    ),
                  ),
                  size.height(15),
                  Row(
                    children: [
                      size.width(250),
                      Donebutton(
                        colorcode: WriteDataCubit.get(context).colorCode,
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            WriteDataCubit.get(context).addWord();
                            ReadDataCubit.get(context).getWords();
                          }
                        },
                      ),
                    ],
                  ),
                  size.height(10),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is WriteDataCubitSuccessState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(_getSnackBar('Word Added Succesfully', true));
          }
          if (state is WriteDataCubitFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(_getSnackBar(state.message, false));
          }
        },
      ),
    );
  }

  SnackBar _getSnackBar(String message, bool success) => SnackBar(
        content: Text(
          message,
          style: TextStyle(
              color: success ? ColorManager.black : ColorManager.white),
        ),
        backgroundColor: success ? ColorManager.white : ColorManager.red,
      );
}
