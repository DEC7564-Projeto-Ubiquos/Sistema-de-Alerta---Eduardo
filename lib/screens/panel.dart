import 'package:fluent_ui/fluent_ui.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavigationView(
      content: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
