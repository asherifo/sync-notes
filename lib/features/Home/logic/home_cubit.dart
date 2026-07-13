import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:note_app/core/model/note_model.dart';
import 'package:note_app/features/CreateNote/logic/create_note_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Future getNotes() async{
    try{
    final response =  await FirebaseFirestore.instance.collection('notes').where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
     final result = response.docs.map((e){
       return NoteModel.fromJson((e.data()),e.id);

     }).toList();

    emit(HomeSuccess(note: result));
    }catch(e){
      emit(HomeError(errorMsg: e.toString()));
    }
  }
  /// Delete Note
  Future<void> deleteNote(String documentId)async{
    emit(DeleteNoteLoading());
    try{
      await FirebaseFirestore.instance.collection('notes').doc(documentId).delete();
      getNotes();

    }catch(e){
      emit(DeleteNoteError(errorMsg: e.toString()));
    }

  }

}
