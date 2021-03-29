import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/action_obj_model.dart';
import 'package:posta_courier/models/unsuccessful_order_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UnsuccessfulOrderBloc {
  final _repository = Repository();
  final _reasons = BehaviorSubject<UnsuccessfulOrderModel>();
  final _selectedReason = BehaviorSubject<String>();
  final _selectedType = BehaviorSubject<String>();
  final _orderId = BehaviorSubject<int>();
  final _selectedReasonDetails = BehaviorSubject<Reason>();
  final _reason = BehaviorSubject<ActionObj>();
  final _actionObj = ActionObj();

  Observable<UnsuccessfulOrderModel> get reasons => _reasons.stream;

  Observable<String> get selectedReasons => _selectedReason.stream;

  unsuccessfulReasons(String type) async {
    if (_selectedType.value != type) {
      _selectedType.add(type);

      UnsuccessfulOrderModel _unsuccessfulReason =
      await _repository.unsuccessfulReason(type);
      _reasons.add(_unsuccessfulReason);
      _selectedReasonDetails.add(_reasons.value.data.data.first);
      _selectedReason.add(_reasons.value.data.data.first.reason);
      _actionObj.setAction("UNSUCCESSFUL");
    } else {}
  }

  setSelectedReason(String value) {
    _selectedReason.add(value);
    _selectedReasonDetails.add(_reasons.value.data.data[_reasons.value.data.data
        .indexWhere((element) => element.reason == _selectedReason.value)]);
    _actionObj.setAction("UNSUCCESSFUL");
  }

  setOrderId(int id) {
    _orderId.add(id);
  }

  setUnsuccessfulOrder(String photo, Uint8List sig, String ref) {
    _repository.setUnsuccessfulOrder(_selectedReasonDetails.value.id,
        "UNSUCCESSFUL", _orderId.value, photo, sig, ref);
  }

  void dispose() {
    _reasons.close();
    _selectedReason.close();
  }
}

final unsuccessfulOrderBloc = UnsuccessfulOrderBloc();
