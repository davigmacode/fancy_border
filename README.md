[![Pub Version](https://img.shields.io/pub/v/fancy_border)](https://pub.dev/packages/fancy_border) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_fancy_border) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

This package provides a custom Flutter border class named `FancyBorder` that allows you to draw borders with more style options beyond the built-in Flutter borders. It supports features like:

* **Gradients**: Apply a gradient to the border for a more decorative look.
* **Patterns**: Create dashed or dotted borders using a defined pattern.

### Preview
[![Preview](https://github.com/davigmacode/flutter_fancy_border/raw/main/media/preview.jpg)](https://davigmacode.github.io/flutter_fancy_border)

[Demo](https://davigmacode.github.io/flutter_fancy_border)

## Usage
```dart
Container(
  width: 100,
  height: 50,
  decoration: const ShapeDecoration(
    color: Colors.yellow,
    shape: FancyBorder(
      /// The underlying border shape.
      shape: RoundedRectangleBorder(),
      /// The style of the border.
      style: FancyBorderStyle.dashed,
      /// The width of the border.
      width: 4,
      /// The offset of the border stroke.
      offset: 2,
      /// The color replaced by gradient.
      color: Colors.red,
      /// The gradient to use for the border.
      gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
      /// The corner radius of the border.
      corners: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  alignment: Alignment.center,
  child: const Text('Rounded'),
)
```

### Border Style
The `FancyBorderStyle` class defines the different styles available for the border:

* `FancyBorderStyle.solid` (default): Solid border style.
* `FancyBorderStyle.dotted`: Dotted border style.
* `FancyBorderStyle.dashed`: Dashed border style.
* `FancyBorderStyle.morse`: Morse code-like border style.
* (You can add more styles to the enum if needed)

To delve deeper into the technical details of `fancy_border`'s classes, methods, and properties, please refer to the official [API Reference](https://pub.dev/documentation/fancy_border/latest/).

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.