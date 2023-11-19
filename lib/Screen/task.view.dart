import 'package:flutter/material.dart';
import 'package:note_app/Model/task_model.dart';
import 'package:note_app/utils/db.dart';
import 'package:note_app/widgets/loading_widget.dart';
import 'package:uuid/uuid.dart';

class TaskView extends StatefulWidget {
  final Todolist? task;

  const TaskView({Key? key, this.task});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController _textCtrl = TextEditingController();
  final TextEditingController _contentCtrl = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    _textCtrl.text = widget.task?.title ?? '';
    _contentCtrl.text = widget.task?.content ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingWidget()
        : Scaffold(
            backgroundColor: Color.fromARGB(248, 255, 245, 157),
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              title: Text(
                MaterialLocalizations.of(context).formatShortDate(
                  widget.task?.date ?? DateTime.now(),
                ),
                style: const TextStyle(fontSize: 12),
              ),
              actions: [
                IconButton(
                  onPressed: delete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: save,
                  icon: const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                TextField(
                  controller: _textCtrl,
                  decoration:
                      const InputDecoration(hintText: "Enter your task"),
                ),
                Expanded(
                  child: TextField(
                    maxLength: 3000,
                    maxLines: 300,
                    controller: _contentCtrl,
                    decoration: const InputDecoration(
                      hintText: 'content',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

// Save task
  save() async {
    final note = Todolist(
      id: widget.task?.id ?? const Uuid().v4(),
      title: _textCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
      isdone: widget.task?.isDone ?? false,
    );

    setLoading(true);

    try {
      if (widget.task == null) {
        await insert(note);
      } else {
        await update(note);
      }
    } catch (error) {
      print('Error: $error');
    }
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  // Insert task
  insert(Todolist task) async {
    try {
      await TaskDB.instance.insertTask(task);
    } catch (error) {
      print('Error during insert: $error');
    } finally {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  // Update task
  update(Todolist task) async {
    try {
      await TaskDB.instance.updateTask(task);
    } catch (error) {
      print('Error during update: $error');
    } finally {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  // Delete task
  delete() async {
    setLoading(true);
    try {
      await TaskDB.instance.deleteTask(widget.task!);
    } catch (error) {
      print('Error during delete: $error');
    } finally {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  setLoading([bool enabled = false]) {
    setState(() {
      _isLoading = enabled;
    });
  }
}
