import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String controller = '';

  String qrcodeRes = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr code app"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                print(value);
                if (value.isEmpty) {
                  setState(() {
                    controller = '';
                  });
                } else {
                  setState(() {
                    controller = value;
                  });
                }
              },
              decoration:
                  const InputDecoration(label: Text("Enter text to generate")),
            ),

            const SizedBox(
              height: 30,
            ),

            ///Qrcode widget
            BarcodeWidget(data: controller.trim(), barcode: Barcode.qrCode()),

            const SizedBox(
              height: 50,
            ),

            Text(qrcodeRes),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            scanCode();
          },
          label: const Text('Scan Qrcode')),
    );
  }

  void scanCode() async {
    String res = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", 'Cancel', true, ScanMode.QR);

    print(res);

    setState(() {
      qrcodeRes = res;
    });
  }
}
