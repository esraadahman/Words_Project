import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controller/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:flutter_application_1/model/word_model.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';
import 'package:flutter_application_1/view/widgets/home_widgets/exception_widget.dart';
import 'package:flutter_application_1/view/widgets/word_detail_screen/update_Word_dialog.dart';
import 'package:flutter_application_1/view/widgets/word_detail_screen/update_word_button.dart';
import 'package:flutter_application_1/view/widgets/word_detail_screen/word_infoWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordDetailScreen extends StatefulWidget {
  const WordDetailScreen({super.key, required this.word});
  final WordModel word;

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  late WordModel _wordModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wordModel = widget.word;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: (context, state) {
          if (state is ReadDataCubitSuccessState) {
      int index=      state.words.indexWhere((element) =>
                element.indexAtDatabase == _wordModel.indexAtDatabase);
            _wordModel = state.words[index];
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _getLabelText('Word'),
                size.height(10),
                WordInfowidget(
                  color: Color(_wordModel.colorCode),
                  text: _wordModel.text,
                  isArabic: _wordModel.isArabic,
                ),
                size.height(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getLabelText('Similar Words'),
                    UpdateWordButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => UpdateWordDialog(
                                  isExample: false,
                                  colorCode: _wordModel.colorCode,
                                  indexAtDatabase: _wordModel.indexAtDatabase,
                                ));
                      },
                      color: Color(_wordModel.colorCode),
                    ),
                  ],
                ),
                size.height(15),
                for (int i = 0; i < _wordModel.arabicSimilarWords.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WordInfowidget(
                      color: Color(_wordModel.colorCode),
                      isArabic: true,
                      text: _wordModel.arabicSimilarWords[i],
                      onPressed: () => _deleteArabicSimilarWord(i, context),
                    ),
                  ),
                //size.height(10),
                for (int i = 0; i < _wordModel.englishSimilarWords.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WordInfowidget(
                      color: Color(_wordModel.colorCode),
                      isArabic: false,
                      text: _wordModel.englishSimilarWords[i],
                      onPressed: () => _deleteEnglishSimilarWord(i, context),
                    ),
                  ),
                size.height(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getLabelText('Examples'),
                    UpdateWordButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => UpdateWordDialog(
                                  isExample: true,
                                  colorCode: _wordModel.colorCode,
                                  indexAtDatabase: _wordModel.indexAtDatabase,
                                ));
                      },
                      color: Color(_wordModel.colorCode),
                    ),
                  ],
                ),
                size.height(15),
                for (int i = 0; i < _wordModel.arabicExamples.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WordInfowidget(
                      color: Color(_wordModel.colorCode),
                      isArabic: true,
                      text: _wordModel.arabicExamples[i],
                      onPressed: () => _deleteArabicExample(i, context),
                    ),
                  ),
                for (int i = 0; i < _wordModel.englishExamples.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WordInfowidget(
                      color: Color(_wordModel.colorCode),
                      isArabic: false,
                      text: _wordModel.englishExamples[i],
                      onPressed: () => _deleteEnglishExample(i, context),
                    ),
                  ),
              ],
            );
          } else if (state is ReadDataCubitFailedState) {
            return ExceptionWidget(
                iconData: Icons.error, message: state.message);
          } else {
            return CircularProgressIndicator(
              color: ColorManager.white,
            );
          }
        },
      ),
    );
  }

  AppBar _getAppBar(context) => AppBar(
        // color for all icons in app bar
        foregroundColor: Color(_wordModel.colorCode),
        title: Text(
          "Word Details",
          style: TextStyle(
            color: Color(_wordModel.colorCode),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // delete _wordModel
              WriteDataCubit.get(context)
                  .deleteWord(_wordModel.indexAtDatabase);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
            ),
          )
        ],
      );

// main titles
  Widget _getLabelText(String label) => Row(
        children: [
          size.width(5),
          Text(
            label,
            style: TextStyle(
              color: Color(_wordModel.colorCode),
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  void _deleteEnglishExample(int index, BuildContext context) {
    WriteDataCubit.get(context).deleteExample(
      _wordModel.indexAtDatabase,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteArabicExample(int index, BuildContext context) {
    WriteDataCubit.get(context).deleteExample(
      _wordModel.indexAtDatabase,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteEnglishSimilarWord(int index, BuildContext context) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexAtDatabase,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteArabicSimilarWord(int index, BuildContext context) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexAtDatabase,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }
}
