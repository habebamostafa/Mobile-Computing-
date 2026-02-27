import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue, // can be changed to custom color palette
        fontFamily: 'MyCustomFont', // use your custom font
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // State variables
  final TextEditingController _goalController = TextEditingController();
  final List<String> _goals = [];

  // Function to handle adding a goal
  void _addGoal() {
    final String newGoal = _goalController.text.trim();
    if (newGoal.isNotEmpty) {
      setState(() {
        _goals.add(newGoal);
        _goalController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        centerTitle: true,
        backgroundColor: Colors.blue, // consistent with primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text
            const Text(
              'What do you want to achieve today?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'MyCustomFont', // using custom font
              ),
            ),
            const SizedBox(height: 20),
            // Text input field
            TextField(
              controller: _goalController,
              decoration: const InputDecoration(
                labelText: 'Enter a goal',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment),
              ),
              onSubmitted: (_) => _addGoal(), // allow adding via keyboard
            ),
            const SizedBox(height: 10),
            // Add button
            Center(
              child: ElevatedButton(
                onPressed: _addGoal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // consistent color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text('Add Goal'),
              ),
            ),
            const SizedBox(height: 20),
            // List of goals
            Expanded(
              child: _goals.isEmpty
                  ? const Center(
                child: Text(
                  'No goals yet. Add one above!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(_goals[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _goals.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}