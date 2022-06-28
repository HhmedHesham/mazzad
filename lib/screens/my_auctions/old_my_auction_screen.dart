import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './custom_image_form_field.dart';
import '../../utils/validator.dart';

class OldMyAuctionsScreen extends StatelessWidget {
  OldMyAuctionsScreen({Key? key}) : super(key: key);
  static const String routeName = '/old_my_auctions_screen';
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Auctions'),
      ),
      body: Form(
          //autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextWidget(
                hintText: "full Name",
                keyboardType: TextInputType.text,
                keyboardAction: TextInputAction.done,
                inputController: _emailTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.isValidEmail) {
                    return "Full Name field is required";
                  }
                  if (kDebugMode) {
                    print(value.isValidEmail);
                  }
                  return null;
                },
              ),
              InputTextWidget(
                hintText: "full Name",
                keyboardType: TextInputType.text,
                keyboardAction: TextInputAction.done,
                // inputController: _emailTextEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.isValidName) {
                    return "Full Name field is required";
                  }
                  if (kDebugMode) {
                    print(value.isValidEmail);
                  }
                  return null;
                },
              ),
              CustomImageFormField(
                validator: (val) {
                  if (val == null) return 'Pick a picture';
                  return null;
                },
                onChanged: (_file) {},
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (kDebugMode) {
                        print('all valid');
                      }
                    } else {
                      if (kDebugMode) {
                        print('its not valid');
                      }
                    }
                  },
                  child: const Text('press here')),
            ],
          )),
    );
  }
}

class InputTextWidget extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? keyboardAction;
  final TextEditingController? inputController;
  final double? height;
  final FormFieldValidator<String>? validator;

  const InputTextWidget(
      {Key? key,
      @required this.hintText,
      @required this.keyboardType,
      @required this.keyboardAction,
      @required this.inputController,
      this.validator,
      this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: validator,
        builder: (FormFieldState formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  onChanged: (String value) {
                    formFieldState.didChange(value);
                  },
                  controller: inputController,
                  style: const TextStyle(fontSize: 14),
                  keyboardType: keyboardType,
                  textInputAction: keyboardAction,
                  decoration:
                      InputDecoration.collapsed(hintText: hintText).copyWith(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              // Show Form Field Error
              _showError(formFieldState),
            ],
          );
        });
  }

  Widget _showError(FormFieldState formFieldState) {
    if (formFieldState.hasError) {
      return Row(
        children: [
          const Icon(Icons.warning),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5),
            child: Text(
              formFieldState.errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
