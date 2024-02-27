


import 'package:fbills/data/db.dart';
import 'package:fbills/widgets/add_bill.dart';
import 'package:flutter/material.dart';


class UsersRow extends StatefulWidget {
   final MyDatabase myDb;
   const UsersRow({ Key? key, required this.myDb }) : super(key: key);

  @override
  State<UsersRow> createState() => _UsersState();
}

class _UsersState extends State<UsersRow> {
   List<Map<String, dynamic>> _data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователи'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green,
        child: SizedBox(
          width: double.infinity,
          child: ListView(  
            children:_data.map((data) => Item(UserRowData:data)).toList() //dataRow.map((data) => Item(BillsRowData: data,)).toList(),
          )
          ),
      ),
    floatingActionButton: const floatActionButton(),
    );
  }
}

// ignore: must_be_immutable
class Item extends StatefulWidget {

   // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
var UserRowData;

  // ignore: non_constant_identifier_names
  Item({super.key, required UserRowData});

  @override
  State<Item> createState() => _itemState();
}

// ignore: camel_case_types
class _itemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Row(
        
        children: [
          const Icon(Icons.arrow_circle_right_outlined),
          const SizedBox(width: 20,),
          Expanded(child:Text(widget.UserRowData.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,),
          )
          ),
          const SizedBox(width: 200,),
      
        ],
      ),
    );
  }
}




class floatActionButton extends StatelessWidget {
  const floatActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
       child: const Icon(Icons.add,),
      onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBill()));
        },
        );
  }
}


class URow extends StatelessWidget {
  const URow({super.key, required this.myDb});

final MyDatabase myDb;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myDb.getAllRows(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          
          return const Text('Loading...');
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(snapshot.data![index]['name']),
            );
          },
        );
      },
    );
  }
}