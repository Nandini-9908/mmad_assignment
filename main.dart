
import 'package:flutter/material.dart';
void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
home: TodoPage(),
theme: ThemeData(
useMaterial3: true,
colorSchemeSeed: Colors.blue,
),
);
}
}
class TodoPage extends StatefulWidget {
@override
_TodoPageState createState() => _TodoPageState();
}
class _TodoPageState extends State<TodoPage> {
List<String> tasks = [];
TextEditingController controller = TextEditingController();
void addTask() {
if (controller.text.trim().isNotEmpty) {
setState(() {
tasks.add(controller.text.trim());
controller.clear();
});
}
}
void deleteTask(int index) {
setState(() {
tasks.removeAt(index);
});
}
@override
Widget build(BuildContext context) {
final isValid = controller.text.trim().isNotEmpty;
return Scaffold(
appBar: AppBar(
title: const Text(
" To-Do App",
style: TextStyle(fontWeight: FontWeight.bold),
),
backgroundColor: Colors.blue,
foregroundColor: Colors.white,
elevation: 4,
actions: [
Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.end,
),
),
],
),
body: Column(
children: [
// INPUT SECTION
Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
color: Colors.blue.shade50,
border: Border(
bottom: BorderSide(color: Colors.blue.shade200),
),
),
child: Row(
children: [
Expanded(
child: TextField(
controller: controller,
autofocus: true,
// ✅ FIX:rebuild UI when typing
onChanged: (_) {
setState(() {});
},
decoration: InputDecoration(
hintText: "✏ Enter your task...",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
),
filled: true,
fillColor: Colors.white,
contentPadding: const EdgeInsets.symmetric(
horizontal: 16, vertical: 12),
),
),
),
const SizedBox(width: 12),
ElevatedButton(
onPressed: isValid ? addTask : null,
style: ElevatedButton.styleFrom(
backgroundColor: Colors.blue,
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
),
child: const Text("➕ Add"),
),
],
),
),
// TASK LIST
Expanded(
child: tasks.isEmpty
? Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(Icons.task_alt_outlined,
size: 80, color: Colors.grey),
const SizedBox(height: 20),
Text("No tasks yet!",
style: Theme.of(context)
.textTheme
.headlineSmall
?.copyWith(color: Colors.red)),
const Text("Add your first task above "),
],
),
)
: ListView.builder(
padding: const EdgeInsets.all(16),
itemCount: tasks.length,
itemBuilder: (context, index) {
return Card(
child: ListTile(
title: Text(tasks[index]),
trailing: IconButton(
icon: const Icon(Icons.delete, color: Colors.red),
onPressed: () => deleteTask(index),
),
),
);
},
),
),
// FOOTER
Container(
width: double.infinity,
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.blue.shade50,
border: Border(
top: BorderSide(color: Colors.blue.shade200),
),
),
child: const Column(
children: [
Text("✨ Developed by NANDINI",
style: TextStyle(fontWeight: FontWeight.bold)),
Text(" Roll No: 160124737015"),
],
),
),
],
),
// FLOATING BUTTON FIXED
floatingActionButton: FloatingActionButton(
onPressed: isValid ? addTask : null,
child: const Icon(Icons.add),
),
);
}
@override
void dispose() {
controller.dispose();
super.dispose();
}
}
