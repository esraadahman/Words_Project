import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';
import 'package:flutter_application_1/view/widgets/add/arabic_or_english.dart';
import 'package:flutter_application_1/view/widgets/add/custom_form.dart';
import 'package:flutter_application_1/view/widgets/add/doneButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateWordDialog extends StatelessWidget {
  UpdateWordDialog(
      {super.key,
      required this.isExample,
      required this.colorCode,
      required this.indexAtDatabase});
  final bool isExample;
  final int colorCode;
  final int indexAtDatabase;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color(colorCode),
        child: BlocConsumer<WriteDataCubit, WriteDataState>(
          builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ArabicOrEnglish(
                      colorcode: colorCode,
                      isArabicSelected: WriteDataCubit.get(context).isArabic),
                  size.height(15),
                  CustomForm(
                      label: isExample ? "New Example" : "New Similar Word",
                      formkey: _formKey),
                  size.height(15),
                  Donebutton(
                    colorcode: colorCode,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (isExample) {
                          WriteDataCubit.get(context)
                              .addExample(indexAtDatabase);
                        } else {
                          WriteDataCubit.get(context)
                              .addSimilarWord(indexAtDatabase);
                        }
                        ReadDataCubit.get(context).getWords();
                      }
                    },
                  )
                ],
              ),
            );
          },
          listener: (BuildContext context, WriteDataState state) {
            if (state is WriteDataCubitSuccessState) {
              Navigator.pop(context);
            }
            if (state is WriteDataCubitFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: ColorManager.red,
                  content: Text(
                    state.message,
                  )));
            }
          },
        ));
  }
}
