import 'package:fl_todoApp/model/todo_item.dart';
import 'package:fl_todoApp/util/database_client.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State {
  final TextEditingController _textEditingController = TextEditingController();
  var db = DatabaseHelper();
  final List<TodoItem> _itemList = <TodoItem>[];

  
  @override
  void initState() {
    super.initState();

    _readTodoList();
  }

  void _handleSubmitted(String text) async{
    _textEditingController.clear();
    TodoItem todoItem = TodoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(todoItem);
    TodoItem addedItem = await db.getItem(savedItemId);

    setState((){
      _itemList.insert(0, addedItem);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: _itemList.length,
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.white12,
                  child: ListTile(
                    title: _itemList[index],
                    onLongPress: ()=> debugPrint(""),
                    trailing: Listener(
                      key: Key(_itemList[index].itemName),
                      child: Icon(Icons.remove_circle),
                      onPointerDown: (pointerEvent) => debugPrint(""),
                    ),
                  ),
                );     
              },),
          ),
          Divider(
            height: 1.0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.redAccent,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Item",
                hintText: "some hint",
                icon: Icon(Icons.note_add)
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleSubmitted(_textEditingController.text);
            _textEditingController.clear();
          },
          child: Text('Save'),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel")
        )
      ],
    );
    showDialog(context: context, 
      builder: (_){
        return alert;
      });
  }
  
  _readTodoList() async {
    List items = await db.getItems();
    items.forEach((item){
      TodoItem todoItem = TodoItem.map(items);
      print("ITEMS:  ${todoItem.itemName}");
    });
  }
}