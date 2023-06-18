import 'package:auth1/signupp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class arForgotPasswordScreen extends StatefulWidget {
  const arForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _arForgotPasswordScreenState createState() => _arForgotPasswordScreenState();
}

class _arForgotPasswordScreenState extends State<arForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
        // Password reset email sent successfully
        // You can display a success message or handle it accordingly

        // Wait for password reset completion
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(' تمإعادة تعيين كلمة المرور',style: TextStyle(fontFamily: 'nz'),),
              content: const Text('يرجى التحقق من بريدك الإلكتروني لإكمال إعادة تعيين كلمة المرور.',style: TextStyle(fontFamily: 'nz'),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  },
                  child: const Text('اوكي'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print('Failed to send password reset email: $e');
        // Display an error message or handle the error accordingly
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اعادة تعيين الباسوورد',style: TextStyle(fontFamily: 'nz'),),
      ),
      body: Stack(
        children: [
          const BackgroundImage(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                      decoration: const InputDecoration(
                        labelText: 'الايميل',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'nz'// Set your desired color here
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'رجاءا أدخل بريدك الإلكتروني';
                        }
                        return null;
                      },
                      controller: _emailController,
                    ),
                    ElevatedButton(
                      onPressed: _resetPassword,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                      ),
                      child: const Text('إعادة تعيين كلمة المرور',style: TextStyle(fontFamily: 'nz'),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResetPasswordSuccessScreen extends StatelessWidget {
  const ResetPasswordSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset Success'),
      ),
      body: const Center(
        child: Text(
          'Password reset email sent successfully!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_blue.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
