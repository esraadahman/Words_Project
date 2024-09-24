import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/model/word_model.dart';
import 'package:flutter_application_1/view/Screens/word_detail_screen.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';

class OneWordWidget extends StatelessWidget {
  const OneWordWidget({super.key, required this.word});
  final WordModel word;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => WordDetailScreen(word: word))))
            .then((value) async {
          Future.delayed(const Duration(milliseconds: 200)).then((value) {
            ReadDataCubit.get(context).getWords();
          });
          //   SnackBar(
          //       content: Text(
          //         "Word Deleted ",
          //         style: TextStyle(color: ColorManager.black),
          //       ),
          //       backgroundColor: ColorManager.white);
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 3, top: 5, bottom: 5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(word.colorCode),
        ),
        child: Center(
          child: Text(
            word.text,
            style: const TextStyle(
                color: ColorManager.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
