import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

final iconColor = Colors.grey.withAlpha(200);
final accentColor = Color(0xFFF08F8F);
final lightAccentColor = Color(0xFFFFAFAF);
final darkAccentColor = Color(0xFFD06F6F);

class ColorsWidget extends StatefulWidget {
  final ImageProvider image;
  final int activeIndex;

  const ColorsWidget({
    Key key,
    @required this.image,
    @required this.activeIndex,
  }) : super(key: key);

  @override
  _ColorsWidgetState createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  PaletteGenerator _paletteGenerator;
  List<Color> _colors;
  Map<int, List<Color>> extractedColors;

  @override
  void initState() {
    super.initState();
    print('INIT STATE COLOR WIDGET');
    _colors = [];
    extractedColors = {};
    int i = 0;
    _updatePaletteGenerator(i);
  }

  @override
  void didUpdateWidget(ColorsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) {
      print('not same');
      if (extractedColors.containsKey(widget.activeIndex)) {
        print('Already have the colors ${widget.activeIndex}');
        _colors = extractedColors[widget.activeIndex];
        setState(() {});
      } else {
        print('Don\'t have the colors ${widget.activeIndex}');
        _paletteGenerator = null;
        _updatePaletteGenerator(0);
      }
    }
  }

  Future<void> _updatePaletteGenerator(int count) async {
    if (count > 4) {
      print('count execeeded 4');
      return;
    }
    print('getting the palette');
    _paletteGenerator = await PaletteGenerator.fromImageProvider(
      widget.image,
      maximumColorCount: 20,
    );
    print('got the palette');
    setState(() {
      if (_paletteGenerator.colors.length == 0) {
        print('iffing the palette');
        _paletteGenerator = null;
        _updatePaletteGenerator(count + 1);
      } else {
        print('elsing the palette');
        print(_paletteGenerator.dominantColor);
        print(_paletteGenerator.darkMutedColor);
        print(_paletteGenerator.lightMutedColor);
        print(_paletteGenerator.mutedColor);
        print(_paletteGenerator.darkVibrantColor);
        print(_paletteGenerator.lightVibrantColor);
        print(_paletteGenerator.vibrantColor);
        extractedColors[widget.activeIndex] = _paletteGenerator.colors.toList();
        _colors = _paletteGenerator.colors.toList();
      }
    });
    print('done setting the state');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _colors.length != 0
          ? Row(
              children: _colors.map((f) {
                return Container(
                  color: f,
                  width: MediaQuery.of(context).size.width /
                      (_colors.length),
                  height: 100,
                );
              }).toList(),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
