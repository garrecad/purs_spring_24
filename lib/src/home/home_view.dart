import "package:flutter/material.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Image.asset(
                'assets/images/logo_icon.png',
                fit: BoxFit.scaleDown,
                height: AppBar().preferredSize.height,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Image.asset(
                'assets/images/logo_horizontal.png',
                fit: BoxFit.scaleDown,
                height: AppBar().preferredSize.height,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("MOCKED")))
                  },
              icon: const Icon(Icons.map)),
          IconButton(
              onPressed: () => {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("MOCKED")))
                  },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Card(
                  child: Center(child: Text("MOCKED")),
                ),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Card(
                  child: Center(child: Text("MOCKED")),
                ),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Card(
                  child: Center(child: Text("MOCKED")),
                ),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Card(
                  child: Center(child: Text("MOCKED")),
                ),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Card(
                  child: Center(child: Text("MOCKED")),
                ),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Card(
                  child: Center(child: Text("MOCKED")),
                ),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Card(
                  child: Center(child: Text("MOCKED")),
                ),
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
