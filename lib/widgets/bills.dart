import 'package:flutter/material.dart';
import 'package:fbills/models/data.dart';
    
class Bills extends StatelessWidget {

  const Bills({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Счета'),
        backgroundColor: Colors.green,
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(          
          children: dataRow.map((data) => item(BillsRowData: data,)).toList(),
        )),
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
      onPressed: () {  },);
  }
}




class item extends StatelessWidget {

   // ignore: non_constant_identifier_names
var BillsRowData;

  // ignore: non_constant_identifier_names
  item({super.key,this.BillsRowData});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Row(
        
        children: [
          const Icon(Icons.arrow_circle_right_outlined),
          SizedBox(width: 20,),
          Expanded(child:Text(BillsRowData.name,
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