import 'package:flutter/material.dart';

class ResultsWidget extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultsWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (result['answer'] != null)
            Text(
              'Answer: ${result['answer']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 10),
          const Text(
            'Sources:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: result['results']?.length ?? 0,
              itemBuilder: (context, index) {
                final source = result['results'][index];
                return ListTile(
                  title: Text(source['title']),
                  subtitle: Text(source['url']),
                  onTap: () {
                    // Handle URL opening (add url_launcher package)
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}