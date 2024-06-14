part of 'followers_bloc.dart';

@immutable
sealed class FollowersEvent {}
class FetchFollowerEvent extends FollowersEvent{
  final String name;

  FetchFollowerEvent({required this.name});
} 
