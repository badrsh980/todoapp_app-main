import 'package:note_app/Model/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskDB {
  TaskDB._();

  static TaskDB get instance => TaskDB._();

  final SupabaseClient _supabaseClient = SupabaseClient(
    'https://wnyefyiskxsnlecmhoha.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndueWVmeWlza3hzbmxlY21ob2hhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAyMjk5MDksImV4cCI6MjAxNTgwNTkwOX0.Uvs4BJW952nkIbGXP9KS67x2h5bXvSZOciS1lgE7TkU',
  );
  final String tableName = 'tasks';

  // Get all tasks
  Future<List<Todolist>> getAllTasks() async {
    // ignore: deprecated_member_use
    final response = await _supabaseClient.from(tableName).select().execute();
    List<Todolist> tasks = (response.data as List).map((task) {
      return Todolist.fromJson(task as Map<String, dynamic>);
    }).toList();
    tasks;
    return tasks;
  }

  // Insert a task
  Future<void> insertTask(Todolist todolist) async {
    // ignore: deprecated_member_use
    await _supabaseClient.from(tableName).upsert([todolist.toJson()]).execute();
  }

  // Update a task
  Future<void> updateTask(Todolist task) async {
    // ignore: deprecated_member_use
    await _supabaseClient.from(tableName).upsert([task.toJson()]).execute();
  }

  // Delete a task
  Future<void> deleteTask(Todolist task) async {
    // ignore: deprecated_member_use
    await _supabaseClient.from(tableName).delete().eq('id', task.id).execute();
  }
}
