import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Estado para ocultar/mostrar la contraseña
  bool _obscurePassword = true;

  // Controladores de la animación
  StateMachineController? controller;
  SMIBool? isChecking;
  SMIBool? isHandsUp;
  SMITrigger? trigSuccess;
  SMITrigger? trigFail;

  // Focus nodes
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_onFocusChange);
    _passwordFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (isHandsUp == null || isChecking == null) return;

    // Ningún campo seleccionado
    if (!_emailFocus.hasFocus && !_passwordFocus.hasFocus) {
      isChecking!.change(false);
      isHandsUp!.change(false);
    }
    // Email seleccionado
    else if (_emailFocus.hasFocus) {
      isChecking!.change(true);
      isHandsUp!.change(false);
    }
    // Password seleccionado
    else if (_passwordFocus.hasFocus) {
      if (_obscurePassword) {
        isChecking!.change(true);
        isHandsUp!.change(false);
      } else {
        isChecking!.change(false);
        isHandsUp!.change(true);
      }
    }
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size miTamano = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              SizedBox(
                width: miTamano.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_character.riv',
                  stateMachines: ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    if (controller == null) return;
                    artboard.addController(controller!);

                    isChecking = controller!.findSMI("isChecking");
                    isHandsUp = controller!.findSMI("isHandsUp");
                    trigSuccess = controller!.findSMI("trigSuccess");
                    trigFail = controller!.findSMI("trigFail");
                  },
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 10),

              // Email
              TextField(
                focusNode: _emailFocus,
                onChanged: (value) {},
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Introduce tu email",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Password
              TextField(
                focusNode: _passwordFocus,
                obscureText: _obscurePassword,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                      _onFocusChange(); // actualizar animación
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: miTamano.width,
                child: const Text(
                  "¿Olvidaste tu contraseña?",
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),

              const SizedBox(height: 20),

              MaterialButton(
                onPressed: () {},
                color: const Color.fromARGB(255, 243, 33, 198),
                minWidth: miTamano.width,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: miTamano.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿No tienes cuenta? "),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "¡Regístrate aquí!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
