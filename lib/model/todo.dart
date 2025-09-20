class ToDo{
  String ? id;
  String ? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone =false,
  });

  static List<ToDo> todoList(){
    return[
        ToDo(id: '01',todoText: 'Morning Excercise', isDone:true),
        ToDo(id: '02',todoText: 'Breakfast', isDone:true),
        ToDo(id: '03',todoText: 'Check Mail Updates', isDone:true),
        ToDo(id: '04',todoText: 'Check Job ', isDone:false),
        ToDo(id: '05',todoText: 'Hydrate', isDone:true),
        ToDo(id: '06',todoText: 'Go to Work', isDone:true),
        ToDo(id: '07',todoText: 'Check Xyz', isDone:false),
        ToDo(id: '08',todoText: 'Lunch', isDone:true),
        ToDo(id: '09',todoText: 'Updates', isDone:false),
        ToDo(id: '10',todoText: 'Dinner', isDone:false),
    ];
  }  
}