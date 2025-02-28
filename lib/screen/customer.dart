import 'package:crm_android/bloc/customers/customers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outlet Master"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(
              //   context: context,
              //   delegate: OutletSearchDelegate(),
              // );
            },
          ),
        ],
      ),
      body: BlocBuilder<CustomersBloc, CustomersState>(
        builder: (context, state) {
          if (state is CustomersInitial) {
            return const SizedBox(child: CircularProgressIndicator());
          } else if (state is CustomersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomersLoaded) {
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final customers = state.result[index];
                return Card(
                  child: ListTile(
                    title: Text(customers.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(customers.address!,
                        style: const TextStyle(color: Colors.grey)),
                  ),
                );
              },
            );
          } else if (state is CustomersFailed) {
            return Center(child: Text(state.message!));
          } else {
            return const SizedBox(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
