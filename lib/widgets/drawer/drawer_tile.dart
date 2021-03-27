import 'package:flutter/material.dart';
import 'package:mymgs/helpers/class_serializers.dart';

class RouteData {
  final String name;
  final IconData icon;
  final IconData selectedIcon;
  final Widget widget;
  const RouteData(this.name, this.icon, this.selectedIcon, this.widget);

  bool operator ==(routeData) {
    if (routeData is RouteData) {
      return routeData.name == name;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return stringToInt(name);
  }
}

class DrawerTile extends StatelessWidget {
  final RouteData data;
  final bool selected;
  final int index;
  final void Function(int index) onSelect;
  const DrawerTile({
    required this.data,
    required this.selected,
    required this.onSelect,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final menuItemRadius = BorderRadius.only(
      topRight: Radius.circular(30),
      bottomRight: Radius.circular(30),
    );

    final selectedColor = Color(0xffd0dbf2);

    final textColor = MediaQuery.of(context).platformBrightness == Brightness.light ?
        selected ? HSLColor.fromColor(selectedColor).withLightness(0.4).toColor() : Colors.black :
        selected ? Colors.black : Colors.white;

    final iconColor = selected ? textColor : HSLColor.fromColor(textColor).withAlpha(0.5).toColor();

    return Padding(
      padding: EdgeInsets.only(
        right: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: menuItemRadius,
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: menuItemRadius,
          ),
          selected: selected,
          selectedTileColor: selectedColor,
          onTap: () => onSelect(index),
          title: Text(
            data.name,
            style: Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: textColor
            ),
          ),
          leading: Icon(
            selected ?
            data.selectedIcon :
            data.icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}