import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmonyhubhest/home_page.dart';
import 'register_page.dart';
import 'package:harmonyhubhest/style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final firebaseFirestore = FirebaseFirestore.instance;
  bool _emailColor = false;
  bool _passwordColor = false;
  String _emailLabelText = 'Email';
  String _passwordLabelText = 'Пароль';
  bool _errorMessage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.cyanAccent
              ],
            begin: Alignment(-1,-1),
            end: Alignment(1,1)
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('HarmonyHub', style: fugazOneLogo),
              SizedBox(
                height: 70,
              ),
              Visibility(
                visible: _errorMessage,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.red.withOpacity(0.5)))
                  ),
                  child: Text('Неверный Email или пароль!', style: interFS20White24),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                style: interFS15,
                decoration: InputDecoration(
                  fillColor: Colors.red.withOpacity(0.4),
                  filled: _emailColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black26, width: 2)
                  ),
                    labelText: _emailLabelText,
                    labelStyle: interFS15White24,
                    border: OutlineInputBorder()
                ),
                onTap: (){
                  setState(() {
                    _emailLabelText = 'Email';
                    _emailColor = false;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                style: interFS15,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.redAccent.withOpacity(0.4),
                    filled: _passwordColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black26, width: 2)
                    ),
                    labelText: _passwordLabelText,
                    labelStyle: interFS15White24,
                    border: OutlineInputBorder()
                ),
                onTap: (){
                  setState(() {
                    _passwordLabelText = 'Пароль';
                    _passwordColor = false;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: (){

                      },
                    child: Text('Забыли пароль?', style: interFS15),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text('Регистрация', style: interFS15),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  if(_emailController.text.isEmpty){
                    setState(() {
                      _emailColor = true;
                      _emailLabelText = 'Введите Email!';
                    });
                  }
                  if(_passwordController.text.isEmpty){
                    setState(() {
                      _passwordColor = true;
                      _passwordLabelText = 'Введите пароль!';
                    });
                  }
                  if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      // Navigate to next screen after successful login
                      print('Login successful');

                      firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
                        'uid':userCredential.user!.uid,
                        'email':userCredential.user!.email,
                        'trackTitle':'',
                        'trackAuthor':''
                      }, SetOptions(merge: true));

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

                    } catch (e) {
                      // Show error message
                      setState(() {
                        _passwordController.clear();
                        _emailController.clear();
                        _errorMessage = true;
                      });
                      print('Error: $e');
                    }
                  }
                  },
                child: Text('Продолжить', style: interFS15),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black26.withOpacity(0.01),
                  minimumSize: Size(100, 40)
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}