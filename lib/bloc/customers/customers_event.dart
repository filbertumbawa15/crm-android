part of 'customers_bloc.dart';

@immutable
sealed class CustomersEvent {}

class ListCustomerEvent extends CustomersEvent {}
