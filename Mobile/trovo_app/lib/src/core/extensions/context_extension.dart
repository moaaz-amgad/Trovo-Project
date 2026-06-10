import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  bool get isRTL {
    return Directionality.of(this) == TextDirection.rtl;
  }

  S get locale => S.of(this);
}
