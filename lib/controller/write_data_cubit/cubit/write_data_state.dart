part of 'write_data_cubit.dart';

@immutable
sealed class WriteDataState {}

final class WriteDataInitial extends WriteDataState {}


class WriteDataCubitLoadingState extends WriteDataState{}
class WriteDataCubitSuccessState extends WriteDataState{}
class WriteDataCubitFailedState extends WriteDataState{
  final String message;
  WriteDataCubitFailedState({required this.message});
}