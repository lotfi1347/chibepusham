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
      home: const HomePage(),
    );
  }
}

class ClosetItem {
  final String name;
  final Color color;

  const ClosetItem(this.name, this.color);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClosetItem shirt = const ClosetItem("Orange Shirt", Colors.orange);
  ClosetItem pants = const ClosetItem("Blue Pants", Colors.blueGrey);
  ClosetItem shoes = const ClosetItem("White Shoes", Colors.white);
  ClosetItem hat = const ClosetItem("Red Hat", Colors.redAccent);
  ClosetItem glasses = const ClosetItem("Blue Glasses", Colors.lightBlueAccent);

  final Map<String, List<ClosetItem>> closets = const {
    "Shirts": [
      ClosetItem("Orange Shirt", Colors.orange),
      ClosetItem("Green Shirt", Colors.green),
      ClosetItem("Purple Shirt", Colors.purple),
      ClosetItem("Blue Shirt", Colors.blue),
    ],
    "Pants": [
      ClosetItem("Blue Pants", Colors.blueGrey),
      ClosetItem("Brown Pants", Colors.brown),
      ClosetItem("Black Pants", Colors.black87),
      ClosetItem("Indigo Pants", Colors.indigo),
    ],
    "Shoes": [
      ClosetItem("White Shoes", Colors.white),
      ClosetItem("Red Shoes", Colors.red),
      ClosetItem("Yellow Shoes", Colors.yellow),
      ClosetItem("Cyan Shoes", Colors.cyan),
    ],
    "Hats": [
      ClosetItem("Red Hat", Colors.redAccent),
      ClosetItem("Amber Hat", Colors.amber),
      ClosetItem("Pink Hat", Colors.pink),
      ClosetItem("Teal Hat", Colors.teal),
    ],
    "Glasses": [
      ClosetItem("Blue Glasses", Colors.lightBlueAccent),
      ClosetItem("White Glasses", Colors.white),
      ClosetItem("Purple Glasses", Colors.deepPurpleAccent),
      ClosetItem("Lime Glasses", Colors.lime),
    ],
  };

  void openCloset(String category) {
    final items = closets[category] ?? [];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111111),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SizedBox(
          height: 310,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                category,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (category == "Shirts") shirt = item;
                          if (category == "Pants") pants = item;
                          if (category == "Shoes") shoes = item;
                          if (category == "Hats") hat = item;
                          if (category == "Glasses") glasses = item;
                        });

                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 135,
                        margin: const EdgeInsets.only(right: 14),
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white30, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: item.color == Colors.white || item.color == Colors.yellow
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget closetButton(String title, IconData icon) {
    return GestureDetector(
      onTap: () => openCloset(title),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget mannequin() {
    return Center(
      child: Container(
        width: 310,
        height: 520,
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 42,
              child: Container(
                width: 82,
                height: 82,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 28,
              child: Container(
                width: 120,
                height: 36,
                decoration: BoxDecoration(
                  color: hat.color,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(child: Text(hat.name, style: const TextStyle(fontSize: 10))),
              ),
            ),
            Positioned(
              top: 96,
              child: Container(
                width: 115,
                height: 26,
                decoration: BoxDecoration(
                  color: glasses.color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    glasses.name,
                    style: TextStyle(
                      fontSize: 9,
                      color: glasses.color == Colors.white || glasses.color == Colors.yellow
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 135,
              child: Container(
                width: 175,
                height: 145,
                decoration: BoxDecoration(
                  color: shirt.color,
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Center(child: Text(shirt.name, textAlign: TextAlign.center)),
              ),
            ),
            Positioned(
              top: 292,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: pants.color,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Text(pants.name, textAlign: TextAlign.center)),
              ),
            ),
            Positioned(
              top: 455,
              child: Container(
                width: 160,
                height: 42,
                decoration: BoxDecoration(
                  color: shoes.color,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: Text(
                    shoes.name,
                    style: TextStyle(
                      color: shoes.color == Colors.white || shoes.color == Colors.yellow
                          ? Colors.black
                          : Colors.white,
                    ),
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("ChiBepusham"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: mannequin()),
          Padding(
            padding: const EdgeInsets.all(14),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                closetButton("Shirts", Icons.checkroom),
                closetButton("Pants", Icons.accessibility_new),
                closetButton("Shoes", Icons.directions_walk),
                closetButton("Hats", Icons.person),
                closetButton("Glasses", Icons.remove_red_eye),
              ],
            ),
          ),
        ],
      ),
    );
  }
}