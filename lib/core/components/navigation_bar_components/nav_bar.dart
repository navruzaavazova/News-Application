import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double width;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : Colors.grey;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: width*0.08,),
          SizedBox(height: width*0.01),
          Text(
            label,
            style: TextStyle(color: color, fontSize: width*0.03),
          ),
        ],
      ),
    );
  }
}
