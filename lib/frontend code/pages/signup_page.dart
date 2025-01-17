import 'package:flutter/material.dart';
import 'package:mediease_app/backend%20code/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for email and password text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Create an instance of AuthService
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Email TextField
              Container(
                width: 300,
                height: 40,
                padding: EdgeInsets.all(8.0), // Padding inside the container
                decoration: BoxDecoration(
                  color: Color(0xff9AD4CC), // Background color of the container
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email address", // Placeholder text
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // Style of placeholder text
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Email TextField
              Container(
                width: 300,
                height: 40,
                padding: EdgeInsets.all(8.0), // Padding inside the container
                decoration: BoxDecoration(
                  color: Color(0xff9AD4CC), // Background color of the container
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Your Password", // Placeholder text
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // Style of placeholder text
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Email TextField
              Container(
                width: 300,
                height: 40,
                padding: EdgeInsets.all(8.0), // Padding inside the container
                decoration: BoxDecoration(
                  color: Color(0xff9AD4CC), // Background color of the container
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Confirm Your Password", // Placeholder text
                    hintStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // Style of placeholder text
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),

              const SizedBox(height: 35),

              MaterialButton(
                onPressed: () {},
                minWidth: 300,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Color(0xff05808C),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                "or sign up with",
                style: TextStyle(fontSize: 12),
              ),

              SizedBox(
                height: 16,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      try {
                        final userCredential =
                            await _authService.signInWithGoogle();
                        if (userCredential.user != null) {
                          await _firestore
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set({
                            'name': userCredential.user!.displayName,
                            'email': userCredential.user!.email,
                            'profilePicture': userCredential.user!.photoURL,
                            'createdAt': FieldValue.serverTimestamp()
                          });
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google Sign-In failed: $e')),
                        );
                      }
                    },
                    // Handle the sign-in logic here

                    shape: CircleBorder(), // This makes the button circular
                    padding: EdgeInsets.all(
                        20), // Adjust padding for size of the circle
                    elevation: 5, // Shadow of the button
                    color: Colors.white, // Background color of the button
                    child: ClipOval(
                        // This ensures the image is circular inside the button
                        child: Text("Google")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      // Handle the sign-in logic here
                    },
                    shape: CircleBorder(), // This makes the button circular
                    padding: EdgeInsets.all(
                        20), // Adjust padding for size of the circle
                    elevation: 5, // Shadow of the button
                    color: Colors.white, // Background color of the button
                    child: ClipOval(
                        // This ensures the image is circular inside the button
                        child: Text("FB")),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              Container(
                width: 250,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By continuing, you agree to ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10), // Color for first part
                      ),
                      TextSpan(
                        text: 'MediEase User Service Agreement ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10), // Color for second part
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10), // Color for third part
                      ),
                      TextSpan(
                        text: 'Privacy Policy ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10), // Color for second part
                      ),
                      TextSpan(
                        text:
                            'and understand how we collect, use, and share your data. ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10), // Color for first part
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Expanded(
                child: Container(
                  height: 100, // Fixed height of the container at the bottom
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xffD9D9D9),
                  child: Center(child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12), // Color for first part
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12), // Color for second part
                      ),
                      
                    ],
                  ),
                ),),
                ), // This will fill the remaining space
              ),
            ],
          ),
        ),
      ),
    );
  }
}
