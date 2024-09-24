import 'package:flutter_application_1/enum/enumWords.dart';
import 'package:flutter_application_1/hive_constant.dart';
import 'package:flutter_application_1/model/word_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  ReadDataCubit() : super(ReadDataInitial());

  static ReadDataCubit get(context) => BlocProvider.of(context);

  // variables that i need
  final Box _box = Hive.box(HiveConstants.wordsBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;

  // methods

  // updates sorting types or langage
  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
    getWords();
  }

// get words
  void getWords() async {
    emit(ReadDataCubitLoadingState());
    try {
      List<WordModel> wordsToReturn =
          List.from(_box.get(HiveConstants.wordsList, defaultValue: []))
              .cast<WordModel>();
      _removeUnwantedWords(wordsToReturn);
      _applySorting(wordsToReturn);

      // for (var i = 0; i < wordsToReturn.length; i++) {
      //   print('==========================================');
      //   print(wordsToReturn[i].text);
      //   print(wordsToReturn[i].isArabic);
      //   print(wordsToReturn[i].indexAtDatabase);
      //   print(wordsToReturn[i].colorCode);
      // }

      emit(ReadDataCubitSuccessState(words: wordsToReturn));
    } catch (error) {
      emit(ReadDataCubitFailedState(
          message: "We have problems at get\nPlease try again"));
    }
  }

  // filter words list

  // remove unwanted list
  void _removeUnwantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  // sort list
  void _applySorting(List<WordModel> wordsToReturn) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.ascending) {
        return;
      }
      _reverse(wordsToReturn);
    } else {
      wordsToReturn.sort(
          (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length));
      if (sortingType == SortingType.ascending) {
        return;
      }
      _reverse(wordsToReturn);
    }
  }

  // reverse order
  void _reverse(List<WordModel> wordsToReturn) {
    for (var i = 0; i < wordsToReturn.length / 2; i++) {
      WordModel temp = wordsToReturn[i];
      wordsToReturn[i] = wordsToReturn[wordsToReturn.length - 1 - i];
      wordsToReturn[wordsToReturn.length - 1 - i] = temp;
    }
  }
}
