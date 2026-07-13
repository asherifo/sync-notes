import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:note_app/core/model/note_model.dart';

part 'create_note_state.dart';

class CreateNoteCubit extends Cubit<CreateNoteState> {
  CreateNoteCubit() : super(CreateNoteInitial());

  Future createNote(NoteModel note)async{
      emit(CreateNoteLoading());
      try{
       await FirebaseFirestore.instance.collection('notes').add(note.toJson());
       emit(CreateNoteSuccess());

      }catch(e){
        emit(CreateNoteError(errorMsg: e.toString()));
      }

  }

  Future<void> updateNote(NoteModel note)async{
    emit(CreateNoteLoading());
    try{
      await FirebaseFirestore.instance.collection('notes').doc(note.id).update(note.toJson());
      emit(CreateNoteSuccess());

    }catch(e){
      emit(CreateNoteError(errorMsg: e.toString()));
    }
  }


}
