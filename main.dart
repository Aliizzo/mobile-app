import 'package:flutter/material.dart';

void main() {
  runApp(PayrollApp());
}

class PayrollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PayrollCalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PayrollCalculatorPage extends StatefulWidget {
  @override
  _PayrollCalculatorPageState createState() => _PayrollCalculatorPageState();
}

class _PayrollCalculatorPageState extends State<PayrollCalculatorPage> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController overtimeHoursController = TextEditingController();

  double taxRate = 0.07; // 7% tax example
  double overtimeRate = 1.5; // 1.5x overtime pay rate
  double hourlyRate = 5; // Base hourly wage for OT calculation

  double grossSalary = 0;
  double taxAmount = 0;
  double netSalary = 0;
  double overtimePay = 0;

  void calculatePayroll() {
    double salary = double.tryParse(salaryController.text) ?? 0;
    double overtimeHours = double.tryParse(overtimeHoursController.text) ?? 0;

    overtimePay = overtimeHours * hourlyRate * overtimeRate;
    grossSalary = salary + overtimePay;
    taxAmount = grossSalary * taxRate;
    netSalary = grossSalary - taxAmount;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payroll & Tax Calculator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: salaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Base Monthly Salary",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: overtimeHoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Overtime Hours",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculatePayroll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  "CALCULATE",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              buildResultCard("Overtime Pay", overtimePay),
              buildResultCard("Gross Salary", grossSalary),
              buildResultCard("Tax Amount", taxAmount),
              buildResultCard("Net Salary", netSalary),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(String title, double value) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$title: \$${value.toStringAsFixed(2)}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}