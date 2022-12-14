import 'package:walletika_sdk/src/engine/stake.dart';

import 'core/core.dart';

Future<void> walletikaSDKInitialize({
  String? encryptionKey,
  String directory = "assets",
}) async {
  // Database loading
  walletsDB = await databaseLoader(
    directory: directory,
    filename: "wallets",
    columnTitles: [
      DBKeys.username,
      DBKeys.address,
      DBKeys.securityPassword,
      DBKeys.dateCreated,
      DBKeys.isFavorite,
    ],
    hasBackup: true,
    key: encryptionKey,
  );

  addressesBookDB = await databaseLoader(
    directory: directory,
    filename: "addressesbook",
    columnTitles: [
      DBKeys.username,
      DBKeys.address,
    ],
    key: encryptionKey,
  );

  networksDB = await databaseLoader(
    directory: directory,
    filename: "networks",
    columnTitles: [
      DBKeys.rpc,
      DBKeys.name,
      DBKeys.chainID,
      DBKeys.symbol,
      DBKeys.explorer,
    ],
    key: encryptionKey,
  );

  tokensDB = await databaseLoader(
    directory: directory,
    filename: "tokens",
    columnTitles: [
      DBKeys.address,
      DBKeys.rpc,
      DBKeys.contract,
      DBKeys.name,
      DBKeys.symbol,
      DBKeys.decimals,
      DBKeys.website,
    ],
    key: encryptionKey,
  );

  transactionsDB = await databaseLoader(
    directory: directory,
    filename: "transactions",
    columnTitles: [
      DBKeys.address,
      DBKeys.rpc,
      DBKeys.txHash,
      DBKeys.function,
      DBKeys.fromAddress,
      DBKeys.toAddress,
      DBKeys.amount,
      DBKeys.symbol,
      DBKeys.dateCreated,
      DBKeys.status,
    ],
    key: encryptionKey,
  );

  stakeDB = await databaseLoader(
    directory: directory,
    filename: "stakecontracts",
    columnTitles: [
      DBKeys.rpc,
      DBKeys.contract,
      DBKeys.stakeToken,
      DBKeys.rewardToken,
      DBKeys.startBlock,
      DBKeys.endBlock,
      DBKeys.startTime,
      DBKeys.endTime,
    ],
    key: encryptionKey,
  );

  // Stake contracts Fetching
  await importStakeContracts(
    'https://raw.githubusercontent.com/Walletika/metadata/main/stake-contracts.json',
  );
}
