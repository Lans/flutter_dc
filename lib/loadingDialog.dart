import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  const LoadingDialog(
      {Key key,
      this.width = 120,
      this.height = 120,
      this.title = "加载中...",
      this.backgroundColor,
      this.elevation,
      this.shape,
      this.titleStyle})
      : super(key: key);

  final String title;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;
  final double height;
  final double width;

  static const double _defaultElevation = 24.0;
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)));

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            color: backgroundColor ??
                dialogTheme.backgroundColor ??
                Theme.of(context).dialogBackgroundColor,
            elevation: elevation ?? dialogTheme.elevation ?? _defaultElevation,
            shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
            type: MaterialType.card,
            child: SizedBox(
              height: width,
              width: height,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        title,
                        style: titleStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
