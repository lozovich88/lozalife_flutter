import 'package:flutter/material.dart';

import 'package:lozalife/core/theme/app_dimens.dart';

/// Standard tappable card of the app (e.g. task cards).
class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.margin = const EdgeInsets.symmetric(
      horizontal: AppDimens.size8,
      vertical: AppDimens.size4,
    ),
    this.padding = const EdgeInsets.all(AppDimens.size12),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: margin,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
