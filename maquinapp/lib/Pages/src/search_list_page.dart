import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = const Text(
    "Buscar en MaquinApp...",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<String> _list = [];
  bool _IsSearching = true;
  String _searchText = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    init();
  }

  void init() {
    _list = [];
    _list.add("Google");
    _list.add("IOS");
    _list.add("Andorid");
    _list.add("Dart");
    _list.add("Flutter");
    _list.add("Python");
    _list.add("React");
    _list.add("Xamarin");
    _list.add("Kotlin");
    _list.add("Java");
    _list.add("RxAndroid");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: buildBar(context),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        children: _IsSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => ChildItem(contact)).toList();
    } else {
      List<String> _searchList = [];
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => ChildItem(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0XFF3B3A38),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF343436),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        alignment: Alignment.centerLeft,
        child: TextField(
          autofocus: true,
          cursorColor: Colors.white,
          controller: _searchQuery,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
              top: 15,
              left: 0,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 30,
              color: Color(0xFFFDD835),
            ),
            hintText: "Buscar en MaquinApp...",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          onPressed: () {
            _handleSearchEnd();
          },
        ),
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(this.name));
  }
}
