part of 'followers_bloc.dart';

@immutable
sealed class FollowersState {}

final class FollowersInitial extends FollowersState {}

class Followersblocloading extends FollowersState {}

class Followersblocloaded extends FollowersState {}

class Followersblocerror extends FollowersState {}
