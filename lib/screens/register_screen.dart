import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  EmailAuth? _emailAuth;
  
  @override
  void initState() {
    super.initState();
    _emailAuth=EmailAuth();
  }

  final conUser = TextEditingController();
  final conEmail = TextEditingController();
  final conPwd = TextEditingController();
  final conConfirmPwd = TextEditingController();


  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    

    final txtName = TextFormField(
      controller: conUser,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Nombre',
        hintStyle: TextStyle(
          color: Colors.black
        )
      ),
    );

    final txtEmail = TextFormField(
      controller: conEmail,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Correo electrónico',
        hintStyle: TextStyle(
          color: Colors.black
        )
      ),
      keyboardType: TextInputType.emailAddress,
    );

    final txtPwd = TextFormField(
      controller: conPwd,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Contraseña',
        hintStyle: TextStyle(
          color: Colors.black
        )
      ),
      obscureText: true,
    );

    final txtConfirmPwd = TextFormField(
      controller: conConfirmPwd,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Confirmar contraseña',
        hintStyle: TextStyle(
          color: Colors.black
        )
      ),
      obscureText: true,
    );

    final btnRegister = ElevatedButton(
      onPressed: () {
        _emailAuth!.m_creaUsuario(user: conUser.text, email: conEmail.text, password: conPwd.text, confirmPassword: conConfirmPwd.text).then((value){
          if(value){
            ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Se registro correctamente el usuario"),
                      duration: Duration(seconds: 3),
                    ),
                  );
            Navigator.pop(context);
          }
        });
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_add),
          SizedBox(width: 8),
          Text('Registrarme'),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/fondo.png'),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [

            Image.asset(
              'assets/spiderman.png',
              height: 100,
            ),

            Positioned(
              bottom: 40,
              child: Container(
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .9,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0x99FFFFFF),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Text(
                      'Crear cuenta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    txtName,
                    const SizedBox(height: 8),
                    txtEmail,
                    const SizedBox(height: 8),
                    txtPwd,
                    const SizedBox(height: 8),
                    txtConfirmPwd,
                    const SizedBox(height: 10),
                    Divider(),
                    btnRegister,
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Ya tengo una cuenta',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}