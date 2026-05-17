import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final Uint8List imageBytes;

  ClosetItem({
    required this.name,
    required this.imageBytes,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker picker = ImagePicker();

  String selectedCategory = "Shirts";

  final Map<String, List<ClosetItem>> closets = {
    "Shirts": [],
    "Pants": [],
    "Shoes": [],
    "Hats": [],
    "Glasses": [],
  };

  final Map<String, ClosetItem?> selectedItems = {
    "Shirts": null,
    "Pants": null,
    "Shoes": null,
    "Hats": null,
    "Glasses": null,
  };

  Future<void> addItemToCloset() async {
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final bytes = await picked.readAsBytes();

    final item = ClosetItem(
      name: "$selectedCategory ${closets[selectedCategory]!.length + 1}",
      imageBytes: bytes,
    );

    setState(() {
      closets[selectedCategory]!.add(item);
      selectedItems[selectedCategory] = item;
    });
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void selectItem(ClosetItem item) {
    setState(() {
      selectedItems[selectedCategory] = item;
    });
  }

  Widget categoryButton(String name) {
    final active = selectedCategory == name;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: ElevatedButton(
          onPressed: () => selectCategory(name),
          style: ElevatedButton.styleFrom(
            backgroundColor: active ? Colors.orange : Colors.white12,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            name,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }

  Widget imageLayer(String category, double top, double width) {
    final item = selectedItems[category];
    if (item == null) return const SizedBox();

    return Positioned(
      top: top,
      child: Image.memory(
        item.imageBytes,
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget mannequin() {
    return Container(
      width: 330,
      height: 520,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 42,
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
            top: 125,
            child: Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),
          Positioned(
            top: 300,
            child: Container(
              width: 95,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),

          imageLayer("Hats", 18, 120),
          imageLayer("Glasses", 88, 110),
          imageLayer("Shirts", 120, 210),
          imageLayer("Pants", 285, 170),
          imageLayer("Shoes", 455, 160),
        ],
      ),
    );
  }

  Widget closetPanel() {
    final items = closets[selectedCategory]!;

    return Container(
      height: 165,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: addItemToCloset,
            child: Container(
              width: 110,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate, size: 34),
                  SizedBox(height: 8),
                  Text(
                    "Add\nPhoto",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      "Add your $selectedCategory photo",
                      style: const TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return GestureDetector(
                        onTap: () => selectItem(item),
                        child: Container(
                          width: 110,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Image.memory(
                            item.imageBytes,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
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
            "Closet: $selectedCategory",
            style: const TextStyle(color: Colors.orange, fontSize: 16),
          ),
          Expanded(
            child: Center(
              child: mannequin(),
            ),
          ),
          closetPanel(),
        ],
      ),
    );
  }
}