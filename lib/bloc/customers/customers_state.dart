part of 'customers_bloc.dart';

@immutable
sealed class CustomersState {}

final class CustomersInitial extends CustomersState {}

final class CustomersLoading extends CustomersState {}

final class CustomersLoaded extends CustomersState {
  final List<CustomersResponseModel> result;
  CustomersLoaded(this.result);
}

final class CustomersFailed extends CustomersState {
  final String? message;
  CustomersFailed(this.message);
}
