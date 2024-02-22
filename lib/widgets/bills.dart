import 'package:fbills/widgets/add_bill.dart';
import 'package:flutter/material.dart';
import 'package:fbills/models/models.dart';
    
class Bills extends StatefulWidget {

  const Bills({ Key? key }) : super(key: key);

  @override
  State<Bills> createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Счета'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green,
        child: SizedBox(
          width: double.infinity,
          child: ListView(          
            children: dataRow.map((data) => Item(BillsRowData: data,)).toList(),
          )
          ),
      ),
    floatingActionButton: const floatActionButton(),
    );
  }
}

// ignore: camel_case_types
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




// ignore: must_be_immutable
class Item extends StatefulWidget {

   // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
var BillsRowData;

  // ignore: non_constant_identifier_names
  Item({super.key,this.BillsRowData});

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
          Expanded(child:Text(widget.BillsRowData.name,
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