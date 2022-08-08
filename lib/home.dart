import 'package:fluent_ui/fluent_ui.dart';

import 'test_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: NavigationBody(
        index: 0,
        children: [TestPage()],
      ),
    );
  }
}
