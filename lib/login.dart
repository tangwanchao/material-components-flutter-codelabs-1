// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:Shrine/supplemental/bottom_insert_state.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BottomInsertState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _scrollController = ScrollController(keepScrollOffset: true);
  final _listKey = GlobalKey();

  @override
  void bottomInsertComplete() {
    if ((_usernameFocusNode.hasFocus || _passwordFocusNode.hasFocus) &&
        MediaQuery
            .of(context)
            .viewInsets
            .bottom > 50) {
      setState(() {
        _scrollController.animateTo(
          context.size.height - _listKey.currentContext.size.height,
          duration: Duration(
            milliseconds: 300,
          ),
          curve: Curves.decelerate,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          key: _listKey,
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/diamond.png',
                  color: kShrineBackgroundWhite,
                ),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            AccentColorOverride(
              color: kShrineAltYellow,
              child: TextField(
                focusNode: _usernameFocusNode,
                decoration: InputDecoration(
                  labelText: "UserName",
                ),
                controller: _usernameController,
              ),
            ),
            SizedBox(height: 12.0),
            AccentColorOverride(
              color: kShrineAltYellow,
              child: TextField(
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                controller: _passwordController,
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  child: Text("cancel"),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                ),
                RaisedButton(
                  color: Theme
                      .of(context)
                      .buttonColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("next"),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context)
          .copyWith(accentColor: color, brightness: Brightness.dark),
    );
  }
}
