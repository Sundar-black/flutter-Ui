import 'package:flutter/material.dart';

void main() => runApp(const GemStoreApp());

class GemStoreApp extends StatelessWidget {
  const GemStoreApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gemstore',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const GemStoreHome(),
    );
  }
}

class GemStoreHome extends StatefulWidget {
  const GemStoreHome({super.key});
  @override
  State<GemStoreHome> createState() => _GemStoreHomeState();
}

class _GemStoreHomeState extends State<GemStoreHome> {
  int selectedCategory = 0;
  int navIndex = 0;

  final categories = const [
    {'icon': '♀', 'label': 'Women'},
    {'icon': '♂', 'label': 'Men'},
    {'icon': '👓', 'label': 'Accessories'},
    {'icon': '💄', 'label': 'Beauty'},
  ];

  final products = const [
    {'image': 'assets/images/prod1.png', 'name': 'Long Sleeve Dress', 'price': 45.0},
    {'image': 'assets/images/prod2.png', 'name': 'Sportwear Set', 'price': 80.0},
    {'image': 'assets/images/prod3.png', 'name': 'Pink Sweater', 'price': 60.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, size: 28),
                      onPressed: () {},
                    ),
                    const Text('Gemstore', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none_rounded, size: 28),
                          onPressed: () {},
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 86,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                  itemBuilder: (context, i) {
                    final isSel = selectedCategory == i;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = i),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: isSel ? Colors.black : const Color(0xFFEDEDEF),
                            child: Text(
                              categories[i]['icon']!,
                              style: TextStyle(fontSize: 22, color: isSel ? Colors.white : Colors.black),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            categories[i]['label']!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSel ? FontWeight.w700 : FontWeight.w400,
                              color: isSel ? Colors.black : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/banner.png', height: 180, width: double.infinity, fit: BoxFit.cover),
                      Positioned(
                        right: 20,
                        top: 20,
                        child: Text(
                          'Autumn\nCollection\n2022',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            shadows: [Shadow(blurRadius: 6, color: Colors.black45, offset: Offset(0, 2))],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Feature Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Show all', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 270,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, i) {
                    final p = products[i];
                    return ProductCard(image: p['image'] as String, name: p['name'] as String, price: p['price'] as double);
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        onDestinationSelected: (i) => setState(() => navIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: ''),
          NavigationDestination(icon: Icon(Icons.search), label: ''),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: ''),
          NavigationDestination(icon: Icon(Icons.person_outline), label: ''),
        ],
        height: 68,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.image, required this.name, required this.price});
  final String image;
  final String name;
  final double price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 3/4,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text('\$ ${price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}