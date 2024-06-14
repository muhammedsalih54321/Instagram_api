part of 'following_bloc.dart';

@immutable
sealed class FollowingState {}

final class FollowingInitial extends FollowingState {}
class Followingblocloading extends FollowingState {}
class Followingblocloaded extends FollowingState {}
class Followingblocerror extends FollowingState {}
