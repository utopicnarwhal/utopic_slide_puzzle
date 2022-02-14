import 'package:flutter/material.dart';

/// iOS scroll physics but also always scrollable to make it look more interactive
const kUtopicScrollPhysics = BouncingScrollPhysics(
  parent: AlwaysScrollableScrollPhysics(),
);
