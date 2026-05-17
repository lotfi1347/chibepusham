import 'package:flutter/material.dart';

void main() {
  runApp(const ChiBepushamApp());
}

class ChiBepushamApp extends StatelessWidget {
  const ChiBepushamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChiBepusham',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TryOnHomePage(),
    );
  }
}

class TryOnHomePage extends StatefulWidget {
  const TryOnHomePage({super.key});

  @override
  State<TryOnHomePage> createState() => _TryOnHomePageState();
}

class _TryOnHomePageState extends State<TryOnHomePage> {
  String selectedCategory = "shirts";

  Color shirtColor = Colors.orange;
  Color pantsColor = Colors.blueGrey;
  Color shoesColor = Colors.white;
  Color hatColor = Colors.redAccent;
  Color glassesColor = Colors.lightBlueAccent;

  final Map<String, List<Color>> wardrobeColors = {
    "shirts": [Colors.orange, Colors.green, Colors.purple, Colors.blue],
    "pants": [Colors.blueGrey, Colors.brown, Colors.indigo, Colors.black87],
    "shoes": [Colors.white, Colors.red, Colors.yellow, Colors.cyan],
    "hats": [Colors.redAccent, Colors.amber, Colors.pink, Colors.teal],
    "glasses": [Colors.lightBlueAccent, Colors.white, Colors.deepPurpleAccent, Colors.lime],
  };

  void selectColor(Color color) {
    setState(() {
      if (selectedCategory == "shirts") shirtColor = color;
      if (selectedCategory == "pants") pantsColor = color;
      if (selectedCategory == "shoes") shoesColor = color;
      if (selectedCategory == "hats") hatColor = color;
      if (selectedCategory == "glasses") glassesColor = color;
    });
  }

  Widget categoryButton(String name, String label) {
    final active = selectedCategory == name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: active ? Colors.orange : Colors.white10,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget wardrobePanel() {
    final colors = wardrobeColors[selectedCategory] ?? [];

    return Container(
      height: 135,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];

          return GestureDetector(
            onTap: () => selectColor(color),
            child: Container(
              width: 105,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white30, width: 2),
              ),
              child: Center(
                child: Text(
                  selectedCategory.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget mannequin() {
    return Center(
      child: Container(
        width: 300,
        height: 560,
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 45,
              child: Container(
                width: 85,
                height: 85,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              top: 130,
              child: Container(
                width: 170,
                height: 150,
                decoration: BoxDecoration(
                  color: shirtColor,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Center(
                  child: Text(
                    "SHIRT",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 285,
              child: Container(
                width: 150,
                height: 170,
                decoration: BoxDecoration(
                  color: pantsColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Center(
                  child: Text(
                    "PANTS",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 24,
              child: Container(
                width: 120,
                height: 38,
                decoration: BoxDecoration(
                  color: hatColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(child: Text("HAT")),
              ),
            ),

            Positioned(
              top: 98,
              child: Container(
                width: 105,
                height: 28,
                decoration: BoxDecoration(
                  color: glassesColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "GLASSES",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 470,
              child: Container(
                width: 150,
                height: 45,
                decoration: BoxDecoration(
                  color: shoesColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                  child: Text(
                    "SHOES",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTitle = selectedCategory.toUpperCase();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 18, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "ChiBepusham",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(Icons.favorite_border),
                ],
              ),
            ),

            SizedBox(
              height: 52,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                children: [
                  categoryButton("shirts", "Shirts"),
                  categoryButton("pants", "Pants"),
                  categoryButton("shoes", "Shoes"),
                  categoryButton("hats", "Hats"),
                  categoryButton("glasses", "Glasses"),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Selected: $currentTitle",
                style: const TextStyle(color: Colors.white54),
              ),
            ),

            Expanded(child: mannequin()),

            wardrobePanel(),
          ],
        ),
      ),
    );
  }
}