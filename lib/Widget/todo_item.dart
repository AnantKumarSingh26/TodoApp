import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo toDo;
  final onToDoChanged;
  final onDeleteItem; 

  const TodoItem({super.key, required this.toDo,required this.onDeleteItem,required this.onToDoChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        onTap: () {
          onToDoChanged(toDo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(toDo.isDone?Icons.check_box:Icons.check_box_outline_blank, color: tdBlue),
        title: Text(
          toDo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: toDo.isDone? TextDecoration.lineThrough:null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            onPressed: () {
              onDeleteItem(toDo.id);
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
