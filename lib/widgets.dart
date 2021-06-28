import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  late final String title;
  late final String desc;
  TaskCardWidget ({String title = "" , String desc = "" }) {
    this.title = title;
    this.desc = desc;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(title , style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w900
              ),
              ),
              subtitle: Text(desc),
            ),
          ],
        ),
      ),
    );
  }
}


class TaskItem extends StatefulWidget {
  late final String name;
  late final bool isDone;

  TaskItem ({String name = "" , int isDone = 0 }) {
    this.name = name;
    if(isDone == 0 ){
      this.isDone = false;
    }else{
      this.isDone = true;
    }

  }
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool first = false;
  late bool isChecked;
  late String name;
  @override
  Widget build(BuildContext context) {
    if(first==false){
      first = true;
      isChecked = widget.isDone;
      name = widget.name;
    }

    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text(  name,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: isChecked ? Colors.black : Colors.black54,
          ),
        ),
      ],
    );
  }
}

