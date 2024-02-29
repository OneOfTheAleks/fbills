
import 'package:fbills/data/db.dart';
import 'package:fbills/widgets/bills.dart';
import 'package:fbills/widgets/user_list.dart';
import 'package:flutter/material.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();

final   db = await DatabaseHelper.instance.database;
 final myDb = MyDatabase(db: db);
  runApp( MyApp(myDb: myDb,));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key, required this.myDb});
final MyDatabase myDb;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Bills',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TabBarMain(myDb: myDb,)
    );
  }
}



class TabBarMain extends StatelessWidget {
  const TabBarMain({super.key, required this.myDb});
  
 final MyDatabase myDb;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Bills'),
          ),
          body:  TabBarView(
            children: [
              const Bills(),
              UsersList(myDb: myDb),
              const Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}




// ignore: camel_case_types
class tabBar extends StatelessWidget {
  const tabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            )
            )
    );
  }
  
}

