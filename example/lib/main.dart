import 'dart:math';
import 'dart:math' as math;

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

// Extension to mimic your app's calculateDecimalPrecision
extension DecimalPrecisionExtension on num {
  int calculateDecimalPrecision() {
    const defaultDecimalPrecision = 2;
    const targetSignificantDigits = 4;
    const maxDecimalPrecision = 9;

    if (this == 0) return 0; // This is the problematic case

    final absValue = abs();

    return min(
      max(
        targetSignificantDigits - (log(absValue) / log(10)).floor(),
        defaultDecimalPrecision,
      ),
      maxDecimalPrecision,
    );
  }
}

// Mock format symbols
class MockFormatSymbols {
  final String decimalSeparator;
  final String thousandSeparator;

  MockFormatSymbols({
    this.decimalSeparator = '.',
    this.thousandSeparator = ',',
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedFlipCounter Demo'),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            // Basic counter test
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Basic Counter (0 → other values):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            AnimatedFlipCounter(
              value: _value,
              textStyle: const TextStyle(fontSize: 32, color: Colors.blue),
            ),
            // Currency format test
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Currency Format Test (\$0.00 → \$X.XX):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            AnimatedFlipCounter(
              value: _value,
              prefix: '\$',
              fractionDigits: 2,
              wholeDigits: 4,
              hideLeadingZeroes: true,
              thousandSeparator: ',',
              textStyle: const TextStyle(fontSize: 24, color: Colors.green),
            ),
            // Large numbers test
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Large Numbers Test (millions):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            AnimatedFlipCounter(
              value: 1000000 + _value,
              fractionDigits: 2,
              wholeDigits: 8,
              hideLeadingZeroes: true,
              thousandSeparator: ',',
              textStyle: const TextStyle(fontSize: 20, color: Colors.purple),
            ),
            // AnimatedFlipCounter(
            //   value: 10000000 + _value,
            //   fractionDigits: 2,
            //   thousandSeparator: ',',
            // ),
            // AnimatedFlipCounter(
            //   value: 10000000 + _value,
            //   fractionDigits: 2,
            // ),
            // AnimatedFlipCounter(
            //   value: _value,
            //   duration: const Duration(seconds: 1),
            //   padding: const EdgeInsets.all(8),
            //   curve: Curves.elasticOut,
            //   wholeDigits: 4,
            //   fractionDigits: 2,
            //   hideLeadingZeroes: true,
            //   thousandSeparator: ',',
            //   textStyle: const TextStyle(fontSize: 32, color: Colors.purple),
            // ),
            // AnimatedFlipCounter(
            //   value: _value,
            //   duration: const Duration(seconds: 1),
            //   curve: Curves.bounceOut,
            //   wholeDigits: 4,
            //   fractionDigits: 2,
            //   thousandSeparator: ',',
            //   textStyle: const TextStyle(fontSize: 32, color: Colors.blue),
            // ),
            AnimatedFlipCounter(
              value: _value,
              // Use "infix" to show a value between negative sign and number
              infix: ' \$',
              fractionDigits: 2,
              wholeDigits: 8,
              hideLeadingZeroes: true,
              // Some languages like French use comma as decimal separator
              decimalSeparator: ',',
              thousandSeparator: '.',
              padding: const EdgeInsets.all(8),
              textStyle: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: -8.0,
                color: _value < 0 ? Colors.red : Colors.green,
                shadows: const [
                  BoxShadow(
                    color: Colors.yellow,
                    offset: Offset(2, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            // AnimatedFlipCounter(
            //   value: (_value * 10000) + 0.48,
            //   fractionDigits: 2,
            //   wholeDigits: 8,
            //   hideLeadingZeroes: true,
            //   thousandSeparator: ',',
            // ),
            // Test removeTrailingZeroes functionality
            AnimatedFlipCounter(
              value: _value,
              fractionDigits: 4,
              removeTrailingZeroes: true,
              textStyle: const TextStyle(fontSize: 24, color: Colors.orange),
            ),
            // AnimatedFlipCounter(
            //   value: _value,
            //   fractionDigits: 4,
            //   removeTrailingZeroes: false,
            //   textStyle: const TextStyle(fontSize: 24, color: Colors.red),
            // ),

            // Test animation from 0 to other values
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Animation from \$0 test:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            AnimatedFlipCounter(
              value: _value,
              prefix: '\$',
              fractionDigits: 3,
              wholeDigits: 4,
              hideLeadingZeroes: true,
              thousandSeparator: ',',
              textStyle: const TextStyle(fontSize: 28, color: Colors.green),
            ),

            // Test case that mimics your app's usage
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Real App Scenario Test (Dynamic Precision):',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'This mimics your app: 0 → fractionDigits=0, other values → fractionDigits>0',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            Builder(
              builder: (context) {
                final formatSymbols = MockFormatSymbols();
                return AnimatedFlipCounter(
                  key: const ValueKey('balance_counter'), // Fixed key
                  value: _value,
                  duration: const Duration(milliseconds: 640),
                  curve: Curves.easeOutCubic,
                  textStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  fractionDigits: 9, // Fixed max digits instead of dynamic
                  hideLeadingZeroes: true,
                  removeTrailingZeroes:
                      true, // This will hide unnecessary zeros
                  decimalSeparator: formatSymbols.decimalSeparator,
                  thousandSeparator: formatSymbols.thousandSeparator,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Current value: $_value',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Dynamic fractionDigits: ${_value.calculateDecimalPrecision()}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Text(
                    'Fixed fractionDigits: 9',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Integer representation: ${(_value * math.pow(10, 9)).round()}',
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  Text(
                    'Original string: ${_value.toString()}',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Test Controls:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [0.01, 0.48, 1, 5, 400].map(_buildButtons).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reset to 0'),
                  onPressed: () => setState(() => _value = 0.0),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Set to 3.123'),
                  onPressed: () => setState(() => _value = 3.123),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Set to 1234.56'),
                  onPressed: () => setState(() => _value = 1234.56),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Balance Scenario Test (like your app):',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Account A\n(\$15.534)'),
                  onPressed: () => setState(() => _value = 15.534),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Account B\n(\$0)'),
                  onPressed: () => setState(() => _value = 0.0),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Account C\n(\$0.005471)'),
                  onPressed: () => setState(() => _value = 0.005471),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(num value) {
    return Column(
      children: [
        ElevatedButton(
          child: Text('+$value'),
          onPressed: () => setState(() => _value += value),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          child: Text('-$value'),
          onPressed: () => setState(() => _value -= value),
        ),
      ],
    );
  }
}
