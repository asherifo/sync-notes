part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState {
  final List<NoteModel> note;

  HomeSuccess({required this.note});
}
final class HomeError extends HomeState {
  final String errorMsg;

  HomeError({required this.errorMsg});
}
final class DeleteNoteInitial extends HomeState {}
final class DeleteNoteLoading extends HomeState {}
final class DeleteNoteSuccess extends HomeState {

}
final class DeleteNoteError extends HomeState {
  final String errorMsg;

  DeleteNoteError({required this.errorMsg});

}