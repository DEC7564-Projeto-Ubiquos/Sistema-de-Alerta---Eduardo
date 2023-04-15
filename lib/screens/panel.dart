import 'package:emg_app/widgets/graph.dart';
import 'package:emg_app/widgets/history.dart';
import 'package:emg_app/widgets/patient.dart';
import 'package:emg_app/widgets/samples.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: Stack(
        children: <Widget>[
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Patient(),
                    Spacer(),
                    Graph(),
                    Spacer(),
                    Samples(),
                  ],
                ),
                const History(),
              ],
            ),
          ),
          Positioned(
            bottom: 18,
            right: 18,
            child: Image.asset(
              'assets/images/emg_logo.png',
              height: 32,
            ),
          ),
        ],
      ),
    );
  }
}
