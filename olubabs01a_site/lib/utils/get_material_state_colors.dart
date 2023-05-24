import 'package:flutter/material.dart';

Color getForegroundColor(Set<MaterialState> states, ThemeData theme, bool isSuccess) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused
  };

  if (isSuccess) {
    return theme.colorScheme.onTertiary;
  }

  return states.any(interactiveStates.contains)
      ? theme.colorScheme.primary
      : theme.colorScheme.onTertiary;
}

Color getBackgroundColor(Set<MaterialState> states, ThemeData theme, bool isSuccess) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused
  };

  if (isSuccess) {
    return Colors.green;
  }

  return states.any(interactiveStates.contains)
      ? theme.colorScheme.inversePrimary
      : theme.colorScheme.primary;
}