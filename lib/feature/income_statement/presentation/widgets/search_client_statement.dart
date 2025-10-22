import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:financial_project/feature/income_statement/presentation/provider/client_statement_provider.dart';
import 'package:financial_project/feature/income_statement/presentation/provider/search_client_statement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchClientStatement extends StatefulWidget {
  const SearchClientStatement({super.key});

  @override
  State<SearchClientStatement> createState() => _SearchClientStatementState();
}

class _SearchClientStatementState extends State<SearchClientStatement> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerSearch = Provider.of<SearchClientStatementProvider>(
      context,
      listen: false,
    );
    final providerClient = Provider.of<ClientStatementProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSearchBar(
          controller: _searchController,
          onChanged: (value) {
            providerSearch.setClientStatement(name: value);
          },
        ),
      ),
      body: Consumer<SearchClientStatementProvider>(
        builder: (context, provider, child) {
          if (!provider.clientStatements.success) {
            final res = provider.clientStatements.message;
            return Center(child: Text(res));
          }
          final clients = provider.clientStatements.data ?? [];
          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              return ListTile(
                leading: Icon(Icons.person_search),
                title: Text(client.name),
                subtitle: Text(client.nitCi),
                onTap: () {
                  providerClient.setClient(client);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}
