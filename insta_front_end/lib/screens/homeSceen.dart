import 'package:flutter/material.dart';

import '../models/headBar.dart';
import '../models/mainBody.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeadBar(),
        Divider(),
        mainBody()
      ],
    );
  }
}
