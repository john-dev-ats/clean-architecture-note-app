import 'package:clean_architecture_note_app/domain/repository/note_repository.dart';
import 'package:clean_architecture_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/model/note.dart';

class AddEditNoteViewModel with ChangeNotifier{
  final NoteRepository repository;

  int _color = Colors.orange.value;
  int get color => _color;
  
  AddEditNoteViewModel(this.repository);
  
  void onEvent(AddEditNoteEvent event) {
    event.when(changeColor: _changeColor, saveNote: _saveNote);
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if(id == null) {
      repository.insertNote(Note(
        title: title,
        content: content,
        color: _color,
        timeStamp: DateTime.now().millisecondsSinceEpoch
      ));
    } else{
      await repository.updateNote(Note(
        id: id,
        title: title,
        content: content,
        color: _color,
        timeStamp: DateTime.now().millisecondsSinceEpoch
      ));
    }
  }
}