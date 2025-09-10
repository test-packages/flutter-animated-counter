import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

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
