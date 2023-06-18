
import 'package:auth1/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'forgotpassword.dart';
import 'maps.dart';

class loginpagee extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  loginpagee({super.key});

  Future<void> navigateToNextPage(BuildContext context) async {
    final String phoneNumber = phoneNumberController.text;
    final String email = emailController.text;
    final String name = nameController.text;
    final String password = passwordController.text;

    try {
      // Create a new user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the generated user ID
      String userId = userCredential.user!.uid;

      // Store email in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'email': email});

      // Store additional user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': name,
        'phoneNumber': phoneNumber,
      });

      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapPage(

          ),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during authentication or data storage
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 360),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextField(
  controller: nameController,
  style: const TextStyle(
    fontSize: 18,
    color: Colors.white,
  ),
  textAlign: TextAlign.center,
  decoration: const InputDecoration(
    hintText: 'Enter name',
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    filled: true,
    fillColor: Colors.transparent,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  ),
),
const SizedBox(height: 20),
                      TextField(
                         keyboardType: TextInputType.number, // Set the keyboard type to number
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
  ],
                        controller: phoneNumberController,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Enter phone number',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: emailController,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Enter email',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Enter password',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ForgotPasswordScreen(),
                                  ));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            navigateToNextPage(context);
                          },

                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                          ),
                        ),
                      ),
                          child: const Text('Next'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ))],
    );
  }
}
class NextPage extends StatelessWidget {
  final String phoneNumber;
final String email;
final String password;
final String name;

  const NextPage({super.key, required this.phoneNumber,required this.email,required this.password,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phone Number: $phoneNumber'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform any action on button press
              },
              child: const Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_blue.png'),
            fit: BoxFit.cover,
          )),
    );
  }
}