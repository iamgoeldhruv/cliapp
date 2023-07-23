import 'dart:io';
import 'package:args/args.dart';
import './register.dart';
import './login.dart';
import './logout.dart';
import './joinserver.dart';
import './createserver.dart';
import './server.dart';

void main(List<String> args) async {
  print("WELCOME TO DISCORD CLI");
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
      break;
    } else if (comm == 'register') {
      await register();
    } else if (comm == 'login') {
       await loginn();
    } 
    else if (comm == 'logout') {
      await logoutt();
    } else if (comm == 'joinserver') {
      await joinserver();
    } else if (comm == 'createserver') {
       await createserver();
    }
    else if (comm=='addrole'){
      await addrole();
    }
   
  }
}
