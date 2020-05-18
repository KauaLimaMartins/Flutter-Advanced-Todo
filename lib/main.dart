import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:async';

import 'package:todo/widgets/form_dialog.widget.dart';
import 'package:todo/widgets/list_of_todos.widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  List _todoList = [];

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedIndex;

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    this._readData().then((data) {
      setState(() {
        this._todoList = json.decode(data);
      });
    });
  }

  void _addTodo() {
    setState(() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
      }

      Map<String, dynamic> newTodo = Map();

      newTodo['title'] = _titleController.text;
      newTodo['subtitle'] = _subtitleController.text;
      newTodo['completed'] = false;

      _titleController.text = '';
      _subtitleController.text = '';

      this._todoList.add(newTodo);
      this._saveData();

      Navigator.of(context).pop();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _todoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });

      _saveData();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de Tarefas"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FormDialog(
                  formKey: this._formKey,
                  titleController: this._titleController,
                  subtitleController: this._subtitleController,
                  pressedFunction: this._addTodo,
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: this._refresh,
          child: ListOfTodos(
            todoList: this._todoList,
            lastRemoved: this._lastRemoved,
            lastRemovedIndex: this._lastRemovedIndex,
            saveData: this._saveData,
          ),
        ),
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(this._todoList);
    final file = await this._getFile();

    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await this._getFile();

      return file.readAsString();
    } catch (err) {
      return null;
    }
  }
}
