import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../size_config.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.name,
    required this.onPress,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String name;
  final VoidCallback onPress;
  final String icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(60),
            width: getProportionateScreenHeight(60),
            child: TextButton(
              onPressed: onPress,
              child: Center(
                child: Icon(
                  MdiIcons.fromString(icon),
                  size: getProportionateScreenHeight(35),
                  color: color,
                ),
              ),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: color.withOpacity(.3),
              ),
            ),
          ),
          Expanded(child: Text(name)),
        ],
      ),
    );
  }
}
