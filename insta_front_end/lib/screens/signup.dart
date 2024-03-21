import 'package:flutter/material.dart';
import 'package:insta_front_end/models/motherPage.dart';
import 'package:insta_front_end/screens/login.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class Signup extends StatefulWidget {

  static String routName = 'signup';
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool hidePassword =true;

  late String username='';
  late String password;
  late String confirmPassword;

  final usernametextcontroller = TextEditingController();
  final passwordtextcontroller = TextEditingController();
  final confirmPasswordcontroller = TextEditingController();


  FocusNode _usernamefocusNode = FocusNode();
  FocusNode _passwordfocusNode = FocusNode();
  FocusNode _confirmPasswordfocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<data>(context).signup;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(title: Text("Top Follow",style: TextStyle(color: Colors.lightBlue),),backgroundColor: Color(0xFFEEEDED),centerTitle: true,),
      body: GestureDetector(
        onTap: (){
          setState(() {
            _usernamefocusNode.unfocus();
            _passwordfocusNode.unfocus();
            _confirmPasswordfocusNode.unfocus();
          });
        },
        child: Center(
          child: Container(
             // color: Colors.white,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  // height: 500,
                  width: double.infinity,
                  // color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Leegram",style: TextStyle(fontFamily: "LobsterTwo-Regular",fontSize: 40,fontWeight: FontWeight.bold),),
                      SizedBox(height: 35,),
                      TextField(
                        focusNode: _usernamefocusNode,
                        controller: usernametextcontroller,
                        onChanged: (val){
                          username = val;
                        },
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            filled: true,
                            fillColor: Colors.black,
                            contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 6),
                            hintText: "Phone number, email or username",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.person)

                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        focusNode: _passwordfocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        textAlignVertical: TextAlignVertical.top,
                        //textAlign: TextAlign.center,
                        controller: passwordtextcontroller,
                        onChanged: (val){
                          password = val;
                        },
                        style: TextStyle(fontSize: 14),
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Change the border color here
                          ),
                          filled: true,
                          fillColor: Colors.black,
                          contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 6),
                          hintText: "Password",
                          suffix: hidePassword?TextButton(child: Text("Show",style: TextStyle(color: Colors.white)),onPressed: (){
                            setState(() {
                              hidePassword=!hidePassword;
                            });

                          },):TextButton(
                              onPressed: (){
                                setState(() {
                                  hidePassword=!hidePassword;
                                });
                              }, child: Text("Hide",style: TextStyle(color: Colors.white),)),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        focusNode: _confirmPasswordfocusNode,
                        textAlignVertical: TextAlignVertical.top,
                        //textAlign: TextAlign.center,
                        controller: confirmPasswordcontroller,
                        onChanged: (val){
                          confirmPassword = val;
                        },
                        style: TextStyle(fontSize: 14),
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Change the border color here
                          ),
                          filled: true,
                          fillColor: Colors.black,
                          contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 6),
                          hintText: "Confirm Password",
                          suffix: hidePassword?TextButton(child: Text("Show",style: TextStyle(color: Colors.white)),onPressed: (){
                            setState(() {
                              hidePassword=!hidePassword;
                            });

                          },):TextButton(
                              onPressed: (){
                                setState(() {
                                  hidePassword=!hidePassword;
                                });
                              }, child: Text("Hide",style: TextStyle(color: Colors.white),)),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      SizedBox(height: 10,),
                      ElevatedButton(
                          onPressed: () async{
                            // if(await userData(username,password)){
                            //   print("lee");
                            //   Navigator.pushNamed(context, homePage.routName);
                            // }
                            if(confirmPassword==password){
                              if(await userData(username,password)){

                                Navigator.pushNamed(context, Login.routName);
                              };
                            }
                            if(username!=""&&password!=""){
                              usernametextcontroller.clear();
                              passwordtextcontroller.clear();
                              confirmPasswordcontroller.clear();
                              setState(() {
                                _usernamefocusNode.unfocus();
                                _passwordfocusNode.unfocus();
                                _confirmPasswordfocusNode.unfocus();
                              });
                            }

                          },
                          child: Text("Sign Up"),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 48.0), // Adjust the height value as needed
                            ),

                          )
                      ),
                      SizedBox(height: 15,),
                      Text("Forgot your login details? Get help logging in"),
                      SizedBox(height: 15,),
                      Divider(thickness: 3,),
                      SizedBox(height: 15,),
                      Text("OR"),
                      TextButton(onPressed: (){}, child: Text("Login with your Facebook",))
                    ],
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, Login.routName);
                    }, child: Text("Login")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
