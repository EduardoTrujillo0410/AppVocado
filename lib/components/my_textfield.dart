import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: (text) {
          if (widget.hintText.toLowerCase() == "email") {
            // Validación para el correo electrónico en minúsculas
            if (text != text.toLowerCase()) {
              // Convierte el texto a minúsculas si no lo está
              widget.controller.text = text.toLowerCase();
            }
          } else if (widget.hintText.toLowerCase() == "contraseña") {
            // Validación para la contraseña (debe contener al menos una mayúscula, una minúscula, un número y un carácter especial)
            bool hasUppercase = text.contains(RegExp(r'[A-Z]'));
            bool hasLowercase = text.contains(RegExp(r'[a-z]'));
            bool hasDigit = text.contains(RegExp(r'[0-9]'));
            bool hasSpecialChar = text.contains(RegExp(r'[!@#$%^&*()]'));

            if (!(hasUppercase && hasLowercase && hasDigit && hasSpecialChar)) {
              // Actualiza el errorText para mostrar el mensaje de error
              setState(() {
                errorText =
                    'Debe tener al menos mayúscula, minúscula, \n número y un carácter especial';
              });
            } else {
              setState(() {
                errorText = '';
              });
            }
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 138, 138, 138)),
          ),
          fillColor: const Color.fromARGB(236, 255, 255, 255),
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          // Muestra el mensaje de error
          errorText: errorText,
        ),
      ),
    );
  }
}
