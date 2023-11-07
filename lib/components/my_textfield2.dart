import 'package:flutter/material.dart';

class MyTextField2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon iconos2;
  final String? Function(String?)? validador; // Parámetro de validación

  const MyTextField2({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.iconos2,
    this.validador,
  }) : super(key: key);

  @override
  MyTextField2State createState() => MyTextField2State();
}

class MyTextField2State extends State<MyTextField2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        validator: widget.validador,
        decoration: InputDecoration(
          prefixIcon: widget.iconos2,
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
          errorStyle: TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                  offset: const Offset(2.0, 2.0), //position of shadow
                  blurRadius: 1.0, //blur intensity of shadow
                  color: Colors.black.withOpacity(0.99))
            ],
            decoration: TextDecoration.underline,
            decorationColor: Colors.red,
            decorationStyle: TextDecorationStyle.solid,
          ),
          // Muestra el mensaje de error
        ),
      ),
    );
  }
}
