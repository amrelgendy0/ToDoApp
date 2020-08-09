import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class AutoDirectionTextField extends StatefulWidget {
  AutoDirectionTextField(@required this._labeltext, @required this._controller);
  Color _color = RandomColor().randomColor(
      colorBrightness: const ColorBrightness.custom(const Range(
          ((ColorBrightness.maxBrightness + ColorBrightness.minBrightness) ~/
              1.2),
          ColorBrightness.maxBrightness)));
  final String _labeltext;
  TextEditingController _controller = TextEditingController();

  @override
  _AutoDirectionTextFieldState createState() => _AutoDirectionTextFieldState();
}
class _AutoDirectionTextFieldState extends State<AutoDirectionTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget._color,
      child: AutoDirection(
        text: widget._controller.text,
        child: TextFormField(
          maxLines: widget._labeltext == "Title" ? 1 : 9,
          textInputAction: TextInputAction.newline,
          validator: (vv) {
            if (vv.isEmpty || vv.trim() == '') {
              return 'You should enter a ${widget._labeltext}';
            }
          },
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(hintText: 'Enter ${widget._labeltext}'),
          controller: widget._controller,
        ),
      ),
    );
  }
}
