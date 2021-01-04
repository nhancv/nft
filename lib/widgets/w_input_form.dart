import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateful.dart';

class WInputForm extends StatefulWidget {
  const WInputForm({
    Key key,
    @required this.labelText,
    this.errorText,
    this.suffixIcon,
    @required this.obscureText,
    @required this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  const WInputForm.email({
    Key key,
    @required this.labelText,
    this.errorText,
    this.suffixIcon,
    this.obscureText = false,
    @required this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  const WInputForm.password({
    Key key,
    @required this.labelText,
    this.errorText,
    this.suffixIcon,
    this.obscureText = true,
    @required this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  final String labelText;
  final String errorText;
  final Widget suffixIcon;
  final bool obscureText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  @override
  _WInputFormState createState() => _WInputFormState();
}

class _WInputFormState extends BaseStateful<WInputForm> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TextField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        border: const OutlineInputBorder(),
        suffixIcon: widget.suffixIcon,
      ),
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
    );
  }
}
