import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/enum/enumWords.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorManager.black,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              // come from left
              crossAxisAlignment: CrossAxisAlignment.start,
              // make column hight fit content
              mainAxisSize: MainAxisSize.min,
              children: [
                _getlabeltext('Language'),
                size.height(10),
                _get_language(context),
                size.height(25),
                _getlabeltext('Sorted By'),
                size.height(10),
                _get_sorted_by(context),
                size.height(25),
                _getlabeltext('Sorting Type'),
                size.height(10),
                _get_sorting_type(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _get_sorting_type(BuildContext context) {
    return _getFilterField(
      labels: ["Ascending", "Descending"],
      onTabs: [
        () =>
            ReadDataCubit.get(context).updateSortingType(SortingType.ascending),
        () => ReadDataCubit.get(context)
            .updateSortingType(SortingType.descending),
      ],
      condtionOfActions: [
        ReadDataCubit.get(context).sortingType == SortingType.ascending,
        ReadDataCubit.get(context).sortingType == SortingType.descending,
      ],
    );
  }

  Widget _get_sorted_by(BuildContext context) {
    return _getFilterField(
      labels: ["Time", "Word Length"],
      onTabs: [
        () => ReadDataCubit.get(context).updateSortedBy(SortedBy.time),
        () => ReadDataCubit.get(context).updateSortedBy(SortedBy.wordLength),
      ],
      condtionOfActions: [
        ReadDataCubit.get(context).sortedBy == SortedBy.time,
        ReadDataCubit.get(context).sortedBy == SortedBy.wordLength,
      ],
    );
  }

  Widget _get_language(BuildContext context) {
    return _getFilterField(
      labels: ["Arabic", "English", "All"],
      onTabs: [
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.arabicOnly),
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.englishOnly),
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.allWords),
      ],
      condtionOfActions: [
        ReadDataCubit.get(context).languageFilter == LanguageFilter.arabicOnly,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.englishOnly,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.allWords,
      ],
    );
  }

// text of labels
  Widget _getlabeltext(String labeltext) {
    return Text(
      labeltext,
      style: const TextStyle(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  // buttons and actions of them
  Widget _getFilterField(
      {required List<String> labels,
      required List<VoidCallback> onTabs,
      required List<bool> condtionOfActions}) {
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          InkWell(
            onTap: onTabs[i],
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: ColorManager.white),
                color: condtionOfActions[i]
                    ? ColorManager.white
                    : ColorManager.black,
              ),
              child: Center(
                child: Text(
                  labels[i],
                  style: TextStyle(
                    color: condtionOfActions[i]
                        ? ColorManager.black
                        : ColorManager.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
