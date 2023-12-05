import 'package:lab_test/Controller/sqlite_db.dart';
import '../Controller/request_Controller.dart';

class Expense{
  static const String SQLiteTable = "bmi";
  int? id;
  String username;
  double weight;
  double height;
  int gender;
  String bmi_status;

  Expense (this.id, this.username, this.weight, this.height, this.gender, this.bmi_status);

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        username = json['username'] as String,
        weight = double.parse(json['weight'] as dynamic),
        height = double.parse(json['height'] as dynamic),
        gender = int.parse(json['gender'] as dynamic),
        bmi_status = json['bmi_status'] as String;

  Map<String, dynamic> toJson() => {
    'id': id, 'username': username, 'weight': weight, 'height': height, 'gender':gender, 'bmi_status':bmi_status
  };

  Future<bool> save() async{
    //Save to local SQLite
    await SQLiteDB().insert(SQLiteTable, toJson());

    //API Operation
    RequestController req = RequestController(path: "/api/expenses.php");
    req.setBody(toJson());
    await req.post();
    if (req.status() == 200){
      return true;
    }
    else {
      if (await SQLiteDB().insert(SQLiteTable, toJson()) != 0){
        return true;
      }
      else {
        return false;
      }
    }
  }
/*
  Future<bool> update() async{

    await SQLiteDB().update(SQLiteTable, 'id', toJson());

    RequestController req = RequestController(path: "/api/expenses.php");
    req.setBody(toJson());
    await req.put();
    if (req.status() == 200){
      return true;
    }
    else {
      if (await SQLiteDB().update(SQLiteTable, "id", req.setBody(toJson())) != 0){
        return true;
      }
      else {
        return false;
      }
    }
  }

  Future <bool> remove() async{
    RequestController req = RequestController(path: "/api/expenses.php");
    req.setBody(toJson());
    await req.delete();
    if (req.status() == 200){
      return true;
    }
    else{
      if (await SQLiteDB().delete(SQLiteTable, "id", id) != 0)
        return true;
      else
        return false;
    }
  }
*/
  static Future<List<Expense>> loadAll() async {
    List<Expense> result = [];
    RequestController req = RequestController(path: "/api/expenses.php");
    await req.get();
    if(req.status() == 200 && req.result() != null){
      for (var item in req.result()){
        result.add(Expense.fromJson(item));
      }
    }
    else{
      List<Map<String, dynamic>> result = await SQLiteDB().queryAll(SQLiteTable);
      List<Expense> expenses = [];

      for (var item in result){
        result.add(Expense.fromJson(item) as Map<String, dynamic>);
      }
    }
    return result;
  }
}
