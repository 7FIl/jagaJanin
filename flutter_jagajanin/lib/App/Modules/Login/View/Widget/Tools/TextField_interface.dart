import 'package:flutter/material.dart';

// 1. Sekarang kita menggunakan StatefulWidget agar layarnya bisa di-refresh (setState)
class CustomTextField extends StatefulWidget {
  final String judulAtas;
  final String? labelInput;
  final String? hintInput;
  final String? textBelakang;
  final IconData ikonKiri;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.judulAtas,
    required this.labelInput,
    required this.hintInput,
    required this.textBelakang,
    required this.ikonKiri,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _sembunyikanTeks;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _sembunyikanTeks = widget.isPassword;
    
    // Gunakan controller dari widget jika ada, atau buat baru jika tidak
    if (widget.controller != null) {
      _controller = widget.controller!;
      print('>>> CustomTextField: Menggunakan controller dari parent');
    } else {
      _controller = TextEditingController();
      print('>>> CustomTextField: Membuat controller baru');
    }
    
    // Debug: monitor perubahan text
    _controller.addListener(() {
      print('>>> CustomTextField "${widget.judulAtas}": "${_controller.text}"');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.judulAtas, 
            style: const TextStyle(fontSize: 15),
          ),
        ),
        
        const SizedBox(height: 5),
        
        TextField(
          controller: _controller,
          obscureText: _sembunyikanTeks, 
          decoration: InputDecoration(
            prefixIcon: Icon(widget.ikonKiri, color: const Color(0xFFF48FB1)),

            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _sembunyikanTeks ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _sembunyikanTeks = !_sembunyikanTeks;
                      });
                    },
                  )
                : widget.textBelakang != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 15),
                        child: Text(
                          widget.textBelakang!,
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    : null,
            
            
            labelText: widget.labelInput,
            hintText: widget.hintInput,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: OutlineInputBorder(),
            labelStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFF48FB1)),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFF48FB1), width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Jangan dispose controller jika dia dari widget (parent yang manage)
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}