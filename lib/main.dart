import 'package:flutter/material.dart';

void main() {
  runApp(const ChiBepushamApp());
}

class ChiBepushamApp extends StatelessWidget {
  const ChiBepushamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCloth = "assets/clothes/shirt.png";

  final List<String> clothes = [
    "assets/clothes/shirt.png",
    "assets/clothes/pants.png",
    "assets/clothes/hoodie.png",
    "assets/clothes/jacket.png",
  ];

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
          Expanded(
            flex: 4,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 180,
                        color: Colors.white24,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 120,
                    child: Image.asset(
                      selectedCloth,
                      width: 220,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Wardrobe",
              style: TextStyle(fontSize: 22),
            ),
          ),

          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: clothes.length,
              itemBuilder: (context, index) {
                final item = clothes[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCloth = item;
                    });
                  },
                  child: Container(
                    width: 110,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(item),
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
}