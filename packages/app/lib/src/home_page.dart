import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'charts_view.dart';
import 'run_configurations_view.dart';
import 'run_controller.dart';
import 'settings_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _viewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(builder: (context) {
        final runController = context.watch<RunController>();
        final isStopping = runController.status == RunControllerStatus.stopping;

        void toggleRunController() {
          switch (runController.status) {
            case RunControllerStatus.notRunning:
              runController.runConfigurations(onlyIfWithoutResult: true);
              break;
            case RunControllerStatus.running:
              runController.stop();
              break;
            case RunControllerStatus.stopping:
              // Ignore any button presses while stopping.
              break;
          }
        }

        return Stack(
          children: [
            FloatingActionButton(
              onPressed: isStopping ? null : toggleRunController,
              child: Icon(
                runController.isRunning ? Icons.stop : Icons.play_arrow,
                size: 40,
              ),
            ),
            if (isStopping)
              const Positioned.fill(child: CircularProgressIndicator()),
          ],
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _viewIndex,
        onTap: (viewIndex) => setState(() => _viewIndex = viewIndex),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Runs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_axis),
            label: 'Charts',
          ),
        ],
      ),
      body: IndexedStack(
        index: _viewIndex,
        children: const [
          SettingsView(),
          RunConfigurationsView(),
          ChartsView(),
        ],
      ),
    );
  }
}
