import 'package:bloc/bloc.dart';
import 'package:crm_android/models/response/customer_response_model.dart';
import 'package:crm_android/repository/customer_repository.dart';
import 'package:meta/meta.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final customerRepository = CustomerRepository();
  CustomersBloc() : super(CustomersInitial()) {
    on<CustomersEvent>((event, emit) async {
      if (event is ListCustomerEvent) {
        try {
          emit(CustomersLoading());
          final response = await customerRepository.getCustomers();
          emit(CustomersLoaded(response.listCustomers));
        } catch (e) {
          emit(CustomersFailed(e.toString()));
        }
      }
    });
  }
}
