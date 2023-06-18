
import 'package:auth1/dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  

    
    
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String id = 'chat';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  late String _email, _password, _username;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User?> _handleSignIn() async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  return userCredential.user;
}

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': _username,
        'email': _email,
      });

      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
  Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnimatedDialog(title: '', message: 'success', imagePath: 'assets/loading.gif',),

                ),
          );
        
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              
                children: <Widget>[
                  
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a username.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  
                  const SizedBox(height: 16.0),
                  _isLoading
                      ? const CircularProgressIndicator():
                      ElevatedButton(
                          child: const Text('Sign Up'),
                          onPressed: () {
                            if (_formKey.currentState != null) {
  _formKey.currentState?.validate();
} {
                              _formKey.currentState?.save();
                              _submit();
                            }
                          },
                        ),
                        ElevatedButton(
  onPressed: () async {
    User? user = await _handleSignIn();
    if (user != null) {
     Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnimatedDialog(title: '', message: 'success', imagePath: 'assets/loading.gif',),

                ),
          ); // user is signed in, navigate to home screen or do something else
    } else {
      // sign-in failed
    }
  },
  child: const Text('Sign in with Google'),
)
                        
                ],
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}
