import 'package:flutter/material.dart';

void main() {
  runApp(const ChiBepushamApp());
}

class ChiBepushamApp extends StatelessWidget {
  const ChiBepushamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChiBepusham Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String category = "Shirts";

  int shirt = 0;
  int pants = 0;
  int shoes = 0;
  int hat = 0;
  int glasses = 0;

  final List<Color> shirtColors = [Colors.orange, Colors.green, Colors.blue, Colors.purple];
  final List<Color> pantsColors = [Colors.blueGrey, Colors.brown, Colors.black87, Colors.indigo];
  final List<Color> shoesColors = [Colors.white, Colors.red, Colors.yellow, Colors.cyan];
  final List<Color> hatColors = [Colors.redAccent, Colors.amber, Colors.pink, Colors.teal];
  final List<Color> glassesColors = [Colors.lightBlueAccent, Colors.white, Colors.deepPurple, Colors.lime];

  List<Color> getCurrentColors() {
    if (category == "Shirts") return shirtColors;
    if (category == "Pants") return pantsColors;
    if (category == "Shoes") return shoesColors;
    if (category == "Hats") return hatColors;
    return glassesColors;
  }

  void selectItem(int index) {
    setState(() {
      if (category == "Shirts") shirt = index;
      if (category == "Pants") pants = index;
      if (category == "Shoes") shoes = index;
      if (category == "Hats") hat = index;
      if (category == "Glasses") glasses = index;
    });
  }

  Widget categoryButton(String name) {
    final active = category == name;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              category = name;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: active ? Colors.orange : Colors.white12,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            name,
            style: const TextStyle(fontSize: 11),
          ),
        ),
      ),
    );
  }

  Widget clothingItem(String label, Color color, double width, double height) {
    final textColor = color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget mannequin() {
    return Container(
      width: 320,
      height: 510,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 35,
            child: Container(
              width: 78,
              height: 78,
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 18,
            child: clothingItem("HAT", hatColors[hat], 120, 34),
          ),
          Positioned(
            top: 88,
            child: clothingItem("GLASSES", glassesColors[glasses], 125, 28),
          ),
          Positioned(
            top: 135,
            child: clothingItem("SHIRT", shirtColors[shirt], 185, 135),
          ),
          Positioned(
            top: 285,
            child: clothingItem("PANTS", pantsColors[pants], 155, 145),
          ),
          Positioned(
            top: 445,
            child: clothingItem("SHOES", shoesColors[shoes], 165, 42),
          ),
        ],
      ),
    );
  }

  Widget wardrobe() {
    final colors = getCurrentColors();

    return Container(
      height: 145,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          final textColor = color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

          return GestureDetector(
            onTap: () => selectItem(index),
            child: Container(
              width: 115,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white30, width: 2),
              ),
              child: Center(
                child: Text(
                  "$category\n${index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("ChiBepusham MVP"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              children: [
                categoryButton("Shirts"),
                categoryButton("Pants"),
                categoryButton("Shoes"),
                categoryButton("Hats"),
                categoryButton("Glasses"),
              ],
            ),
          ),
          Text(
            "Selected Closet: $category",
            style: const TextStyle(color: Colors.orange, fontSize: 16),
          ),
          Expanded(
            child: Center(
              child: mannequin(),
            ),
          ),
          wardrobe(),
        ],
      ),
    );
  }
}