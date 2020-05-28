import 'package:flutter/material.dart';

class ExtraItemContainer extends StatefulWidget {
  final List<ExtraItem> items;

  const ExtraItemContainer({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  _ExtraItemContainerState createState() => _ExtraItemContainerState();
}

class _ExtraItemContainerState extends State<ExtraItemContainer> {
  @override
  Widget build(BuildContext context) {
    final pages = createPages();
    return PageView(
      children: pages,
    );
  }

  List<Widget> createPages() {
    final items = widget.items;
    final hasLastPage = items.length % 4 == 0 ? 0 : 1;
    final totalPageCount = items.length ~/ 4 + hasLastPage;
    List<Widget> pages = [];
    for (var i = 0; i < totalPageCount; i++) {
      final page = getPage(i);
      pages.add(page);
    }
    return pages;
  }

  Widget getPage(int page) {
    List<ExtraItem> extras = [];
    for (var i = 0; i < widget.items.length; i++) {
      if (i < page * 4) continue;
      if (i > (page + 1) * 4 - 1) continue;
      extras.add(widget.items[i]);
    }

    List<ExtraItem> itemList1 = [];

    for (var i = 0; i < extras.length; i++) {
      if (i < 4) {
        itemList1.add(extras[i]);
      }
    }

    if (itemList1.length < 4) {
      final length = itemList1.length;
      for (var i = 0; i < 4 - length; i++) {
        itemList1.add(EmptyExtraItem());
      }
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children:
              itemList1.map((e) => Expanded(child: e.buildItem(),)).toList()
          ),
        ),
      ],
    );
  }
}

abstract class ExtraItem {
  ExtraItem();

  factory ExtraItem.def({Widget icon, String text, Function onPressed}) {
    return DefaultExtraItem(
      icon: icon,
      text: text,
      onPressed: onPressed,
    );
  }

  Widget buildItem();
}

class DefaultExtraItem extends ExtraItem {
  final Widget icon;
  final String text;
  final Function onPressed;

  DefaultExtraItem({
    this.icon,
    this.text,
    this.onPressed,
  });

  Widget buildItem() {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(
              height: 10,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class EmptyExtraItem extends ExtraItem {
  EmptyExtraItem();

  @override
  Widget buildItem() => Container();
}

