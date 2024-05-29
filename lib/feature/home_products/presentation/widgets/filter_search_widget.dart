import 'package:flutter/material.dart';

class FilterSearchWidget extends StatelessWidget {
  const FilterSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: 49,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Color(0xFF292526),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: const Icon(
        Icons.filter_list_rounded,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

