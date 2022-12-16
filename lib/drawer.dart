import 'package:flutter/material.dart';

class ListViewBuilderPage extends StatelessWidget {
  const ListViewBuilderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ListView.builder")),
      body: Stack(
        children: [
          Container(
            color: Colors.amber,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.green,
                    height: 200,
                    child: ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item $index")),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
