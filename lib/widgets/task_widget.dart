import 'package:flutter/material.dart';
import 'package:note_app/Model/task_model.dart';
import 'package:note_app/utils/db.dart'; // Import your TaskDB class

class NoteWidget extends StatefulWidget {
  final Todolist task;
  final Function()? onPressed;

  const NoteWidget({Key? key, required this.task, this.onPressed})
      : super(key: key);

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.black,
                value: widget.task.isDone,
                onChanged: (val) {
                  setState(
                    () {
                      widget.task.isDone = val ?? false;
                      TaskDB.instance.updateTask(widget.task);
                    },
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${widget.task.title ?? ''}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: widget.task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(
                    'Content: ${widget.task.content ?? ''}',
                    style: TextStyle(
                      fontSize: 16,
                      decoration: widget.task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(
                    'Date: ${MaterialLocalizations.of(context).formatFullDate(widget.task.date!)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      decoration: widget.task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
