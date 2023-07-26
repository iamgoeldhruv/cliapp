import 'dart:io';
import 'package:args/args.dart';
import 'features/register.dart';
import 'features/login.dart';
import 'features/logout.dart';
import 'features/joinserver.dart';
import 'features/createserver.dart';
import 'features/addrole.dart';
import 'features/addcategory.dart';
import 'features/addchannel.dart';
import 'features/sendmessage.dart';
import 'features/inbox.dart';

void main(List<String> args) async {
  print("WELCOME TO DISCORD CLI");
  int a=0;
  while (true) {
    print("ENTER YOUR COMMAND");
    String? comm = stdin.readLineSync();

    if (comm == null || comm.isEmpty) {
      print("INVALID COMMAND PLEASE TRY AGAIN");
      continue;
    }

    List<String> parts = comm.split(' '); // Split the input by spaces

    if (parts.isEmpty) {
      print("INVALID COMMAND PLEASE TRY AGAIN");
      continue;
    }

    

    if (comm == 'exit') {
      a=0;
      await logoutt();
      break;
    } else if (comm == 'register') {
      await register();
    } else if (comm == 'login') {
      a=1;
       await loginn();
    }
    
     else if (comm == 'logout') {
      a=0;
      await logoutt();
      break;
    } else if (comm == 'joinserver') {
      if(a==1){await joinserver();}else{print("PLEASE LOGIN ");}
      
    } else if (comm == 'createserver') {
      if(a==1){await createserver();}else{print("PLEASE LOGIN ");}
    }
    else if (comm=='addrole'){
      if(a==1){await addrole();}else{print("PLEASE LOGIN ");}
    }
    else if (comm=='addcategory'){
      if(a==1){await addcategory();}else{print("PLEASE LOGIN ");}
    }
    else if (comm=='addchannel'){
      if(a==1){await addChannel();}else{print("PLEASE LOGIN ");}
    }
     else if (comm=='sendmessage'){
      if(a==1){await message();}else{print("PLEASE LOGIN ");}
    }
    else if (comm=='inbox'){
      if(a==1){await inbox();}else{print("PLEASE LOGIN ");}
    }
     else if (comm=='modusers'){
      if(a==1){await modusers();}else{print("PLEASE LOGIN ");}
    }
    else{
      print("INVALID COMMAND");
      a=0;
      await logoutt();
      
      break;
    }
   
  }
}
