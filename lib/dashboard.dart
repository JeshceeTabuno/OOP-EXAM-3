import 'package:flutter/material.dart';
import 'compose.dart';

class NewPost extends Compose {
  message() {
    return super.message();
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}

class DashboardScreen extends StatefulWidget {
  @override
  Dashboard createState() => Dashboard();
}

class Dashboard extends State<DashboardScreen> {
  String accountName = "admin";
  String accountPic = "assets/Surprise heavy.jpg";

  final accountIcon =
      SnackBar(content: Text('ERROR: account page is still being fixed.'));
  final settingsIcon =
      SnackBar(content: Text('ERROR: settings page is still being fixed.'));
  final postUpdate =
      SnackBar(content: Text('UPDATE: post has been successfully published.'));

  final List<PostTiles> postsList = <PostTiles>[
    PostTiles("assets/Abathur_SC2_Portrait.jpg", "ABBY",
        "ZERG MUST EVOLVE INTO PERFECT SPECIES"),
    PostTiles("assets/DEAR GOD.png", "DEAR GOD", "DEAR GOD!"),
    PostTiles("assets/Jull.png", "Jull",
        "VE WILL FIGHT! VE WILL WIN! VE WILL DRINK!"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Image.asset(accountPic),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(accountIcon);
            },
          ),
          title: Container(
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.scaleDown,
              ))),
          actions: [
            IconButton(
              iconSize: 35,
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(settingsIcon);
              },
            )
          ],
        ),
        body: RefreshIndicator(
          edgeOffset: 0,
          onRefresh: _refresh,
          child: ListView.builder(
            itemCount: postsList.length,
            itemBuilder: (ListViewContext, index) {
              return Container(
                margin: EdgeInsets.all(1),
                color: Colors.grey,
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(postsList[index].image)),
                  title: Text(postsList[index].username,
                      style: TextStyle(color: Colors.black)),
                  subtitle: Text(postsList[index].message,
                      style: TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ComposeScreen()));
            }));
  }

  Future<void> _refresh() {
    if (NewPost().message() != "") {
      UpdatePosts();
      Compose.messagePost = "";
      ScaffoldMessenger.of(context).showSnackBar(postUpdate);
    }
    return Future.delayed(Duration(seconds: 1));
  }

  void UpdatePosts() async {
    setState(() {
      postsList.insert(
          0, PostTiles(accountPic, accountName, NewPost().message()));
    });
  }
}

class PostTiles {
  PostTiles(this.image, this.username, this.message);

  final String image;
  final String username;
  final String message;
}
