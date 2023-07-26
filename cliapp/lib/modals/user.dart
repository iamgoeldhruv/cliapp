import 'package:mongo_dart/mongo_dart.dart';
class user{
  String? username;
  Db ?_db;
  
  String? password;
  user(username,connectionstring1,password){
    this.username=username;
    this.password=password;
    _db=Db(connectionstring1);
    
  }
  Future<void> register() async {
    await _db?.open();
    final collection = _db?.collection('userdata');
    final document = {
      '_id': ObjectId(), // Generate ObjectId for _id field
      'username': username,
      'password': password,
    };
    await collection?.insert(document);
    await _db?.close();
  }
  Future<void> login(String username, String password) async {
     await _db?.open();
    final collection = _db?.collection('activeuser');
    final document = {
      '_id': ObjectId(), // Generate ObjectId for _id field
      'username': username,
      'password': password,
    };
    await collection?.insert(document);
     await _db?.close();
  }



}