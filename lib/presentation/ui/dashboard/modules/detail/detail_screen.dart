import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Title",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Expenses",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Mar"),
                        Text("13"),
                      ],
                    ),
                    title: Text("Roti"),
                    subtitle: Text("you paid Rs 400"),
                    trailing: Column(
                      children: [
                        Text(
                          "You Lend",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          "RS 500",
                          style: TextStyle(color: Colors.green),
                        ),
                        // Text(
                        //   "You owe",
                        //   style: TextStyle(color: Colors.green),
                        // ),
                        // Text(
                        //   "RS 500",
                        //   style: TextStyle(color: Colors.green),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Split Money",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
