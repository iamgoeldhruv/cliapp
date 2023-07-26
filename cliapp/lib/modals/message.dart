import 'package:mongo_dart/mongo_dart.dart';
class Message{
  String?sender;
  String?receiver;
  String?servername;
  String?categoryname;
  String?channelname;
  String?message;
  Db?_db;
  Message(sender,connectionstring,message){
    this.sender=sender;
    _db=Db(connectionstring);
    this.message=message;

  

  }
  Future<void>dm(receiver)async{
    await _db!.open();

    
    final userMessageCollection = _db!.collection('usermessage');

    final userDocument = await userMessageCollection.findOne(where.eq('username', receiver));
    if (userDocument != null) {
      Map<String, dynamic> newMessageMap = userDocument['newmessage'] ?? {};

      newMessageMap[sender!] = message;

      await userMessageCollection.update(where.eq('username', receiver), modify.set('newmessage', newMessageMap));

      print('Message added to $receiver by $sender.');
      await _db!.close();
      

    
  }
}
Future<void>msgServer(servername,category,channel)async{
   
  try {
     await _db!.open();

    final servernameCollection = _db!.collection('servername');
    final serverDocument = await servernameCollection.findOne(where.eq('servername', servername));

    if (serverDocument != null) {
      Map<String, dynamic> messagesMap = serverDocument['messages'] ?? {};

      if (channel == null) {
        print('Channel cannot be null.');
        return;
      }

      if(messagesMap[channel]==null){
        messagesMap[channel]={};
        messagesMap[channel][sender]=message;



      }
      else{
         messagesMap[channel][sender]=message;



      }
     
      
      await servernameCollection.update(where.eq('servername', servername), modify.set('messages', messagesMap));
      print('Message added to $channel (channel) by $sender.');
    } else {
      print('Server not found in the database.');
    }
  } catch (e) {
    print('Error accessing the database: $e');
  } finally {
    await _db!.close();
  }
  }
  
}





