


import 'package:fbills/data/db.dart';
import 'package:fbills/widgets/users.dart';
import 'package:flutter/material.dart';


class UsersList extends StatefulWidget {
   UsersList({super.key, required this.myDb});

  final MyDatabase myDb;

  @override
  // ignore: no_logic_in_create_state
  State<UsersList> createState() => _UsersListState(myDb: myDb);
}

class _UsersListState extends State<UsersList> {
   _UsersListState({required this.myDb});
  List<Map<String, dynamic>>? _rows;
   final MyDatabase myDb;

  @override
  void initState() {
    super.initState();
    _refreshRow();
  }

  void _refreshRow() {
    _rows = null;
    widget.myDb.getAllUserRows().then((rows) {
      setState(() {
        _rows = rows;
      });
    });
  }

void _showAddUserDialog() {
  showDialog(
    context: context,
    barrierColor: Colors.transparent, // Add this line
    builder: (context) => AddUserDialog(myDb: myDb,),
  ).then((_) {
    setState(() {
      _refreshRow();
    });
  });
}


  @override
  Widget build(BuildContext context) {
    if (_rows == null) {
      return const CircularProgressIndicator();
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: _rows?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return  GestureDetector(
            onLongPress: () {
              int userId = _rows![index]['id'];
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Удалить  пользователя'),
                  content: const Text('Вы уверены?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () async {
                      await  widget.myDb.deleteUserRow(userId);
                      setState(() {
                                   _refreshRow();
                                  }
                                );

                        Navigator.of(context).pop();
                      },
                      child: const Text('Удалить'),
                    ),
                  ],
                ),
              );
            },
            child: InkWell(
              onTap: () {
                int userId = _rows![index]['id'];
                showDialog(
                  context: context,
                  builder: (context) => EditUserDialog(
                    userId: userId,
                    myDb: myDb,
                    onUserUpdated: _refreshRow,
                  ),
                );
              },
              child: ListTile(
                title: Text(_rows![index]['name'] ?? ''),
              ),
            ),
          );
        },
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}








