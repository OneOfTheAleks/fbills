import 'package:flutter/material.dart';
    


class AddBill extends StatelessWidget {
  const AddBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить счет')),
      body: const Center(child: 
      BtmBack()
      ),
    );
  }
}

class BtmBack extends StatelessWidget {
  const BtmBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: (){
      Navigator.pop(context);
    }, child: const Text('Ок'));
  }
}