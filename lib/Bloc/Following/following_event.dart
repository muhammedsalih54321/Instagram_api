part of 'following_bloc.dart';

@immutable
sealed class FollowingEvent {}
class FetchFollowingEvent extends FollowingEvent{
final String name;

  FetchFollowingEvent({required this.name});

}
