import 'package:flutter/material.dart';
import 'package:note_app/Model/task_model.dart';
import 'package:note_app/Screen/task.view.dart';
import 'package:note_app/utils/db.dart';
import 'package:note_app/widgets/loading_widget.dart';
import 'package:note_app/widgets/task_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Center(
          child: Text(
            "TO DO",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.yellow),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newTask,
        child: const Icon(Icons.add_rounded),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Todolist>>(
                future: TaskDB.instance.getAllTasks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const LoadingWidget();

                  List<Todolist> notes = snapshot.data ?? [];

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      var task = notes[index];

                      return NoteWidget(
                        task: task,
                        onPressed: () => showTask(task),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  newTask() async {
    await push(const TaskView());
    setState(() {});
  }

//update Show task
  showTask(Todolist task) async {
    await push(TaskView(task: task));
    setState(() {});
  }

//Push view
  push(Widget view) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => view,
        ),
      );
}
