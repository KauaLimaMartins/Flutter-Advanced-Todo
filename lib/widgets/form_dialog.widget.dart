import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  FormDialog({
    @required this.formKey,
    @required this.titleController,
    @required this.subtitleController,
    @required this.pressedFunction,
  });

  final GlobalKey<FormState> formKey;
  final Function pressedFunction;

  final TextEditingController titleController;
  final TextEditingController subtitleController;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 10.0),
                child: Expanded(
                  child: TextFormField(
                    controller: this.titleController,
                    cursorColor: Colors.indigo,
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20.0,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Título',
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.indigo,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 20.0),
                child: Expanded(
                  child: TextFormField(
                    controller: this.subtitleController,
                    cursorColor: Colors.indigo,
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20.0,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Subtítulo',
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.indigo,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 25.0),
                child: RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.indigo,
                  child: Text(
                    'Adicionar Tarefa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                  onPressed: this.pressedFunction,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
