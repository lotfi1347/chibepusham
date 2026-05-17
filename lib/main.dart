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

  String shirt = "assets/clothes/shirts/shirt1.png";
  String pants = "assets/clothes/pants/pants1.png";
  String shoes = "assets/clothes/shoes/shoes1.png";
  String hat = "assets/clothes/hats/hat1.png";
  String glasses = "assets/clothes/glasses/glasses1.png";

  final Map<String, List<String>> wardrobe = {
    "shirts": ["assets/clothes/shirts/shirt1.png"],
    "pants": ["assets/clothes/pants/pants1.png"],
    "shoes": ["assets/clothes/shoes/shoes1.png"],
    "hats": ["assets/clothes/hats/hat1.png"],
    "glasses": ["assets/clothes/glasses/glasses1.png"],
  };

  void selectItem(String path) {
    setState(() {
      if (selectedCategory == "shirts") shirt = path;
      if (selectedCategory == "pants") pants = path;
      if (selectedCategory == "shoes") shoes = path;
      if (selectedCategory == "hats") hat = path;
      if (selectedCategory == "glasses") glasses = path;
    });
  }

  Widget safeImage(String path, {double? width}) {
    return Image.asset(
      path,
      width: width,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width ?? 80,
          height: width ?? 80,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Text(
              "PNG",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget wardrobePanel() {
    final items = wardrobe[selectedCategory] ?? [];

    return Container(
      height: 135,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return GestureDetector(
            onTap: () => selectItem(item),
            child: Container(
              width: 105,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white24),
              ),
              child: safeImage(item, width: 80),
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
              top: 135,
              child: Container(
                width: 120,
                height: 210,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(55),
                ),
              ),
            ),
            Positioned(
              top: 325,
              left: 95,
              child: Container(
                width: 38,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            Positioned(
              top: 325,
              right: 95,
              child: Container(
                width: 38,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),

            Positioned(top: 28, child: safeImage(hat, width: 110)),
            Positioned(top: 92, child: safeImage(glasses, width: 92)),
            Positioned(top: 130, child: safeImage(shirt, width: 190)),
            Positioned(top: 300, child: safeImage(pants, width: 165)),
            Positioned(top: 470, child: safeImage(shoes, width: 150)),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "ChiBepusham",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.favorite_border),
                  ),
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