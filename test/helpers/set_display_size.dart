import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

extension PuzzleWidgetTester on WidgetTester {
  void setDisplaySize(Size size) {
    binding.window.physicalSizeTestValue = size;
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });
  }

  void setTinyDisplaySize() {
    setDisplaySize(const Size(320, 1000));
  }

  void setExtraSmallDisplaySize() {
    setDisplaySize(const Size(480, 1000));
  }

  void setSmallDisplaySize() {
    setDisplaySize(const Size(620, 1000));
  }

  void setMediumDisplaySize() {
    setDisplaySize(const Size(1124, 1000));
  }

  void setLargeDisplaySize() {
    setDisplaySize(const Size(1540, 1000));
  }

  void setExtraLargeDisplaySize() {
    setDisplaySize(const Size(2560, 1000));
  }
}
