import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/save_load.dart';


void saveCurrentTodos(List todo) {
  List<Todo> todos = todo.map((item) => Todo(title: item[0], completed: item[1])).toList();
  saveTodos(todos);
}

class HomePage extends StatefulWidget {
  const  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todo = [
    ['Learn Flutter', false],
    ['Practice Widgets', false],
  ];
final ScrollController _dateScrollController = ScrollController();

void _addTodoDialog(){
  String newTod='';
  showDialog(context: context, 
  builder: (context)=> 
    AlertDialog(
      title: Text('Add Task'),

      content:  TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Enter Task'),
          onChanged:(value)=>newTod=value,
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), 
        child: Text('Cancel'),
        ),
        ElevatedButton(onPressed: (){
          if(newTod.trim().isNotEmpty){
            setState(() {
              todo.add([newTod.trim(), false]);
            });
            saveCurrentTodos(todo);
          }
        }, child: Text('Add'),
        )
      ],
    )
  );
}
  @override
  void initState() {
    super.initState();
    loadTodos().then((loadedTodos) {
      setState(() {
        todo = loadedTodos.map((t) => [t.title, t.completed]).toList();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_){
      int todayIndex = DateTime.now().day-1;
      double itemWidth =40+16+16;
      _dateScrollController.animateTo(todayIndex*itemWidth,
       duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut
      );
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          DateFormat('MMMM yyyy').format(DateTime.now()),
          style: GoogleFonts.fahkwang(fontSize: 30),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),


      body: Column(
        children: [


          Container(
            height: 110,
            child: ListView.builder(
              controller: _dateScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: DateTime(
                DateTime.now().year,
                DateTime.now().month + 1,
                0,
              ).day,
              itemBuilder: (context, index) {
                DateTime date = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  index + 1,
                );
                bool isToday =
                    date.day == DateTime.now().day &&
                    date.month == DateTime.now().month &&
                    date.year == DateTime.now().year;


                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  padding:  EdgeInsets.symmetric(
                    horizontal: isToday ? 40 : 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isToday ? const Color.fromARGB(255, 230, 0, 0) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(date),
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        DateFormat('d').format(date),
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: todo.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 20,
                    bottom: 0,
                  ),

                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[200]?.withOpacity(0.5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            todo[index][0],
                            style: GoogleFonts.robotoSlab(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20,
                              decoration: todo[index][1]?
                              TextDecoration.lineThrough:TextDecoration.none,
                              decorationThickness: 3,
                              decorationColor: const Color.fromARGB(255, 255, 255, 255)
                            ),
                          ),
                        ),
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(value: todo[index][1],
                            onChanged: (val){
                              setState(() {
                                todo[index][1] = val;
                              });
                              saveCurrentTodos(todo);
                            },
                            side: BorderSide(color: Colors.white,width: 2),
                            activeColor: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoDialog,
        backgroundColor: Colors.blueAccent,
        tooltip: 'Add Task',
        child: Icon(Icons.add, color:Colors.white),
      ),
    );
  }
}
