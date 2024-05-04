import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'Presentation/view/Screens/HomePage.dart';
import 'controller/Logic_Controller.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("TasksBox");

  final tasksBox = Hive.box("TasksBox");// Here where we can store our data .
  final taskController = TaskController(tasksBox);
  runApp(
    DevicePreview(
      builder: (context) =>  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(taskController: taskController,)),
    ),
  );

}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       home:  HomePage(taskController: null,),
//
//     );
//
//
//   }
// }


// class HomePage extends StatefulWidget {
//    HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
// final TextEditingController txtName= TextEditingController();
//
// final TextEditingController txtEdit= TextEditingController();
//
// //this List where we will collect all items from TaskBox in hive and then we will use it after in the Ui  so we should link them together:
// // List <Map<String , dynamic>> _items=[];
// //creating the Hive Box by this Line and getting reference on it  :
// // final TasksBox=Hive.box("TasksBox");
// //
// //   void initState(){
// //     super.initState();
// //     _refresh();
// //   }
// //Here where the function that we created to create an Item when pressing on Elevated Button :
// // Future <void>  _createItem (Map<String,dynamic> newItem)async{
// //   //add function will give you a key for each item will be added
// //   await TasksBox.add(newItem);
// //   print("amount data is ${TasksBox.length}");
// //
// // }
// //   Future <void>  _updateItem (int itemkey,Map<String,dynamic> item)async{
// //     //add function will give you a key for each item will be added
// //     await TasksBox.put(itemkey,item);
// //     _refresh();
// //
// //   }
// //   Future <void>  _deleteItem (int itemkey)async{
// //     //add function will give you a key for each item will be added
// //     await TasksBox.delete(itemkey);
// //     _refresh();
// //
// //   }
// //
// // //Here is Reshfreshing function for Item to show them in ui:
// //   void _refresh (){
// //   final data = TasksBox.keys.map((key){
// //     final item =TasksBox.get(key);
// //     print("Item: $item");
// //     return {"key":key, "Name":item["Name"], "Quantity": item['Quantity']};
// //   }).toList();
// //
// //   setState((){
// //     _items =data.reversed.toList();
// //     print(_items.length);
// //   });
// //
// //   }
//
// //Here where the showmodal appeared when pressing on floatingbutton:
//
//
//
//
//
//
//   // void _refresh() {
//   //   final data = TasksBox.keys.map((key) {
//   //     final item = TasksBox.get(key);
//   //     return {"key": key, "Name": item["Name"], "Quantity": item['Quantity']};
//   //   }).toList();
//   //
//   //   setState(() {
//   //     _items.clear();
//   //     _items.addAll(data.reversed);
//   //   });
//   // }
//
//   void _showForm(BuildContext context,int? itemKey)async{
//     if(itemKey!=null){
//       final existingItem=
//           _items.firstWhere((element) => element['key']==itemKey);
//           txtName.text=existingItem['Name'];
//           txtEdit.text=existingItem['Quantity'];
//     }
//
//   showModalBottomSheet(
//     elevation: 5,
//       isScrollControlled: true,
//       context: context,
//       builder: (context) => Container(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           top: 15,
//           left: 15,
//           right: 15,
//
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//
//           children: [
//    TextField(
//      controller: txtName,
//      decoration: InputDecoration(
//        hintText: "Name",
//      ),
//    ),
//    SizedBox(height: 10,),
//    TextField(
//      controller: txtEdit,
//      keyboardType: TextInputType.number,
//      decoration: InputDecoration(
//        hintText: "Quantity"
//      ),
//    ),
//             SizedBox(height: 30,),
//             ElevatedButton(onPressed: ()async{
//       //           _createItem({
//       //             "Name" : txtName.text,
//       //             "Quantity" : txtEdit.text
//       //           });
//       // if(itemKey!=null ){
//       //   _updateItem(itemKey,{
//       //     'Name':txtName.text.trim(),
//       //     "Quantity" : txtEdit.text.trim()
//               if (itemKey == null) {
//                 // If itemKey is null, create a new item
//                 _createItem({
//                   "Name": txtName.text,
//                   "Quantity": txtEdit.text,
//                 });
//               } else {
//                 // If itemKey is not null, update the existing item
//                 _updateItem(itemKey, {
//                   'Name': txtName.text.trim(),
//                   "Quantity": txtEdit.text.trim(),
//         });
//       }
//               txtName.text=" ";
//               txtEdit.text=" ";
//               Navigator.pop(context);
//
//
//             }, child:Text(itemKey == null ? "Create Item":"Update" ), ),
//             SizedBox(height: 15,),
//
//           ],
//         ),
//       ),);
// }
//
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("List"),
//       ),
//       body: ListView.builder(
//           itemCount: widget.taskController.getAllTasks().length,
//       final task = widget.taskController.getAllTasks()[index];
//         itemCount: widget.txtName.,
//         itemBuilder:(context, index) {
//           final  currentItem=_items[index];
//           return Card(
//             color: Colors.orange.shade100,
//             margin: EdgeInsets.all(10),
//             elevation: 3,
//             child: ListTile(
//               title: Text(currentItem['Name']),
//               subtitle: Text(currentItem['Quantity'].toString()),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                 IconButton(
//                     onPressed: (){
//                   _showForm(context, currentItem['key']);},
//                     icon:Icon(Icons.edit)),
//                 IconButton(onPressed: (){
//                 _deleteItem(currentItem['key']);
//
//                 }, icon: Icon(Icons.delete)),
//               ],),
//             ),
//           );
//         },
//
//       ),
//
//
//
//
//       floatingActionButton:   FloatingActionButton(
//         onPressed: (){
//           _showForm(context,null);
//         },
//         child: Icon(Icons.add),
//
//
//       ),
//     ) ;
//   }
// }

