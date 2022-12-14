import 'package:walletika_sdk/src/core/core.dart';
import 'package:walletika_sdk/walletika_sdk.dart';
import 'package:test/test.dart';

import 'core/core.dart';

const debugging = true;
void printDebug(String message) {
  if (debugging) print(message);
}

void main() async {
  await walletikaSDKInitialize();

  final List<Map<String, dynamic>> wallets = walletsDataTest();
  final List<Map<String, dynamic>> tokens = tokensBSCTestnetDataTest();
  final List<Map<String, dynamic>> networks = networksDataTest();
  const int walletIndex = 0; // Username1
  const int tokenIndex = 2; // WTK Token
  const int networkIndex = 2; // BSC Testnet

  late WalletEngine walletEngine;
  late EthPrivateKey? credentials;

  late TokenData tokenData;
  late WalletikaTokenEngine tokenEngine;

  setUpAll(() async {
    bool isConnected = await Provider.connect(
      NetworkData.fromJson(networks[networkIndex]),
    );
    printDebug("${Provider.networkData.name} connection status: $isConnected");

    Map<String, dynamic> wallet = wallets[walletIndex];
    String username = wallet[DBKeys.username];
    String password = wallet[DBKeys.password];
    String securityPassword = wallet[DBKeys.securityPassword];
    String otpCode = getOTPCode(username, password, securityPassword);

    walletEngine = WalletEngine(
      await getWalletData(username, password, securityPassword),
    );
    await walletEngine.login(password: password, otpCode: otpCode);
    credentials = await walletEngine.credentials(otpCode);

    tokenData = TokenData.fromJson(tokens[tokenIndex]);
    tokenEngine = WalletikaTokenEngine(
      tokenData: tokenData,
      sender: walletEngine.address(),
    );
  });

  group("Token View Group:", () {
    test("Test (name)", () async {
      String name = await tokenEngine.name();

      printDebug("""
name: $name
        """);

      expect(name, isNotEmpty);
    });

    test("Test (symbol)", () async {
      String symbol = await tokenEngine.symbol();

      printDebug("""
symbol: $symbol
        """);

      expect(symbol, equals(tokenData.symbol));
    });

    test("Test (decimals)", () async {
      int decimals = await tokenEngine.decimals();

      printDebug("""
decimals: $decimals
        """);

      expect(decimals, equals(tokenData.decimals));
    });

    test("Test (totalSupply)", () async {
      EtherAmount totalSupply = await tokenEngine.totalSupply();

      printDebug("""
totalSupply: ${totalSupply.getValueInDecimals(tokenData.decimals)}
        """);

      expect(totalSupply.getInWei, greaterThanOrEqualTo(BigInt.zero));
    });

    test("Test (balanceOf)", () async {
      EtherAmount balance = await tokenEngine.balanceOf(
        address: walletEngine.address(),
      );

      printDebug("""
balance: ${balance.getValueInDecimals(tokenData.decimals)}
        """);

      expect(balance.getInWei, greaterThanOrEqualTo(BigInt.zero));
    });

    test("Test (allowance)", () async {
      EtherAmount allowance = await tokenEngine.allowance(
        owner: walletEngine.address(),
        spender: walletEngine.address(),
      );

      printDebug("""
allowance: ${allowance.getValueInDecimals(tokenData.decimals)}
        """);

      expect(allowance.getInWei, greaterThanOrEqualTo(BigInt.zero));
    });

    test("Test (owner)", () async {
      EthereumAddress owner = await tokenEngine.owner();

      printDebug("""
owner: ${owner.hexEip55}
        """);

      expect(
          owner.hexEip55,
          equals(
            '0x8AE5368C7F46572236a5B9dA4E0bf3924E16E60C',
          ));
    });

    test("Test (inflationRateAnnually)", () async {
      int inflationRateAnnually = await tokenEngine.inflationRateAnnually();

      printDebug("""
inflationRateAnnually: $inflationRateAnnually
        """);

      expect(inflationRateAnnually, equals(5));
    });

    test("Test (inflationDurationEndDate)", () async {
      DateTime inflationDurationEndDate =
          await tokenEngine.inflationDurationEndDate();

      printDebug("""
inflationDurationEndDate: ${inflationDurationEndDate.toString()}
        """);

      expect(
        inflationDurationEndDate.millisecondsSinceEpoch,
        greaterThanOrEqualTo(0),
      );
    });

    test("Test (availableToMintCurrentYear)", () async {
      EtherAmount availableToMintCurrentYear =
          await tokenEngine.availableToMintCurrentYear();

      printDebug("""
availableToMintCurrentYear: ${availableToMintCurrentYear.getValueInDecimals(
        tokenData.decimals,
      )}
        """);

      expect(
        availableToMintCurrentYear.getInWei,
        greaterThanOrEqualTo(BigInt.zero),
      );
    });
  });

  Future<void> sendTransaction(TxDetailsData txDetails) async {
    // Transaction details
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
      credentials: credentials!,
      tx: tx,
    );

    printDebug("""
username: ${walletEngine.username()}
address: ${walletEngine.address()}
abi: $abi
args: $args
data: $data
estimateGas: ${estimateGas.getValueInUnit(EtherUnit.ether)}
maxFee: ${maxFee.getValueInUnit(EtherUnit.ether)}
total: ${total.getValueInUnit(EtherUnit.ether)}
maxAmount: ${maxAmount.getValueInUnit(EtherUnit.ether)}
txURL: ${Provider.getExploreUrl(sendTransaction)}
        """);

    expect(tx.from, equals(walletEngine.address()));
    expect(tx.to, equals(tokenData.contract));
    expect(tx.value, equals(EtherAmount.zero()));
    expect(tx.data, isNotNull);
    expect(tx.nonce, greaterThan(0));
    expect(tx.maxGas, greaterThan(21000));
    if (tx.isEIP1559) {
      expect(tx.maxPriorityFeePerGas!.getInWei, greaterThan(BigInt.zero));
      expect(tx.maxFeePerGas!.getInWei, greaterThan(BigInt.zero));
    } else {
      expect(tx.gasPrice!.getInWei, greaterThan(BigInt.zero));
    }
    expect(abi, isNotEmpty);
    expect(args, isNotEmpty);
    expect(data, isNotEmpty);
    expect(estimateGas.getInWei, greaterThan(BigInt.zero));
    expect(maxFee.getInWei, greaterThanOrEqualTo(estimateGas.getInWei));
    expect(total.getInWei, greaterThan(BigInt.zero));
    expect(maxAmount.getInWei, greaterThanOrEqualTo(total.getInWei));
  }

  group("Token Transaction Group:", () {
    test("Test (transfer)", () async {
      EthereumAddress recipient = EthereumAddress.fromHex(
        '0x8AE5368C7F46572236a5B9dA4E0bf3924E16E60C',
      );
      EtherAmount amount = EtherAmount.fromUnitAndValue(
        EtherAmount.getUintDecimals(tokenData.decimals),
        0.1,
      );
      TxDetailsData txDetails = await tokenEngine.transfer(
        recipient: recipient,
        amount: amount,
      );

      expect(txDetails.args['recipient'], equals(recipient.hexEip55));
      expect(txDetails.args['amount'], equals(amount.getInWei.toString()));

      await sendTransaction(txDetails);
    });
  });
}
