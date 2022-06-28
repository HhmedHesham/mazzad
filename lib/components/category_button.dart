import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/size_config.dart';

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
      padding: const EdgeInsets.all(7),
      child: SingleChildScrollView(
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
            SizedBox(
              width: getProportionateScreenHeight(60),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
