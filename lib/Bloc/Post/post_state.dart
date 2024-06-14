part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}
class Postblocloading extends PostState {}
class Postblocloaded extends PostState {}
class Postblocerror extends PostState {}
