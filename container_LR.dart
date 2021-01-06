import 'package:flutter/cupertino.dart';

enum TExpandLRMode { left, mid, right, avg }

class ContainerLR extends StatelessWidget {
  double width;
  double height;
  final Decoration decoration;
  final WidgetBuilder itemLeft;
  final WidgetBuilder itemMid;
  final WidgetBuilder itemRight;
  final Color color;
  bool itemVertical;
  TExpandLRMode itemExpandedMode;

  ContainerLR({Key key, this.width, this.height, this.decoration, this.itemLeft, this.itemMid, this.itemRight, this.color, this.itemVertical = false, this.itemExpandedMode = TExpandLRMode.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: this.width,
      height: this.height,
      color: this.color,
      decoration: this.decoration,
      child: itemVertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[_buildItemLeft(context), _buildItemMid(context), _buildItemRight(context)],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[_buildItemLeft(context), _buildItemMid(context), _buildItemRight(context)],
            ),
    );
  }

  _buildItemLeft(BuildContext context) {
    var lLeft = (itemLeft == null ? Container() : itemLeft(context));
    if (itemExpandedMode == TExpandLRMode.left) {
      return Expanded(
        child: lLeft,
      );
    } else if (itemExpandedMode == TExpandLRMode.avg) {
      return Flexible(
        child: lLeft,
      );
    } else {
      return lLeft;
    }
  }

  _buildItemMid(BuildContext context) {
    var lMid = (itemMid == null ? Container() : itemMid(context));
    if (itemExpandedMode == TExpandLRMode.mid) {
      return Expanded(
        child: lMid,
      );
    } else if (itemExpandedMode == TExpandLRMode.avg) {
      return Flexible(
        child: lMid,
      );
    } else {
      return lMid;
    }
  }

  _buildItemRight(BuildContext context) {
    var lRight = (itemRight == null ? Container() : itemRight(context));
    if (itemExpandedMode == TExpandLRMode.right) {
      return Expanded(
        child: lRight,
      );
    } else if (itemExpandedMode == TExpandLRMode.avg) {
      return Flexible(
        child: lRight,
      );
    } else {
      return lRight;
    }
  }
}
