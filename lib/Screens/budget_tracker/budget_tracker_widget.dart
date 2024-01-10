import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/provider/app_provider.dart';

class BudgetTrackerTest extends StatefulWidget {
  const BudgetTrackerTest({Key? key}) : super(key: key);

  @override
  _BudgetTrackerTestState createState() => _BudgetTrackerTestState();
}

class _BudgetTrackerTestState extends State<BudgetTrackerTest> {
  late double _budgetValue; // Initialize with user's budget

  @override
  void initState() {
    super.initState();
    // Fetch user budget from Firebase and set it to _budgetValue
    _budgetValue = Provider.of<AppProvider>(context, listen: false)
            .getUserInformation
            .userBudget ??
        50.0; // Set a default value if user budget is not available
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Set Your Budget',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("\$0", style: TextStyle(fontSize: 16)),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Text("\$100", style: TextStyle(fontSize: 16)),
              ),
              SizedBox(
                width: 20,
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
            minWidth: 200,
            height: 60,
            onPressed: () {
              // Add your save logic here
            },
            // bg color
            color: kPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Text(
              "Save",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
