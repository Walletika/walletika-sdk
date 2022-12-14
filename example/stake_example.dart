import 'package:walletika_sdk/walletika_sdk.dart';
import 'package:web3dart/web3dart.dart';

void main() async {
  EthereumAddress address = EthereumAddress.fromHex(
    '0xC94EA8D9694cfe25b94D977eEd4D60d7c0985BD3',
  );

  // initialize walletika SDK
  await walletikaSDKInitialize();

  NetworkData networkData = NetworkData(
    rpc: 'https://data-seed-prebsc-1-s1.binance.org:8545',
    name: 'Binance Smart Chain (Testnet)',
    chainID: 97,
    symbol: 'BNB',
    explorer: 'https://testnet.bscscan.com',
  );

  // Connect with RPC
  bool isConnected = await Provider.connect(networkData);

  TokenData tokenData = TokenData(
    contract: EthereumAddress.fromHex(
      '0xc4d3716B65b9c4c6b69e4E260b37e0e476e28d87',
    ),
    name: 'Walletika',
    symbol: 'WTK',
    decimals: 18,
    website: '',
  );

  StakeData stakeData = StakeData(
    rpc: 'https://data-seed-prebsc-1-s1.binance.org:8545',
    contract: EthereumAddress.fromHex(
      '0xbfAa034b854703f31B34eCC1c68C356feeb19268',
    ),
    stakeToken: tokenData,
    rewardToken: tokenData,
    startBlock: 23545120,
    endBlock: 128636320,
    startTime: DateTime.parse('1970-01-01 02:00:00.000'),
    endTime: DateTime.parse('1970-01-01 02:00:00.000'),
  );

  // Token engine
  StakeEngine stakeEngine = StakeEngine(
    stakeData: stakeData,
    sender: address,
  );

  // Get totalSupply
  EtherAmount totalSupply = await stakeEngine.totalSupply();

  // Get rewardSupply
  EtherAmount rewardSupply = await stakeEngine.rewardSupply();

  // Check balance
  EtherAmount balance = await stakeEngine.balanceOf(address: address);

  // Despoit token
  TxDetailsData txDetails = await stakeEngine.deposit(
    amount: balance,
  );
  Transaction tx = txDetails.tx;
  Map<String, dynamic> abi = txDetails.abi;
  Map<String, dynamic> args = txDetails.args;
  String data = txDetails.data;

  // Add gas fee
  TxGasDetailsData txGasDetails = await Provider.addGas(tx: tx);
  tx = txGasDetails.tx;
  EtherAmount estimateGas = txGasDetails.estimateGas;
  EtherAmount maxFee = txGasDetails.maxFee;
  EtherAmount total = txGasDetails.total;
  EtherAmount maxAmount = txGasDetails.maxAmount;

  // Send transaction
  String sendTransaction = await Provider.sendTransaction(
    credentials: EthPrivateKey.fromHex(
      '0xe394b45f8ab120fbf238e356de30c14fdfa6ddf87b2c19253e161a850bfd03f7',
    ),
    tx: tx,
  );
}
