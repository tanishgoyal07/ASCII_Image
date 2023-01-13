import 'package:ascii_image/resources/auth_methods.dart';
import 'package:ascii_image/constants/loader.dart';
import 'package:ascii_image/constants/utils.dart';
import 'package:ascii_image/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = "Error";
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      style: const TextStyle(
        color: GlobalVariables.mainColor,
      ),
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Your Email",
        hintStyle: GlobalVariables.customStyle,
      ),
    );

    //password field
    final passwordField = TextFormField(
      style: const TextStyle(
        color: GlobalVariables.mainColor,
      ),
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: GlobalVariables.mainColor),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Your Password",
        hintStyle: GlobalVariables.customStyle,
      ),
    );

    final loginButton = Material(
      elevation: 5,
      color: Colors.grey,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          setState(() {
            if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
              isloading = true;
            }
          });
          AuthMethods().signIn(
            emailController.text,
            passwordController.text,
            _formKey,
            errorMessage,
            context,
          );
        },
        child: isloading
            ? const Loader()
            : Text(
                "Login",
                textAlign: TextAlign.center,
                style: GoogleFonts.courierPrime(
                  fontSize: 20,
                  color: GlobalVariables.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );

    return Scaffold(
      backgroundColor: GlobalVariables.secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: Text(
          "ascii-studio\\login",
          style: GoogleFonts.courierPrime(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: GlobalVariables.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 250,
                        child: Image.asset(
                          "assets/as_logo.jpg",
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(height: 45),
                    emailField,
                    const SizedBox(height: 14),
                    passwordField,
                    const SizedBox(height: 26),
                    loginButton,
                    const SizedBox(height: 45),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.courierPrime(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: Text(
                              "SignUp",
                              style: GoogleFonts.courierPrime(
                                  color: GlobalVariables.mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
