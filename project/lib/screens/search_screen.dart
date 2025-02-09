import 'package:flutter/material.dart';
import 'package:faxx_checker/services/api_services.dart';
import 'package:faxx_checker/widgets/results_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> recentSearches = [
    'Arvind Kejriwal will become chief minister for fourth time',
    '487 presumed Indians face final removal orders',
    'Cabinet clears new income tax bill',
    'Kerala Budget: Court fee hike after 20 years',
  ];
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _result;
  bool _isLoading = false;
  bool _showResults = false;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _showResults = true;
    });

    try {
      final result = await ApiService.factCheck(query);
      setState(() => _result = result);
      
      // Add to recent searches if not already present
      if (!recentSearches.contains(query)) {
        setState(() => recentSearches.insert(0, query));
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for Real-time News',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onSubmitted: (value) => _performSearch(value),
            ),
          ),
        ),
      ),
      body: _buildBodyContent(),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildBodyContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Column(
      children: [
        if (_showResults && _result != null)
          Expanded(child: ResultsWidget(result: _result!))
        else
          Expanded(child: _buildRecentSearches()),
      ],
    );
  }

  Widget _buildRecentSearches() {
    return ListView.builder(
      itemCount: recentSearches.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text(recentSearches[index]),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() => recentSearches.removeAt(index));
            },
          ),
          onTap: () {
            _searchController.text = recentSearches[index];
            _performSearch(recentSearches[index]);
          },
        );
      },
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.image),
            label: const Text('Image'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.link),
            label: const Text('URL'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}