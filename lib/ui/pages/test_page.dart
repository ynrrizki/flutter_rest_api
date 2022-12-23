import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final ScrollController _scrollController = ScrollController();
  final MyRepository _repository = MyRepository();

  List<int> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMore();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length + 1,
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return _buildLoader();
          } else {
            return _buildItem(_items[index]);
          }
        },
      ),
    );
  }

  Widget _buildLoader() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container();
  }

  Widget _buildItem(int item) {
    return ListTile(
      title: Text(item.toString()),
    );
  }

  void _loadMore() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    _repository.getMoreData().then((newItems) {
      setState(() {
        _items.addAll(newItems);
        _isLoading = false;
      });
    });
  }
}

class MyRepository {
  Future<List<int>> getMoreData() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return some fake data
    return List.generate(50, (i) => i + 1);
  }
}
