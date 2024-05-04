import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmonyhubhest/main.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final firebaseFirestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введите ваш Email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Пароль'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введите ваш пароль';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                      );
                      // Navigate to next screen after successful register
                      print('Register successful');

                      firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
                        'uid':userCredential.user!.uid,
                        'email':userCredential.user!.email
                      });

                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                    } catch (e) {
                      // Show error message
                      print('Error: $e');
                    }
                  }
                },
                child: Text('Продолжить'),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                child: Text('Авторизация'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}