// controller.dart
import 'package:hive/hive.dart';

class TaskController {
  final Box<dynamic> _tasksBox;

  TaskController(this._tasksBox);

  // Future<void> createTask(String name, int quantity) async {
  //   await _tasksBox.add({'name': name, 'quantity': quantity});
  // }
  Future<void> createItem(Map<dynamic, dynamic> newItem) async {
    try {
      await _tasksBox.add(newItem);
      getAllTasks();
      print("Item created successfully.");
    } catch (e) {
      print("Error creating item: $e");
    }
  }
  // Future<void> updateTask(int key, String name, int quantity) async {
  //   await _tasksBox.put(key, {'name': name, 'quantity': quantity});
  // }
  Future<void> updateItem(int itemKey, Map<String, dynamic> newItem) async {
    try {
      await _tasksBox.put(itemKey, newItem);
      getAllTasks();
      print("Item updated successfully.");
    } catch (e) {
      print("Error updating item: $e");
    }
  }
  // Future<void> deleteTask(int key) async {
  //   await _tasksBox.delete(key);
  // }
  Future<void> deleteItem(int itemKey) async {
    try {
      await _tasksBox.delete(itemKey);
      getAllTasks();
      print("Item deleted successfully.");
    } catch (e) {
      print("Error deleting item: $e");
    }
  }
  List<Map<dynamic, dynamic>> getAllTasks() {
    return _tasksBox.keys.map((key) {
      final task = _tasksBox.get(key) as Map<dynamic, dynamic>;
      return {'key': key, 'name': task['name'], 'Quantity': task['Quantity']};
    }).toList();
  }
}
