/*
 * MIT License
 *
 * Copyright (c) 2020 Nhan Cao
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:nft/utils/app_style.dart';
import 'package:nft/widgets/ripple_effect.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;

  const RoundedButton({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleEffect(
      onTap: () {},
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(19.5)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 11),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF8C8C8C)),
            borderRadius: BorderRadius.all(Radius.circular(19.5))),
        child: Text(text, style: normalTextStyle(14, Colors.white)),
      ),
    );
  }
}
