import 'package:flutter/material.dart';
import 'package:flutter_parallax_effect/image_path.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;

  List<String> images = [ImagePath.image_1, ImagePath.image_2];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
    ); // Makes pages slightly visible
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Parallax Effect"),
      ),
      body: SizedBox(
        height: 500,
        child: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double pageOffset = 0;
                if (_pageController.position.haveDimensions) {
                  pageOffset = _pageController.page!;
                }
                double parallax = (pageOffset * 0.4).clamp(-1.0, 1.0);

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 50,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      alignment: Alignment(parallax, 0),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
