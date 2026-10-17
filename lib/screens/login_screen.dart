import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/email_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  EmailAuth? _emailAuth;
  final conUser = TextEditingController();
  final conPwd = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailAuth=EmailAuth();
  }


  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtUser = TextFormField(
      controller: conUser,
      decoration: InputDecoration(
        border: OutlineInputBorder()
      ),
    );
    final txtPwd = TextFormField(
      controller: conPwd,
      decoration: InputDecoration(
        border: OutlineInputBorder()
      ),
      obscureText: true,
    );

    final loading =  Positioned(
      top:100,
      child: const CircularProgressIndicator()
    );

    final btnLogin = ElevatedButton(
      onPressed: (){
        isLoading = !isLoading;
        setState(() { });      
        _emailAuth!.m_loginUser(user: conUser.text, password: conPwd.text).then((
          value
          ){
          if(value){
            Navigator.pushNamed(context, "/dash");
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Usuario o contraseña incorrectos'),
                duration: Duration(seconds: 3),
              )
            );
          }
          isLoading = false;
          setState(() {});
        });
      }, 
      child: Row(
        children: [
          Icon(Icons.login),
          Text('Iniciar Sesion')
        ]
      ) 
    );

    final space = Container(height: 5,);
    final space2 = SizedBox(height: 5,);


    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit:BoxFit.cover,
            image: AssetImage('assets/fondo.png')
          )
        ),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Image.asset('assets/spiderman.png', height: 110,),
            Positioned(
              bottom: 100,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    txtUser,
                    Divider(),
                    txtPwd,
                    Divider(),
                    btnLogin,
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, "/register");
                      }, 
                      child: Text(
                        '¿No tienes una cuenta?',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
                height: 280,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: Color(0x99FFFFFF)
                ),
              ),
            ),
            isLoading ? loading : Container()
          ],
        )
      ),
    );
  }
}