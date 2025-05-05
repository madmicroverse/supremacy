sealed class CoinsBE {}

class InitCoinsBE extends CoinsBE {}

class UpdateCoinsAmountBE extends CoinsBE {
  final int amount;

  UpdateCoinsAmountBE(this.amount);
}

class ShowUserDetailCoinsBE extends CoinsBE {}
