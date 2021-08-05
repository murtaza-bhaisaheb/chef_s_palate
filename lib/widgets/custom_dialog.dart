import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.primaryButtonRoute,
    this.secondaryButtonText,
    this.secondaryButtonRoute,
  }) : super(key: key);

  final String title, description, primaryButtonText, primaryButtonRoute;

  final String? secondaryButtonText, secondaryButtonRoute;
  final blueGreen = const Color(0xFF1693A5);
  final grayColor = const Color(0xFF939393);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blueGreen,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: grayColor,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(primaryButtonRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: blueGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    primaryButtonText,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                showSecondaryButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showSecondaryButton(BuildContext context) {
    if(secondaryButtonRoute != null && secondaryButtonText !=null){
      return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(
            secondaryButtonRoute!,
          );
        },
        child: Text(
          secondaryButtonText!,
          style: TextStyle(
            fontSize: 15.0,
            color: blueGreen,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else {
      return SizedBox(height: 10.0,);
    }

  }
}
