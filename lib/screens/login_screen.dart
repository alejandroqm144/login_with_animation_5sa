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

  @override
  Widget build(BuildContext context) {
    //Para obtener el tamaño de la pantalla del disp.
    final Size miTamano = MediaQuery.of(context).size;
    return Scaffold(

        // Evita nudge o cámaras frontales para móviles
        body: SafeArea(
      child: Padding(
        
        // Eje x/horizontal/derecha izquierda
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            SizedBox(
              width: miTamano.width,
              height: 200,
              child: RiveAnimation.asset(
                'assets/animated_login_character.riv',
                fit: BoxFit.contain,
              ),
            ),

            // Espacio entre el oso y el texto email
            const SizedBox(height: 10),

            // Campo de texto en el email
            TextField(

              // Para que aparezca @ en móviles
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.mail),
                border: OutlineInputBorder(

                  // Esquinas redondeadas
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            // Espacio entre el texto email y la contraseña
            const SizedBox(height: 10),

            // Campo de texto del contraseña
            TextField(
              obscureText: _obscurePassword,

              // Para ocultar la contraseña
              decoration: InputDecoration(
                hintText: "Contraseña",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                // Ícono para mostrar/ocultar contraseña
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
