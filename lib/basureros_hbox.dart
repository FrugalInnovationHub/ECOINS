import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import 'palette.dart';

enum BHBox_Type {
  Green,
  Blue,
  Yellow,
  Grey
}

class Basureros_HBox extends RectangleComponent {
  var type;
  Basureros_HBox(type, {
    super.position,
    super.size,
    super.angle,
    super.anchor,
    super.priority,
  }) : type = type;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    this.paint = Palette.transp.paint();
    var h_box = RectangleHitbox(isSolid: true);
    add(h_box);
  }
}