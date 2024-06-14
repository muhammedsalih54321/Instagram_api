part of 'info_bloc.dart';

@immutable
sealed class InfoState {}

final class InfoInitial extends InfoState {}
class Infoblocloading extends InfoState {}
class Infoblocloaded extends InfoState {}
class Infoblocerror extends InfoState {}
