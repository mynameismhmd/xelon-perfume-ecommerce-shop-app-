import 'package:auth1/a%20new%20profile%20page.dart';
import 'package:auth1/arsignup.dart';
import 'package:auth1/phoneauth.dart';
import 'package:auth1/phoneauthar.dart';
import 'package:auth1/seconddialog.dart';
import 'package:auth1/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'aranimateddialog.dart';
import 'arlogin.dart';
import 'login.dart';
import 'signupp.dart';
class arWelcomeScreen extends StatefulWidget {
  const arWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<arWelcomeScreen> createState() => _arWelcomeScreen();
}

class _arWelcomeScreen extends State<arWelcomeScreen> {
   final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<UserCredential?> _signInWithGoogle() async {
    // Attempt to sign in with Google.
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // If the user has not selected an account, return null.
    if (googleUser == null) {
      return null;
    }

    // Authenticate with Firebase using the GoogleSignInAccount.
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the OAuth credential.
    return await _auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title:const Text("Google Sign in"),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/efetu1copy.png",),fit: BoxFit.cover
          )
        ),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height:460),
                Padding(
                  
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: 330,
                      
                    child: ElevatedButton(
                       
                      onPressed: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>arloginpagee()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent,
                        elevation: 9,
                         
                         padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                         
                         
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      child: const Text("تسجيل الدخول باستخدام الايميل",style: TextStyle(fontSize:16,fontFamily: 'nz',color: Colors.black),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: 330,
                    child:  OutlinedButton(
                      onPressed:() async {


                        final UserCredential? userCredential = await _signInWithGoogle();

                        if(UserCredential!=null)
                          {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>const argAnimatedDialog(imagePath: 'assets/loading.gif', message: 'تم تسجيل الدخول بنجاح', title: '',)));
                          }
                          else {
          // Show an error message if sign in was unsuccessful.
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('فشل تسجيل الدخول',style: TextStyle(fontFamily: 'nz'),),
          ));
        }

                    },
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(25),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),side:const BorderSide(color: Colors.redAccent,width: 30)),backgroundColor: Colors.white,elevation:9),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 14),
                            child: Tab(child: Image(image:AssetImage("assets/googlelogo.png"),),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text("تسجيل الدخول باستخدام غوغل",style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'nz')),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: SizedBox(
                    width: 330,
                    child:  OutlinedButton(
                      onPressed:(){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>const arPhoneScreen()));
                      },
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(25),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),
                                 side:const BorderSide(color: Colors.redAccent,width: 30)),
                          backgroundColor: Colors.white,elevation:9),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: Tab(child:Icon(Icons.phone)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Text("تسجيل الدخول باستخدام الهاتف",style: TextStyle(fontFamily:'nz',color: Colors.black,fontSize: 16)),
                          )
                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(
                  child: TextButton(
                    child: const Text("مستخوم سابق سجل الدخول هنا...",style: TextStyle(fontFamily:'nz',color: Colors.yellowAccent),),
                    onPressed:() {Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=> arLoginPage()));},),),
              ],
            )
          ],
        ),
      ),
    );
  }
}



