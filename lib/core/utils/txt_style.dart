import 'package:flutter/material.dart';

import 'colors_manager.dart';

class TxtStyle {
  static final TextStyle primaryStyle = TextStyle(
    color: ColorsManager.primary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle scoundryStyle = TextStyle(
    color: ColorsManager.scoundry,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle font24WhiteBold = TextStyle(
    color: ColorsManager.scoundry,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle noteTxtStyle = TextStyle(
    color: ColorsManager.scoundry,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}