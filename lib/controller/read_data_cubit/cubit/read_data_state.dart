part of 'read_data_cubit.dart';

@immutable
sealed class ReadDataState {}

final class ReadDataInitial extends ReadDataState {}
class ReadDataCubitLoadingState extends ReadDataState{}

class ReadDataCubitSuccessState extends ReadDataState{
  final List<WordModel>words;
  ReadDataCubitSuccessState({required this.words});
}
class ReadDataCubitFailedState extends ReadDataState{
  final String message;
  ReadDataCubitFailedState({required this.message});
}