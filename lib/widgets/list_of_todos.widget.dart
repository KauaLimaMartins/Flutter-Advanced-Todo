import 'package:flutter/material.dart';

class ListOfTodos extends StatefulWidget {
  ListOfTodos({
    @required this.todoList,
    @required this.lastRemoved,
    @required this.lastRemovedIndex,
    @required this.saveData,
  });

  List todoList;

  Map<String, dynamic> lastRemoved;
  int lastRemovedIndex;

  final Function saveData;

  @override
  _ListOfTodosState createState() => _ListOfTodosState();
}

class _ListOfTodosState extends State<ListOfTodos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.0),
      itemCount: this.widget.todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment(-0.9, 0.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          onDismissed: (DismissDirection direction) {
            setState(() {
              this.widget.lastRemoved = Map.from(widget.todoList[index]);
              this.widget.lastRemovedIndex = index;

              this.widget.todoList.removeAt(index);
              this.widget.saveData();

              final snack = SnackBar(
                content: Text(
                    'Tarefa "${this.widget.lastRemoved["title"]}" removida'),
                action: SnackBarAction(
                  label: 'Desfazer',
                  textColor: Colors.blue,
                  onPressed: () {
                    setState(() {
                      this.widget.todoList.insert(this.widget.lastRemovedIndex,
                          this.widget.lastRemoved);
                      this.widget.saveData();
                    });
                  },
                ),
                duration: Duration(seconds: 3),
              );

              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(snack);
            });
          },
          child: CheckboxListTile(
            title: Text(
              this.widget.todoList[index]['title'],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            value: this.widget.todoList[index]['completed'],
            subtitle: this.widget.todoList[index]['subtitle'] == ''
                ? null
                : Text(this.widget.todoList[index]['subtitle']),
            secondary: CircleAvatar(
              child: Icon(this.widget.todoList[index]['completed'] == true
                  ? Icons.check
                  : Icons.clear),
            ),
            onChanged: (bool checked) {
              setState(() {
                this.widget.todoList[index]['completed'] = checked;
                this.widget.saveData();
              });
            },
          ),
        );
      },
    );
  }
}
