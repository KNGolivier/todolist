import 'package:flutter/material.dart';
import 'package:todo_list_examen/File/TachePage.dart';
import 'package:todo_list_examen/File/TacheService.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  final TacheService taskService = TacheService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tacheController = TextEditingController();
  void _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ajouter une tâche"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Titre"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  taskService.addTask(
                      titleController.text, _descriptionController.text);
                  titleController.clear();
                  _descriptionController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  void _editTask(BuildContext context, Tache task) {
    titleController.text = task.title;
    _descriptionController.text = task.description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Modifier la tâche"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Titre"),
              ),
              TextField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: "Description de la tâche"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  taskService.updateTacheDetails(
                    task.id,
                    titleController.text,
                    _descriptionController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Modifier"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: Text(
                "TodoList",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _tacheController,
              decoration: const InputDecoration(
                labelText: 'Nom de la tâche',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrition de la tâche',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                if (_tacheController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  taskService.addTask(
                      _tacheController.text, _descriptionController.text);
                  _tacheController.clear();
                  _descriptionController.clear();
                }
              },
              child: const Text(
                'Ajouter la tâche',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<Tache>>(
                stream: taskService.getTache(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final tasks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) {
                                  taskService.updateTache(task.id, value!);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _editTask(context, task);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  taskService.deleteTache(task.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Text(
              "*Cochez la checkbox lorsque vous finissez la tâche",
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
