import 'dart:convert';

import 'package:http/http.dart';
import 'package:posta_courier/models/wallet_model.dart';
import 'package:posta_courier/src/constants/constants.dart';

class WalletProvider{
  Client client=Client();

  var walletUrl=Constants.MAIN_URL+"captain_transactions?";
  var accountUrl=Constants.MAIN_URL+"captain_wallet?country_code=";

  Future<CaptainWallet> getWalletAccount(Map<String,String> header,String countryCode )
  async {
    var response = await client.get(accountUrl+countryCode,headers: header);
    return CaptainWallet.fromJson(jsonDecode(response.body));
  }
  Future<WalletModel> wallet(Map<String,String> header,String accountId )
  async {
    var response = await client.get(walletUrl+"account_id=$accountId&page=1&per_page=20",headers: header);
    print(response.body);

    return WalletModel.fromJson(jsonDecode(response.body));
  }


}