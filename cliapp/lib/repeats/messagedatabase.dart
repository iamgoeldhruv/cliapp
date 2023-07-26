import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';
class messageDatabase {
  Db ?_msg;
 

  messageDatabase(String connectionString) {
  _msg = Db(connectionString);
    

    
  }
  Future<void> connect() async {
    await _msg?.open();
    
  }
  Future<void> writeuser(username)async{
    await _msg?.open();
    final collection = _msg?.collection('usermessage');
    final document = {
      '_id': ObjectId(), // Generate ObjectId for _id field
      'username': username,
      'inbox':{},
      'newmessage':{}
    };
    await collection?.insert(document);
     await _msg?.close();

  }
  Future<void> readmessage(username)async{
      await _msg?.open();
    final collection = _msg?.collection('usermessage');
     final document = await collection!.findOne(where.eq('username', username));
      if (document != null && document.containsKey('newmessage')){print(document['newmessage']);}
     
       await _msg?.close();

  }
  Future<void> disconnect() async {
    await _msg?.close();
  }
  

}