import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/ui/views/group_view/TagsAndPeople/tags_and_people.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:kntag/widgets/group_view_widgets/tag_tile.dart';
import 'package:sizer/sizer.dart';

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
    containerDetails = groupTileDatas();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(3), // flex: 4,
          child: Container(
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: new BorderSide(color: Colors.white)),
                  filled: true,
                  fillColor: whiteClr,
                  hintText: "search",
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        //  Text(
        //   "KnTag",
        //   style: TextStyle(color: Colors.black, fontSize: 16.sp),
        // ),
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
                    color: titleColor,
                  ),
                  Text(
                    "${kmSlider}Km",
                    style: TextStyle(fontSize: 7.sp, color: Colors.black87),
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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TagsAndPeopleView(
                          title: containerDetails[index].tagText,
                          memberCount: containerDetails[index].joined,
                        )),
              );
            },
            child: TagTile(
              tagText: containerDetails[index].tagText,
              joinedCount: containerDetails[index].joined,
              leftCount: containerDetails[index].spotLeft,
              userProfile: containerDetails[index].userProfileData,
            ),
          );
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    '#BookClub',
  ];

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
