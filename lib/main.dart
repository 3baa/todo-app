import 'package:flutter/material.dart';
import 'dart:async'; 

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<TodoItem> _todoItems = [];
  final TextEditingController _controller = TextEditingController();
  bool _isImageVisible = false; 

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(task, false));
      });
      _controller.clear();
    }
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].isCompleted = !_todoItems[index].isCompleted;
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  Widget _buildTodoItem(TodoItem item, int index) {
    return ListTile(
      title: Text(
        item.task,
        style: TextStyle(
          color: const Color.fromARGB(236, 248, 246, 246),
          fontFamily: 'Pacifico',
          fontSize: 18,
          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
          decorationThickness: 3,
        ),
      ),
      leading: Checkbox(
        side: BorderSide(color: Colors.white),
        value: item.isCompleted,
        onChanged: (bool? value) {
          _toggleTodoItem(index);
        },
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: const Color.fromARGB(255, 212, 211, 211),
        ),
        onPressed: () => _deleteTodoItem(index),
      ),
    );
  }

  // Function to show image temporarily when heart icon is clicked
  void _showImageTemporarily() {
    setState(() {
      _isImageVisible = true; // Show the image
    });
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isImageVisible = false; // Hide the image after 2 seconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 213, 240),
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        backgroundColor: const Color.fromARGB(134, 87, 2, 63),
        foregroundColor: const Color.fromARGB(221, 226, 224, 224),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(101, 241, 213, 240),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(220, 251, 250, 250),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                labelText: 'Enter what to do',
                suffixIcon: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(133, 194, 175, 190),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 254, 253, 253)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: const Color.fromARGB(134, 87, 2, 63),
                      ),
                      onPressed: () => _addTodoItem(_controller.text),
                    ),
                  ),
                ),
              ),
              onSubmitted: _addTodoItem,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(134, 87, 2, 63),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _buildTodoItem(_todoItems[index], index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    
      bottomNavigationBar: BottomAppBar(
       
        child: Container(
          height: 100.0, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: const Color.fromARGB(134, 87, 2, 63),size: 65,),
                onPressed: _showImageTemporarily, 
              ),
              
              if (_isImageVisible)
                Image.asset(
                  'images/b.jpg.png', 
                  width: 80,
                  height: 90,
                ),
                IconButton(
                icon: Icon(Icons.emoji_emotions_outlined, color: const Color.fromARGB(134, 87, 2, 63),size: 65,),
                onPressed: _showImageTemporarily, 
              ),
              
              if (_isImageVisible)
                Image.asset(
                  'images/r.jpg.png', 
                  width: 80,
                  height: 90,
                ),
           
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItem {
  String task;
  bool isCompleted;

  TodoItem(this.task, this.isCompleted);
}
