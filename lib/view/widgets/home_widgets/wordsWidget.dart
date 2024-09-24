import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/model/word_model.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/widgets/home_widgets/exception_widget.dart';
import 'package:flutter_application_1/view/widgets/home_widgets/one_word_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wordswidget extends StatelessWidget {
  const Wordswidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        if (state is ReadDataCubitFailedState) {
          return ExceptionWidget(
            iconData: Icons.error,
            message: state.message,
          );
        } else if (state is ReadDataCubitSuccessState) {
          if (state.words.isEmpty) {
            return const ExceptionWidget(
                iconData: Icons.list_outlined, message: "Empty Words List");
          } else {
            return _get_words_correct_and_not_empty(state.words);
          }
        } else {
          return const CircularProgressIndicator(
            color: ColorManager.white,
          );
        }
      },
    );
  }

  GridView _get_words_correct_and_not_empty(List<WordModel> words) {
    return GridView.builder(
      itemCount: words.length,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        // number of elements in one row
        crossAxisCount: 2,
        // space between coulmn
        // crossAxisSpacing: 20,
        // // space between rows
        // mainAxisSpacing: 20,
        // // persent higth to width
        childAspectRatio: 2 / 1.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return OneWordWidget(word: words[index]);
      },
    );
  }
}
