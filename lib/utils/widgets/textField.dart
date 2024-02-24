import 'package:flutter/material.dart';

class ExtractedTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Color fillColor;
  final bool showSuffixIcon;
  final Color textColor;
  final Color hintColor;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  ExtractedTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.fillColor = Colors.white,
    this.showSuffixIcon = false,
    this.textColor = Colors.black,
    this.hintColor = Colors.black,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<ExtractedTextField> createState() => _ExtractedTextFieldState();
}

class _ExtractedTextFieldState extends State<ExtractedTextField> {
  bool updateSuffixIcon = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        child: TextFormField(
          cursorColor: Colors.black,
          obscureText: !widget.showSuffixIcon
              ? false
              : updateSuffixIcon
                  ? false
                  : true,
          controller: widget.controller,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: widget.textColor),
          onTapOutside: (event) =>
              FocusScope.of(context).requestFocus(FocusNode()),
          minLines: 1,
          maxLines: 1,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15, top: 5),
              filled: true,
              fillColor: widget.fillColor,
              enabledBorder: borderDec(),
              disabledBorder: borderDec(),
              focusedBorder: borderDec(),
              hintText: widget.hintText,
              suffixIcon: widget.showSuffixIcon
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          updateSuffixIcon = !updateSuffixIcon;
                        });
                      },
                      icon: updateSuffixIcon
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            ))
                  : const SizedBox(),
              hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: widget.hintColor),
              floatingLabelBehavior: FloatingLabelBehavior.never),
          textInputAction: widget.textInputAction,
        ));
  }

  borderDec() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white));
  }
}
