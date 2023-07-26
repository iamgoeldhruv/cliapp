import 'package:mongo_dart/mongo_dart.dart';
class Channel{
  String? servername;
  String? username;
  String? channelname;
  Db?_db;
  Channel(this.servername,this.channelname,connectionString){
    _db=Db(connectionString);
    
  }
  Future<void> addIndependentChannel()async{
    await _db?.open();

    final servernameCollection = _db!.collection('servername');
   
     

     
    final updateResult = await servernameCollection.update(
    where.eq('servername', servername),
   
    modify.addToSet('channel', channelname),
    
    );
    print("Channel created successfully");
   
    await _db?.close();}
  Future<void>addChannelInCategory(categoryname)async{
    await _db?.open();

    final servernameCollection = _db?.collection('servername');

    final serverDocument = await servernameCollection!.findOne(where.eq('servername', servername));
    if (serverDocument != null) {
      Map<String, dynamic> catandchMap = serverDocument['catandch'];

      // Add the channel to the specified category
      catandchMap[categoryname] ??= [];
      catandchMap[categoryname]!.add(channelname!);

      // Update the document with the modified catandch map
      await servernameCollection.update(where.eq('servername', servername), modify.set('catandch', catandchMap));

      print('Channel added to $categoryname category for server $servername.');


  }
}
}