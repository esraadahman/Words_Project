import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:flutter_application_1/enum/enumWords.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit,ReadDataState>(
         builder: (context, state) {
        return Text(
          _mapLanguageFilterEnumToString(ReadDataCubit.get(context).languageFilter),
          style: const TextStyle(
            color: ColorManager.white,
            fontSize: 21,
            fontWeight: FontWeight.bold
          ),
        );
      },
    );
  }

  String _mapLanguageFilterEnumToString(LanguageFilter languageFilter){
    if(languageFilter==LanguageFilter.allWords){
      return "All Words";
    }else if(languageFilter==LanguageFilter.englishOnly){
      return "English Only";
    }else{
      return "Arabic Only";
    }
  }
}