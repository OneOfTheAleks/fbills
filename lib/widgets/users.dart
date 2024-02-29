import 'package:fbills/data/db.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key, required this.myDb});

  final MyDatabase myDb;

  @override
  // ignore: no_logic_in_create_state
  State<AddUserScreen> createState() => _AddUserScreenState(myDb: myDb);
}

class _AddUserScreenState extends State<AddUserScreen> {
  _AddUserScreenState({required this.myDb});
  final MyDatabase myDb;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add User'),
        ),
        body: AddUserDialog(myDb: myDb));
  }
}

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key, required this.myDb});

  final MyDatabase myDb;

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Имя',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Нужно имя';
                }
                return null;
              },
            ),
            const SizedBox(width: 16),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Примечание',
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final name = _nameController.text;
              final note = _noteController.text;

              final row = {'name': name, 'note': note};
              await widget.myDb.insertUserRow(row);
              _nameController.clear();
              _noteController.clear();

              Navigator.of(context).pop();
            }
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}

//-----------------------------------------------------------------------------------

class EditUserDialog extends StatefulWidget {
  final MyDatabase myDb;
  final int userId;
  final Function onUserUpdated;

  EditUserDialog(
      {required this.myDb, required this.userId, required this.onUserUpdated});

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _noteController;
  late Map<String, dynamic> _u;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _noteController = TextEditingController();
    widget.myDb.getUserRow(widget.userId).then((rows) {
      setState(() {
        _nameController.text = rows[0]['name'];
        _noteController.text = rows[0]['note'];
        _u = rows[0];
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Редактирование пользователя'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Имя',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Нужно имя';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Заметка',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final row = {
                  'name': _nameController.text,
                  'note': _noteController.text,
                  'id': widget.userId
                };
                await widget.myDb.updateUserRow(row);
                widget.onUserUpdated();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Ок'),
          ),
        ]
        );
  }
}
