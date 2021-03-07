import 'package:posta_courier/models/tikets_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TicketBloc{
  var _repository = Repository();
  var _ticket = BehaviorSubject<TicketsModel>();

  Observable<TicketsModel> get ticket => _ticket.stream;


}
final ticketBloc=TicketBloc();