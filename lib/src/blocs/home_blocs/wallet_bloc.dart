import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/wallet_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';
import 'package:rxdart/rxdart.dart';

class WalletBloc {
  final _repository = Repository();
  final _walletAccount = BehaviorSubject<CaptainWallet>();
  final _walletData = BehaviorSubject<WalletModel>();
  final _currentBalance = BehaviorSubject<String>();
  final _country = BehaviorSubject<String>();

  Observable<String> get currentBalance => _currentBalance.stream;
  Observable<WalletModel> get walletData => _walletData.stream;
  Observable<CaptainWallet> get account => _walletAccount.stream;
  Observable<String> get country => _country.stream;

  walletAccount() async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    CaptainWallet wallet = await _repository.walletAccount({
      "Authorization": "Bearer " + accessToken,
    },
        signInBloc.getCountryCode().toString());
    _walletAccount.add(wallet);

    WalletModel walletDetails = await _repository.walletDetails({
      "Authorization": "Bearer " + accessToken,
    }, _walletAccount.value.data.first.id.toString());
    _walletData.add(walletDetails);
    _currentBalance.add(_walletAccount.value.data.first.balance);
    _country.add(_walletAccount.value.data.first.country.nameEG+"-"+_walletAccount.value.data.first.country.countryCode);


  }

  currancy()
  {
    return _walletAccount.value.data.first.country.currency.currencyCode;
  }


}

final walletBloc = WalletBloc();
