import 'package:flutter/material.dart';
import 'package:to_do_list/database_helper.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/widgets.dart';

class TaskPage extends StatefulWidget {
  Task task ;
  String title = "";
  TaskPage({required this.task});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    var todoController = new TextEditingController();
    DatabaseHelper _db = DatabaseHelper();
    if(widget.task.id != 0 ){
      widget.title = widget.task.title ;
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(widget.task.id != 0 ){
            await _db.deleteTask(widget.task.id);
            Navigator.pop(context);
           }
        },
        child: const Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Image(
                            image:
                            AssetImage("assets/images/back_arrow_icon.png"),
                          )
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async{
                            if(value != ""){
                              if(widget.task.id == 0 ){
                                Task task = Task( title: value);
                                int task_id = await _db.insertTask(task);
                                _db.taskById(task_id).then((value){
                                  setState(() {
                                    widget.task = value;
                                  });
                                });
                              }else{
                                print("update exist one");
                              }
                            }
                          },
                          controller: TextEditingController()..text = widget.title,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Title",
                          ),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Task Description...",
                          ),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),

                        FutureBuilder(
                          future: _db.todos(widget.task.id),
                          builder: (
                              BuildContext context,
                              AsyncSnapshot<List<Todo>> snapshots) {
                            return ListView.builder(itemCount: snapshots.data!.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                  return TaskItem(
                                      name: snapshots.data![index].name,isDone:snapshots.data![index].isDone ,id: snapshots.data![index].id,);
                                });
                          },
                        ),
                        Row(
                          children: [
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                                value: false,
                                onChanged: (bool? value) {},
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: todoController,
                                onSubmitted: (value) async{
                                  if(value != ""){
                                    if(widget.task.id == 0 ){

                                      print("cant insert");
                                    }else{
                                      DatabaseHelper _db = DatabaseHelper();
                                      Todo todo = Todo(
                                          name: value,
                                          isDone: 0,
                                          taskId: widget.task.id
                                      );
                                      await _db.insertTodo(todo);

                                      setState(() {
                                        todoController.text = "";
                                      });
                                      print("insert exist one");
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter new todo Item",
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
