import 'package:flutter/material.dart';
import '../ar/ar_camera_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedWardrobe = 0;

  final wardrobes = [
    "👕 Shirts",
    "👖 Pants",
    "👟 Shoes",
    "🧢 Hats",
    "👓 Glasses",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔥 TOP PREVIEW BUTTON
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ARCameraPage(),
                    ),
                  );
                },
                child: const Text("Start AR Try-On"),
              ),
            ),
          ),

          // 🧥 WARDROBE SELECTOR
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: wardrobes.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedWardrobe = i;
                    });
                  },
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedWardrobe == i
                          ? Colors.blue
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        wardrobes[i],
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}