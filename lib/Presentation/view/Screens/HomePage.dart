// home_page.dart
import 'package:flutter/material.dart';

import '../../../controller/Logic_Controller.dart';
 // Import TaskController from the controller.dart file

class HomePage extends StatefulWidget {
  final TaskController taskController;

  const HomePage({Key? key, required this.taskController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      // body: ListView.builder(
      //   itemCount: widget.taskController.getAllTasks().length,
      //   itemBuilder: (context, index) {
      //     final task = widget.taskController.getAllTasks()[index];
      //     return ListTile(
      //       title: Text(task['name']),
      //       subtitle: Text(task['quantity'].toString()),
      //       onTap: () {
      //         _nameController.text = task['name'];
      //         _quantityController.text = task['quantity'].toString();
      //         _showForm(context, task['key']);
      //       },
      //     );
      //   },
      // ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
          itemCount: widget.taskController.getAllTasks().length,      //final task = widget.taskController.getAllTasks()[index];
        itemBuilder:(context, index) {
          final task = widget.taskController.getAllTasks()[index];
          return Card(
            color: Colors.orange.shade100,
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              title: Text(task['name']),
              subtitle: Text(task['Quantity'].toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                IconButton(
                    onPressed: (){
                      _showForm(context, task['key']);

                      },
                    icon:Icon(Icons.edit)),
                IconButton(onPressed: (){
                  setState(() {
                    widget.taskController.deleteItem(task['key']);
                  });
                }, icon: Icon(Icons.delete)),
              ],),
            ),
          );
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         setState(() {
           _showForm(context, null);
         });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showForm(BuildContext context, int? itemKey) async {
    String name = '';
    String Quantity = '';

    if (itemKey != null) {
      final existingItem = widget.taskController.getAllTasks().firstWhere(
            (task) => task['key'] == itemKey,
        // orElse: () => null,
      );
      if (existingItem != null) {
        name = existingItem['name'] ?? '';
        Quantity = existingItem['Quantity'].toString();
      }
    }


    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Name",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Quantity"
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () async {
                if (itemKey == null) {
                  // If itemKey is null, create a new item
                  widget.taskController.createItem({
                    "name": _nameController.text,
                    "Quantity": int.parse(_quantityController.text),
                  });
                } else {
                  // If itemKey is not null, update the existing item
                  widget.taskController.updateItem(itemKey, {
                    'name': _nameController.text.trim(),
                    "Quantity": int.parse(_quantityController.text.trim()),
                  });
                }
                _nameController.clear();
                _quantityController.clear();
                Navigator.pop(context);
              },
              child: Text(itemKey == null ? "Create Item" : "Update"),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
