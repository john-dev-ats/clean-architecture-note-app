import 'package:clean_architecture_note_app/domain/repository/note_repository.dart';
import '../model/note.dart';

class GetNotes {
  NoteRepository repository;

  GetNotes(this.repository);

  Future<List<Note>> call() async {
    List<Note> notes = await repository.getNotes();
    return notes;
  }
}