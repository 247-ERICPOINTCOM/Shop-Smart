import 'package:flutter/material.dart';
import 'package:shopsmartly/constants/constants.dart';

class BudgetTracker extends StatefulWidget {
  const BudgetTracker({Key? key}) : super(key: key);

  @override
  _BudgetTrackerState createState() => _BudgetTrackerState();
}

class _BudgetTrackerState extends State<BudgetTracker> {
  double _budgetValue = 50; // Initial value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Set Your Budget',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("\$0", style: TextStyle(fontSize: 16)),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("\$100", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Slider(
              value: _budgetValue,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  _budgetValue = value;
                });
                print('Slider value: $_budgetValue');
              },
            ),
            SizedBox(height: 20),
            Text(
              'Budget: \$${_budgetValue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                // Add your save logic here
                print('Save button pressed. Budget value: $_budgetValue');
              },
              // bg color
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "Save",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
