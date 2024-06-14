part of 'info_bloc.dart';

@immutable
sealed class InfoEvent {}
class FetchinfoEvent extends InfoEvent{
final String name;

  FetchinfoEvent({required this.name});
  
}
