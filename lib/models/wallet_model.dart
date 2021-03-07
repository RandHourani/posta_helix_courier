
import 'country_model.dart';

class WalletModel {
  Wallet wallet;

  WalletModel({this.wallet});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(wallet: Wallet.fromJson(json['data']));
  }
}

class Wallet {
  List<TransactionData> data;

  Wallet({this.data});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<TransactionData> details =
        list.map((i) => TransactionData.fromJson(i)).toList();
    return Wallet(data: details);
  }
}

class TransactionData {
  int id;
  String lastBalance;
  String dateTime;

  List<TransactionList> transactionList;

  TransactionData({this.id, this.lastBalance, this.transactionList, this.dateTime});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    var list = json['transactions_list'] as List;
    List<TransactionList> details =
        list.map((i) => TransactionList.fromJson(i)).toList();
    return TransactionData(
      id: json["id"] as int,
      lastBalance: json['last_balance'] as String,
      transactionList: details,
      dateTime: json['created_at'] as String,

    );
  }
}

class TransactionList {
  int id;
  String type;
  String amount;
  String details;

  TransactionList(
      {this.id, this.type, this.details, this.amount});

  factory TransactionList.fromJson(Map<String, dynamic> json) {

    return TransactionList(
        id: json["id"] as int,
        type: json['type'] as String,
        amount: json['amount'] as String,
        details: json['details'] as String);
  }
}

class CaptainWallet {
  List<WalletData> data;

  CaptainWallet({this.data});
  factory CaptainWallet.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<WalletData> details =
    list.map((i) => WalletData.fromJson(i)).toList(

    );
    return CaptainWallet(data:details);

  }

}

class WalletData {
  int id;
  int parent;
  int countryId;
  int ownerId;
  String balance;
  Details country;

  WalletData(
      {this.id,
      this.balance,
      this.country,
      this.countryId,
      this.ownerId,
      this.parent});

  factory WalletData.fromJson(Map<String,dynamic>json){
    return WalletData(
      id: json['id']as int,
      parent: json['parent']as int,
      country: Details.fromJson(json['country']),
      balance: json['balance']as String,
      ownerId: json['owner_id']as int,
      countryId: json['country_id']as int,

    );
  }
}
