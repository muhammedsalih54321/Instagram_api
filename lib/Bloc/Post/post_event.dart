part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}
class Fetchpostevent extends PostEvent{
  final String name;

  Fetchpostevent({required this.name});
}