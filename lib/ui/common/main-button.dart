import 'package:buddy_care/theme.dart';
import 'package:flutter/material.dart';


class MainButton extends RawMaterialButton {
  MainButton({
    Key key,
    Color bgColor,
    GestureTapCallback onTap,
    TextStyle textStyle,
    BorderSide border,
    double height = 52.0,
    bool isLoading = false,
    @required String text,
  }) : super(
    key: key,
    fillColor: bgColor ?? AppColors.buttonBg,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Center(
        child: !isLoading ? Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ?? TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          )
        ) : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      ),
    ),
    onPressed: !isLoading ? onTap : null,
    shape: RoundedRectangleBorder(
      side: border ?? const BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: BorderRadius.all(Radius.circular(height / 2)),
    ),
    constraints: BoxConstraints(
      minHeight: height,
      maxHeight: height,
    ),
  );
}
