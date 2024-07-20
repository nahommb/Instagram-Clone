
import 'package:flutter/material.dart';
import 'package:insta_front_end/provider/chatHistory.dart';
import 'package:insta_front_end/provider/data.dart';
import 'package:insta_front_end/provider/post.dart';
import 'package:insta_front_end/screens/cc.dart';
import 'package:insta_front_end/screens/chatListScreen.dart';
import 'package:insta_front_end/screens/individualChatScreen.dart';
import 'package:insta_front_end/screens/login.dart';
import 'package:insta_front_end/screens/newPostScreen.dart';
import 'package:insta_front_end/screens/signup.dart';
import 'package:insta_front_end/screens/storyScreen.dart';
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
        ChangeNotifierProvider(create: (context)=>ChatHistory()),
        ChangeNotifierProvider(create: (context)=>Post())
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
          NewPostScreen.routName:(context)=>NewPostScreen(),
        },
      ),
    );
  }
}
