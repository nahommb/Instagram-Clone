
import 'package:flutter/material.dart';
import 'package:leegram/provider/chatHistory.dart';
import 'package:leegram/provider/data.dart';
import 'package:leegram/screens/cc.dart';
import 'package:leegram/screens/chatListScreen.dart';
import 'package:leegram/screens/individualChatScreen.dart';
import 'package:leegram/screens/login.dart';
import 'package:leegram/screens/signup.dart';
import 'package:leegram/screens/storyScreen.dart';
import 'package:provider/provider.dart';
import 'models/motherPage.dart';

void main(){

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>data()),
        ChangeNotifierProvider(create: (context)=>ChatHistory())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Login(),
         theme: ThemeData.dark(),
        routes: {
          Login.routName:(context)=>Login(),
          YourWidget.routName:(context)=>YourWidget(),
          Signup.routName:(context)=>Signup(),
          homePage.routName:(context)=>homePage(),
          ChatListScreen.routName:(context)=>ChatListScreen(),
          StoriesScreen.routName:(context)=>StoriesScreen(),
          IndividualChatScreen.routName:(context)=>IndividualChatScreen(),

        },
      ),
    );
  }
}
