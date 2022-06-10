import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/widgets/group_view_widgets/tag_tile.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  List<GroupTagList> containerDetails = [];

  int km = 5;

  Future showAlertBox() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          double currentSliderValue = 20;
          return AlertDialog(
              title: Text("Filer the KM"),
              content: Slider(
      value: currentSliderValue,
      max: 100,
      divisions: 5,
      label: currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          currentSliderValue = value;
        });
      },
    ));
        });
  }

  @override
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
        title: Text(""),
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
                    color: Colors.blue[900],
                  ),
                  Text(
                    "${km}Km",
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
              subText: containerDetails[index].subText);
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

