import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samplemusicapp/utilities/app_constants.dart';

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child:
                Text(AppConstants.retry, style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}
