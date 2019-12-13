import 'package:catadopt/models/cat.dart';
import 'package:catadopt/services/api.dart';
import 'package:catadopt/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:catadopt/ui/cat_details/details_page.dart';

class CatList extends StatefulWidget{
  @override
  _CatListState createState() => new _CatListState();
}

class _CatListState extends State<CatList>{
  List<Cat> _cats = [];

  @override 
  void initState(){
    super.initState();
    _loadCats();
  }

  void _loadCats() async {
    String fileData = await DefaultAssetBundle.of(context).loadString("assets/cats.json");
    setState(() {
      _cats = CatApi.allCatsFromJson(fileData);
    });
    }

  _navigateToCatDetails(Cat cat, Object avatarTag){
    Navigator.of(context).push(
      new FadePageRoute(
        builder: (c){
          return new CatDetailsPage(cat, avatarTag: avatarTag);
        },
        settings: new RouteSettings(),
      )
    );
  }
  

  Widget _getAppTitleWidget(){
    return new Text(
      'Cats',
      style: new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
      ),
    );
  }

  Widget _buildBody(){
    return new Container(
      margin: const EdgeInsets.fromLTRB(
        0.0, 56.0, 0.0, 00),
        child: new Column(
          children: <Widget>[
            _getAppTitleWidget(),
            _getListViewWidget()
          ],
        )
    );
  }

  Future<Null> refresh(){
    _loadCats();
        return new Future<Null>.value();
      }
    

  Widget _buildCatItem(BuildContext context, int index) {
    Cat cat = _cats[index];

    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () => _navigateToCatDetails(cat, index),
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(cat.avatarUrl),
                ),
              ),
              title: new Text(
                cat.name,
                style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              subtitle: new Text(cat.description),
              isThreeLine: true, // Less Cramped Tile
              dense: false, // Less Cramped Tile
            ),
          ],
        ),
      ),
    );
  }


  Widget _getListViewWidget(){
    return new Flexible(child: new RefreshIndicator(
      onRefresh: refresh,
      child: new ListView.builder(itemBuilder: _buildCatItem,
      itemCount: _cats.length,
      physics: const AlwaysScrollableScrollPhysics(),)
    ));

  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: _buildBody(),
    );
  }
}