import 'dart:ui';
import 'package:flutter_application_1/hive_constant.dart';
import 'package:flutter_application_1/model/word_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitial());
  static WriteDataCubit get(context) => BlocProvider.of(context);

  // variables that i need
  final Box box = Hive.box(HiveConstants.wordsBox);

  String text = "";
  bool isArabic = true;
  int colorCode = 0XFF4A47A3;

  // methods

  // update text

  void updateText(String text) {
    this.text = text;
    emit(WriteDataInitial());
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataInitial());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataInitial());
  }

  // add word
  void addWord() {
    _tryAndCatchBlock(() {
      // throw Exception();
      List<WordModel> words = _getWordsFromDataBase();
      words.add(WordModel(
          indexAtDatabase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode));
      box.put(HiveConstants.wordsList, words);
    }, "We Have problems when we add word,Please try again");
  }

  // delete word from list
  void deleteWord(int indexAtDatabase) {
    _tryAndCatchBlock(
      () {
        List<WordModel> words = _getWordsFromDataBase();
        words.removeAt(indexAtDatabase);
        for (var i = indexAtDatabase; i < words.length; i++) {
          words[i] = words[i].decrementIndexAtDataBase();
        }
        box.put(HiveConstants.wordsList, words);
      },
      "We Have problems when we Delete word,Please try again",
    );
  }

  // repated methods
  //  try and catch
  void _tryAndCatchBlock(VoidCallback methodToExcute, String message) {
    emit(WriteDataCubitLoadingState());
    try {
      methodToExcute.call();
      emit(WriteDataCubitSuccessState());
    } catch (error) {
      emit(WriteDataCubitFailedState(message: message));
    }
  }

  //get data from wordslist and caste it
  List<WordModel> _getWordsFromDataBase() =>
      List.from(box.get(HiveConstants.wordsList, defaultValue: []))
          .cast<WordModel>();

// add similar word

  void addSimilarWord(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addSimilarWord(text, isArabic);
      box.put(HiveConstants.wordsList, words);
    }, "We Have problems when we add similar word,Please try again");
  }

  // delete similar word

  void deleteSimilarWord(
      int indexAtDatabase, int indexAtSimilarWord, bool isArabicSimilarWord) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteSimilarWord(indexAtSimilarWord, isArabicSimilarWord);
      box.put(HiveConstants.wordsList, words);
    }, "We Have problems when we delete similar word,Please try again");
  }

  // add example

  void addExample(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addExample(text, isArabic);
      box.put(HiveConstants.wordsList, words);
    }, "We Have problems when we add example,Please try again");
  }

  // delete example

  void deleteExample(
      int indexAtDatabase, int indexAtExamples, bool isArabicExample) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteExample(indexAtExamples, isArabicExample);
      box.put(HiveConstants.wordsList, words);
    }, "We Have problems when we delete Example,Please try again");
  }
}
