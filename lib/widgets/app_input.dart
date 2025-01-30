import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool encrypt;

  const AppInput({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.encrypt = false,
  }) : super(key: key);

  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xFF121212),
            fontStyle: FontStyle.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.encrypt ? _obscureText : false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              suffixIcon: widget.encrypt
                  ? IconButton(
                    
                      icon: Icon(
                         
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
             contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }
}
