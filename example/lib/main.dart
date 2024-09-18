import 'package:flutter/material.dart';
import 'package:cache_manager/cache_manager.dart';

void main() {
  final CacheManager cacheManager = CacheManager();
  cacheManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cache Manager Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cache Manager Example'),
        ),
        body: const CacheManageExample(),
      ),
    );
  }
}


class CacheManageExample extends StatefulWidget {
  const CacheManageExample({super.key});

  @override
  State<CacheManageExample> createState() => _CacheManageExampleState();
}

class _CacheManageExampleState extends State<CacheManageExample> {
  final cacheManager = CacheManager();
  String _cacheDisplay = 'No data cached';

  @override
  void initState() {
    super.initState();

    _loadCache();
  }

  Future<void> _loadCache() async {
    final cache = await cacheManager.getCache('user_profile');
    setState(() {
      _cacheDisplay = cache != null
          ? 'Cache data: ${cache.toString()}'
          : 'Cache not found or expired';
    });
  }

  Future<void> _setCache() async {
    await cacheManager.setCache(
      'user_profile',
      {'name': 'Jane Doe', 'age': 25},
      duration: const Duration(minutes: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cache set successfully!')),
    );
    _loadCache();
  }

  Future<void> _getCache() async {
    final cache = await cacheManager.getCache('user_profile');
    final message = cache != null
        ? 'Cache data: ${cache.toString()}'
        : 'Cache not found or expired';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    _loadCache();
  }

  Future<void> _deleteCache() async {
    await cacheManager.deleteCache('user_profile');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cache deleted successfully!')),
    );
    _loadCache();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: _setCache,
            child: const Text('Set Cache'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _getCache,
            child: const Text('Get Cache'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _deleteCache,
            child: const Text('Delete Cache'),
          ),
          const SizedBox(height: 20),
          Text(
            _cacheDisplay,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}