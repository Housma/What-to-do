import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/taskpage.dart';
import 'package:to_do_list/widgets.dart';

import 'database_helper.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper _db = DatabaseHelper();
    print(_db.todos(1).toString());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(task: Task(id: 0),))).then((value) {
              setState(() {});
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body:
        SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(25.0),
            color: Colors.white60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
                Expanded(
                    child: FutureBuilder(
                      future: _db.tasks(),
                      builder: (
                          BuildContext context,
                          AsyncSnapshot<List<Task>> snapshot) {
                        return ListView.builder(itemCount: snapshot.data!.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                  onTap:  () =>Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context)=> TaskPage(task:snapshot.data![index] )
                                  )
                                  ),
                                  child: TaskCardWidget(
                                    title: snapshot.data![index].title,desc:snapshot.data![index].description ,)
                              );
                            });
                      },

                    )
                ),
              ],
            ),
          ),
        )
    );
  }
}
