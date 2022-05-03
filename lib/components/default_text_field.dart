import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField(
      {Key? key,
      this.title,
      this.isSecure = false,
      this.isLargeText = false,
      required this.validate,
      this.passwordFieldKey})
      : super(key: key);
  final String? title;
  final bool? isSecure;
  final bool? isLargeText;
  final String? Function(String?) validate;
  final GlobalKey<FormFieldState<String>>? passwordFieldKey;
  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.title == 'Password' ? widget.passwordFieldKey : null,
      validator: widget.passwordFieldKey != null
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Password Required';
              }
              if (value != widget.passwordFieldKey!.currentState!.value) {
                return 'Password do not match';
              }
              return null;
            }
          : widget.validate,
      maxLines: widget.isLargeText! ? 6 : 1,
      // onFieldSubmitted: (_) {
      //   FocusScope.of(context).nextFocus();
      // },
      // textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Constants.kPrimaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusColor: Constants.kPrimaryColor,
        hoverColor: Constants.kPrimaryColor,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        hintText: widget.title,
        suffixIcon: widget.isSecure!
            ? IconButton(
                icon:
                    Icon((isVisible) ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              )
            : const SizedBox(),
        iconColor: Constants.kPrimaryColor,
        suffixIconColor: Constants.kPrimaryColor,
        prefixIconColor: Constants.kPrimaryColor,
      ),
      keyboardType: widget.isSecure!
          ? TextInputType.visiblePassword
          : widget.title == 'Phone' || widget.title == 'Phone number'
              ? const TextInputType.numberWithOptions()
              : TextInputType.emailAddress,
      obscureText: widget.isSecure! ? isVisible : false,
    );
  }
}