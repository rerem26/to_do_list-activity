import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/todolist.dart';
import 'package:todo_list/model.dart';
import 'action.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoBox = Hive.box<TodoModel>('todos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TO-DO LIST',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple[400],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.wallpapersafari.com/55/7/W1mXsF.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: _todoBox.listenable(),
          builder: (context, Box<TodoModel> box, _) {
            // Check if list is empty
            if (box.length != 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final todo = box.getAt(index)!;
                    return TodoList(
                      todo: todo,
                      index: index,
                      onDelete: _deleteTodo,
                    );
                  },
                ),
              );
            } else {
              // Text when list is empty
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://i.pinimg.com/originals/80/c3/d3/80c3d39442a0a2af4afd703ea46ec76f.gif',
                      width: 200,
                      height: 200,
                      // Adjust width and height according to your image size
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(16), // Adjust padding as needed
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5), // Border settings
                        borderRadius: BorderRadius.circular(10), // Add border radius
                        color: Colors.black.withOpacity(0.5), // Add background color with opacity
                      ),
                      child: Text(
                        "Nothing To Do.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30, // Adjust the font size as needed
                          color: Colors.white, // Change text color to white
                          fontWeight: FontWeight.bold, // Add bold font weight
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: _addTodo,
      ),
    );
  }

  void _addTodo(String description) {
    final todo = TodoModel(description: description);
    _todoBox.add(todo);
  }

  void _deleteTodo(int index) {
    _todoBox.deleteAt(index);
  }
}
