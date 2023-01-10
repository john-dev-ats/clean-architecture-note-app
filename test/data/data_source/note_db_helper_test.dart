import 'package:clean_architecture_note_app/data/data_source/note_db_helper.dart';
import 'package:clean_architecture_note_app/domain/model/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    final db = await databaseFactoryFfi.openDatabase((inMemoryDatabasePath));

    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timeStamp INTEGER)');

    final noteDBHelper = NoteDBHelper(db);

    //db insert 테스트
    await noteDBHelper.insertNote(Note(
      title: 'test',
      content: 'test',
      color: 1,
      timeStamp: 1,
    ));

    expect((await noteDBHelper.getNotes()).length, 1);

    //db id 테스트
    Note note = (await noteDBHelper.getNoteById(1))!;

    expect(note.id, 1);

    //db update 테스트
    await noteDBHelper.updateNote(note.copyWith(
      title: 'change'
    ));

    note = (await noteDBHelper.getNoteById(1))!;
    expect(note.title,'change');

    //db delete 테스트
    await noteDBHelper.deleteNote(note);
    expect((await noteDBHelper.getNotes()).length, 0);

    await db.close();

  });
}
