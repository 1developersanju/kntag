import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/widgets/group_view_widgets/tag_tile.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  double kmSlider = 5;

  @override
  List<GroupTagList> containerDetails = [];

  Future showAlertBox() async {
    return await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text("Km Range 0 - ${kmSlider.round().toString()}"),
          content: Container(
            height: 50,
            child: (Slider(
              value: kmSlider,
              label: "${kmSlider.round().toString()} KM",
              min: 0,
              max: 100,
              divisions: 10,
              onChanged: (value) => {setState(() => kmSlider = value)},
            )),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("Ok"),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    containerDetails = tagTileDatas();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 130, 162, 189),
      appBar: AppBar(
        title: Text("KnTag"),
        // TextField(
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(),
        //     label: Text("Search")
        //   ),
        // ),
        actions: [
          // GestureDetector(
          //   onTap: () {
          //     showSearch(context: context, delegate: MySearchDelegate());
          //   },
          //   child: Container(
          //       width: currentWidth - 50, height: currentHeight/1000, color: Colors.red),
          // ),

          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.only(top: 11, right: 10),
            child: GestureDetector(
              onTap: () => showAlertBox(),
              child: Column(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                  Text(
                    "${kmSlider}Km",
                    style: TextStyle(fontSize: 10, color: Colors.black87),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: containerDetails.length,
        itemBuilder: (context, index) {
          return TagTile(
            tagText: containerDetails[index].tagText,
            joinedCount: containerDetails[index].joined,
            leftCount: containerDetails[index].spotLeft,
          );
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = ["BookTag", "MusicTag", "GameTag", "ShareTag"];

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //throw UnimplementedError();
    IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        // TODO: implement buildActions
        //throw UnimplementedError();
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: Icon(Icons.clear),
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //throw UnimplementedError();
    return Center(
      child: Text(
        query,
        style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //throw UnimplementedError();
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    //["BookTag", "MusicTag", "GameTag", "ShareTag"];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;

            showResults(context);
          },
        );
      },
    );
  }
}
