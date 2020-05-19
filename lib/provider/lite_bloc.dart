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

import 'package:rxdart/rxdart.dart';

class LiteBloc<I, O> {
  /// @nhancv 2019-10-04: Input data driven
  final BehaviorSubject<I> _inputSubject = BehaviorSubject<I>();

  /// @nhancv 2019-10-04: Output data driven
  final BehaviorSubject<O> _outputSubject = BehaviorSubject<O>();

  /// @nhancv 2019-10-04: Dynamic logic
  /// Transfer data from input to mapper to output
  set logic(Observable<O> Function(Observable<I> input) mapper) {
    mapper(_inputSubject).listen(_outputSubject.sink.add);
  }

  /// @nhancv 2019-10-04: Push input data to BLoC
  void push(I input) => _inputSubject.sink.add(input);

  /// @nhancv 10/8/2019: Get input stream
  Stream<I> get input => _inputSubject;

  /// @nhancv 2019-10-04: Stream output from BLoC
  Stream<O> get stream => _outputSubject;

  /// @nhancv 2019-10-04: Dispose BLoC
  void dispose() {
    _inputSubject.close();
    _outputSubject.close();
  }

  /// @nhancv 2019-10-04: Build a BLoC instance with logic function as a parameter
  static LiteBloc build<I, O>(Observable<O> Function(Observable<I> input) mapper) {
    var blocUnit = LiteBloc<I, O>();
    blocUnit.logic = mapper;
    return blocUnit;
  }
}

/// Default Bloc
class LiteBlocDefault<I> extends LiteBloc<I, I> {
  LiteLiteBlocDefault() {
    this.logic = (Observable<I> data) => data;
  }
}
