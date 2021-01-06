import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ContainerBarBuilder<T> = Widget Function(T value);
typedef ContainerBaronTap<T> = Function(T value);
typedef ContainerBarData<T> = Function(Function(List<T> qItemList) qOnSuccess);

class ContainerBars<T> extends StatefulWidget {
  double width;
  double height;
  final Decoration decoration;
  final Color color;
  bool itemVertical; //默认是水平布局，启用垂直布局
  bool itemRight; //默认从左到右,从上到下,启用从右到左,从下到上
  List<T> itemList;
  final ContainerBarBuilder<T> itemChild;
  final ContainerBaronTap<T> onTap;
  final ContainerBarData<T> onSetData;

  Function onDataCallBack(List<T> qItemList) {}

  ContainerBars({Key key, this.width, this.height, this.decoration, this.color, this.itemVertical = false, this.itemRight = false, this.itemList, this.itemChild, this.onTap, this.onSetData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContainerBarsState<T>();
  }
}

class _ContainerBarsState<T> extends State<ContainerBars<T>> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.onSetData != null && widget.itemList == null) {
      new Future(() {
        widget.onSetData((List<T> qItemList) {
          widget.itemList = qItemList;
          if (widget.itemList == null) {
            widget.itemList = new List<T>();
          }
          setState(() {});
        });
      });
      return Container(width: widget.width, height: widget.height, color: widget.color, decoration: widget.decoration);
    }
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.color,
      decoration: widget.decoration,
      child: widget.itemVertical
          ? ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildItems(),
                )
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildItems(),
            ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> lListA = new List<Widget>();
    List<Widget> lListB = new List<Widget>();
    if (widget.itemList != null) {
      widget.itemList.forEach((item) {
        //回调
        var lItem = (widget.itemChild == null ? Container() : widget.itemChild(item));
        var lWell = InkWell(
          //套个手势
          //behavior: HitTestBehavior.opaque,
          child: lItem,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap(item);
            }
          },
        );
        lListB.add(lWell);
      });
    }
    if (widget.itemRight && lListB.length > 0) {
      //反转,从右到左或从下到上
      lListB = lListB.reversed.toList();
      lListB.insert(
          0,
          Flexible(
            child: Container(),
          ));
    }
    ScrollController lScrollController;
    Flexible lListView = new Flexible(
      child: ListView(
        scrollDirection: widget.itemVertical ? Axis.vertical : Axis.horizontal,
        controller: lScrollController = ScrollController(),
        children: lListB,
      ),
    );
    lListA.add(Container(
        width: 30,
        height: 30,
        child: IconButton(
          icon: Icon(
            Icons.pause,
            color: Colors.green,
          ),
          onPressed: () {
            lScrollController.jumpTo(0);
          },
        )));
    lListA.add(lListView);
    if (widget.itemRight && lListB.length > 0) {
      //反转,从右到左或从下到上
      lListA = lListA.reversed.toList();
    }
    return lListA;
  }
}
