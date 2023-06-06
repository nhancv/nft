import 'package:flutter/material.dart';

class WInputForm extends StatefulWidget {
  const WInputForm({
    Key? key,
    this.controller,
    this.labelText,
    this.errorText,
    this.suffixIcon,
    this.obscureText = false,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  const WInputForm.email({
    Key? key,
    this.controller,
    this.labelText = 'Email',
    this.errorText,
    this.suffixIcon,
    this.obscureText = false,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.emailAddress,
  }) : super(key: key);

  const WInputForm.password({
    Key? key,
    this.controller,
    this.labelText = 'Password',
    this.errorText,
    this.suffixIcon,
    this.obscureText = true,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.visiblePassword,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  @override
  _WInputFormState createState() => _WInputFormState();
}

class _WInputFormState extends State<WInputForm> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        border: const OutlineInputBorder(),
        suffixIcon: widget.suffixIcon,
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
    );
  }
}
