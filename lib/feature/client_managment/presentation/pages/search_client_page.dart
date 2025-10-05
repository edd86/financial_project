import 'package:financial_project/core/app_routes.dart';
import 'package:financial_project/core/global_widgets.dart';
import 'package:financial_project/feature/client_managment/presentation/provider/search_client_provider.dart';
import 'package:financial_project/feature/client_managment/presentation/widgets/client_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchClientPage extends StatefulWidget {
  const SearchClientPage({super.key});

  @override
  State<SearchClientPage> createState() => _SearchClientPageState();
}

class _SearchClientPageState extends State<SearchClientPage> {
  final _searchController = TextEditingController();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.75.h, horizontal: 7.85.w),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                label: GlobalWidgets.customLabelWidget(
                  Icons.search_sharp,
                  'Razón / NIT',
                ),
                suffixIcon: IconButton(
                  icon: Icon(isSearching ? Icons.clear : Icons.search),
                  onPressed: () {
                    _searchController.text = '';
                    setState(() {
                      isSearching = false;
                    });
                    Provider.of<SearchClientProvider>(
                      context,
                      listen: false,
                    ).searchClients('');
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isSearching = value.isNotEmpty;
                });
                Provider.of<SearchClientProvider>(
                  context,
                  listen: false,
                ).searchClients(value);
              },
            ),
            Expanded(
              child: Consumer<SearchClientProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.searchResults.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.clientPage,
                          arguments: provider.searchResults[index],
                        ),
                        child: ClientTile(
                          client: provider.searchResults[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
