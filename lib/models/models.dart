class BillsRowData {
 String name;
 int userId;

  BillsRowData({required this.name, required this.userId});

}

List<BillsRowData> dataRow = <BillsRowData>[
  BillsRowData(name:'Жопа',userId:1),
  BillsRowData(name:'Жопа 2',userId:2),
   BillsRowData(name:'Жопа 3',userId:3),
  BillsRowData(name:'Жопа 4',userId:4),
   BillsRowData(name:'Жопа 5',userId:5),
  BillsRowData(name:'Жопа 6',userId:6),
   BillsRowData(name:'Жопа 7',userId:7),
  BillsRowData(name:'Жопа 8',userId:8),
   BillsRowData(name:'Жопа 9',userId:9),
  BillsRowData(name:'Жопа 10',userId:10),
   BillsRowData(name:'Жопа 11',userId:11),
  BillsRowData(name:'Жопа 12',userId:12),
];

abstract class Model {
 
late int id;
    
    static fromMap() {}
    toMap() {}
}

class BillItem extends Model{
 static String table = 'bill_items';
  int id;
 String name;
 int operationType;  // тип операции
 double remains;  //остаток

BillItem({ required this.id, required this.name, required this.operationType,required this.remains });
  @override
  Map<String, dynamic> toMap() {
     Map<String, dynamic> map = {
            'name': name,
            'operationType': operationType,
            'remains': remains,
            'id': id 
        };

         return map;
  }
  static BillItem fromMap(Map<String, dynamic> map) {
         return BillItem(
            id: map['id'],
            name: map['name'],
            operationType: map['operationType'], 
            remains: map['remains']);
  }

}


class UserList extends Model{
 static String table = 'user_items'; 
 String name;
 
  var id;

UserList({ required this.id, required this.name });
  @override
  Map<String, dynamic> toMap() {
     Map<String, dynamic> map = {
            'name': name,
            'id': id 
        };

         return map;
  }
  static UserList fromMap(Map<String, dynamic> map) {
         return UserList(
            id: map['id'],
            name: map['name']);
  }





}


class User {
 static String name = '';
 static String note ='';
 static int id = 0;
}
