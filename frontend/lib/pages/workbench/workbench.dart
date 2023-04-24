import 'package:flutter/material.dart';

import 'images.dart';
import 'edit_area.dart';

class WorkbenchPage extends StatelessWidget {
  const WorkbenchPage({super.key});

  static const double _historyWidth = 240;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          SizedBox(
            width: _historyWidth,
            child: Images(),
          ),
          Expanded(
            child: EditArea(),
          ),
        ],
      ),
    );
  }
}
