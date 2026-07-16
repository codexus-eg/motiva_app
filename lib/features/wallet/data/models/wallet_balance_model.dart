import '../../domain/entities/wallet_balance.dart';

class WalletBalanceModel {
  final WalletBalance balance;

  const WalletBalanceModel(this.balance);

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceModel(
      WalletBalance(
        walletId: json['walletId'] as String,
        userId: json['userId'] as String,
        balance: json['balance'] as String,
        currency: json['currency'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'walletId': balance.walletId,
    'userId': balance.userId,
    'balance': balance.balance,
    'currency': balance.currency,
  };
}
