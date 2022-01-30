import 'package:flutter/material.dart';

/// iOS scroll physics but also always scrollable to make it looks more interactive
const kUtopicScrollPhysics = BouncingScrollPhysics(
  parent: AlwaysScrollableScrollPhysics(),
);
