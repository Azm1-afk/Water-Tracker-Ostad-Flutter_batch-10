import 'package:flutter/material.dart';
import 'package:water_tracker/add_water_btn.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  int currentIntake = 0;
  double currentIntakePercent =
      0; // THIS IS THE PERCENTAGE (currentIntake/_goal)

  final int _goal = 2000; // THIS VALUE WILL NOT CHANGE

  double progressBarValue() {
    //calculates the progress bar 'value' property
    setState(() {
      currentIntakePercent = double.parse(
        (currentIntake / _goal).toStringAsFixed(1),
      );
    });
    return currentIntakePercent;
  }

  void _addWater(int amount) {
    setState(() {
      currentIntake = (currentIntake + amount).clamp(0, _goal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],

      appBar: AppBar(
        title: Text('Water Tracker App by Azm1 (Ostad Flutter Batch 10)'),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10,
                  right: 15,
                  left: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      "Today's Intake",
                      style: TextStyle(color: Colors.pink, fontSize: 22),
                    ),
                    Text(
                      "$currentIntake ml",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    // Circular Progress Bar.
                    value: progressBarValue(),
                    color: Colors.blue,
                    backgroundColor: Colors.white,
                    strokeWidth: 8,
                    // strokeAlign: 8,
                  ),
                ),

                Text(
                  '${(currentIntakePercent * 100).toStringAsFixed(0)}%',
                  style: TextStyle(fontSize: 20),
                ), // This is the text what
              ],
            ),

            const SizedBox(height: 30),
            AddWaterBtn(amount: 200, onPressed: () => _addWater(200)),
            const SizedBox(height: 30),
            AddWaterBtn(amount: 500, onPressed: () => _addWater(500)),
            const SizedBox(height: 30),
            AddWaterBtn(amount: 1000, onPressed: () => _addWater(1000)),

            const SizedBox(height: 40),

            SizedBox(
              width: 380,
              child: ElevatedButton(
                onPressed: () async { // IMPORTANT: Marked as async
                  // Show the dialog and wait for it to be dismissed, returning a boolean
                  final bool? shouldReset = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // IMPORTANT: Pop with false for "Cancel"
                          },
                          child: const Text('Cancel'), // Changed to 'Cancel' for clarity
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true); // IMPORTANT: Pop with true for "Reset"
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                      title: const Text('Resetting Intake'),
                      contentPadding: const EdgeInsets.all(20), // Added const
                      content: const Text('This action cannot be undone!'),
                    ),
                  );

                  // IMPORTANT: Only perform setState if the dialog returned true
                  if (shouldReset == true) {
                    setState(() {
                      currentIntake = 0;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text( // Added const
                  'Reset',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
