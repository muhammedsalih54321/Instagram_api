part of 'highlight_bloc.dart';

@immutable
sealed class HighlightState {}

final class HighlightInitial extends HighlightState {}

class Highlightblocloading extends HighlightState {}

class Highlightblocloaded extends HighlightState {}

class Highlightblocerror extends HighlightState {}
