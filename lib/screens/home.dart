import 'package:flutter/material.dart';
import '../Widget/todo_item.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todList;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            'All ToDo'
                            's',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        for (ToDo toDoo in _foundToDo)
                          TodoItem(
                            toDo: toDoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavBar(),
          ],
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    todList.removeWhere((item) => item.id == id);
  }

  void addToDoItem(String todo) {
    setState(() {
      todList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
        ),
      );
    });
    _todoController.clear();
  }

  void _search(String enteredKeyWord) {
    List<ToDo> results = [];
    if (enteredKeyWord.isEmpty) {
      results = todList;
    } else {
      
        results = todList
            .where(
              (item) => item.todoText!.toLowerCase().contains(
                enteredKeyWord.toLowerCase(),
              ),
            )
            .toList();
      
    }

      setState(() {
        
        _foundToDo=results;
      });
  }

  // +++----------    Bottom Navigation Bar -------------+++
  Widget bottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(bottom: 25, right: 20, left: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.7),
                    offset: Offset(0, 0),
                    blurRadius: 7,
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add a new Task',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25, right: 20),
            child: ElevatedButton(
              onPressed: () {
                addToDoItem(_todoController.text);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 60),
                elevation: 10,
                foregroundColor: Colors.white,
                backgroundColor: tdBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              child: Text('+', style: TextStyle(fontSize: 40)),
            ),
          ),
        ],
      ),
    );
  }

  // +++----------   Search Box ------------+++
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value)=> _search(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }

  // --------++++++     App Bar Method    ++++++------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.asset('assets/images/profile.png'),
            ),
          ),
        ],
      ),
    );
  }
}
