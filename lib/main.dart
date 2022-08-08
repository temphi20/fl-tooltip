import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'state_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ListenableProvider(create: (_) => StateManager())],
      builder: (_, __) => FluentApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const Home(),
      ),
    );
  }
}
