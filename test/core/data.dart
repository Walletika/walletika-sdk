import 'package:walletika_sdk/src/core/core.dart';

List<Map<String, dynamic>> walletsDataTest() {
  return [
    {
      DBKeys.address: '0xC94EA8D9694cfe25b94D977eEd4D60d7c0985BD3',
      DBKeys.username: 'username1',
      DBKeys.password: 'password1',
      DBKeys.securityPassword: '123456',
    },
    {
      DBKeys.address: '0xB41aD6b3EE5373dbAC2b471E4582A0b50f4bC9DE',
      DBKeys.username: 'username2',
      DBKeys.password: 'password2',
      DBKeys.securityPassword: '123457',
    },
    {
      DBKeys.address: '0xB72bEC2cB81F9B61321575D574BAC577BAb99141',
      DBKeys.username: 'username3',
      DBKeys.password: 'password3',
      DBKeys.securityPassword: '123458',
    },
    {
      DBKeys.address: '0x45EF6cc9f2aD7A85e282D14fc23C745727e547b6',
      DBKeys.username: 'username4',
      DBKeys.password: 'password4',
      DBKeys.securityPassword: '123459',
    },
    {
      DBKeys.address: '0x71471d05114c758eBfC3D3b952a722Ef2d53970b',
      DBKeys.username: 'username5',
      DBKeys.password: 'password5',
      DBKeys.securityPassword: '123460',
    },
  ];
}

List<Map<String, dynamic>> networksDataTest() {
  return [
    {
      DBKeys.rpc:
          "https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      DBKeys.name: "Ethereum",
      DBKeys.chainID: 1,
      DBKeys.symbol: "ETH",
      DBKeys.explorer: "https://etherscan.io",
    },
    {
      DBKeys.rpc: "https://bsc-dataseed1.binance.org",
      DBKeys.name: "Binance Smart Chain",
      DBKeys.chainID: 56,
      DBKeys.symbol: "BNB",
      DBKeys.explorer: "https://bscscan.com",
    },
    {
      DBKeys.rpc: "https://data-seed-prebsc-1-s1.binance.org:8545",
      DBKeys.name: "Binance Smart Chain (Testnet)",
      DBKeys.chainID: 97,
      DBKeys.symbol: "BNB",
      DBKeys.explorer: "https://testnet.bscscan.com",
    },
  ];
}

List<Map<String, dynamic>> tokensBSCTestnetDataTest() {
  return [
    {
      DBKeys.contract: '0x8cA86F6eE71Ee4B951279711341F051195B188F8',
      DBKeys.name: 'Tether',
      DBKeys.symbol: 'USDT',
      DBKeys.decimals: 6,
      DBKeys.website: '',
    },
    {
      DBKeys.contract: '0xCc0710d99467BE543e5d85f67A31cA674125659C',
      DBKeys.name: 'USD Coin',
      DBKeys.symbol: 'USDC',
      DBKeys.decimals: 18,
      DBKeys.website: '',
    },
    {
      DBKeys.contract: '0xc4d3716B65b9c4c6b69e4E260b37e0e476e28d87',
      DBKeys.name: 'Walletika',
      DBKeys.symbol: 'WTK',
      DBKeys.decimals: 18,
      DBKeys.website: '',
    },
  ];
}

List<Map<String, dynamic>> stakesBSCTestnetDataTest() {
  return [
    {
      DBKeys.rpc: 'https://data-seed-prebsc-1-s1.binance.org:8545',
      DBKeys.contract: '0xbfAa034b854703f31B34eCC1c68C356feeb19268',
      DBKeys.stakeToken: {
        DBKeys.contract: '0xc4d3716B65b9c4c6b69e4E260b37e0e476e28d87',
        DBKeys.name: 'Walletika',
        DBKeys.symbol: 'WTK',
        DBKeys.decimals: 18,
        DBKeys.website: '',
      },
      DBKeys.rewardToken: {
        DBKeys.contract: '0xc4d3716B65b9c4c6b69e4E260b37e0e476e28d87',
        DBKeys.name: 'Walletika',
        DBKeys.symbol: 'WTK',
        DBKeys.decimals: 18,
        DBKeys.website: '',
      },
      DBKeys.startBlock: 23545120,
      DBKeys.endBlock: 128636320,
      DBKeys.startTime: '2022-10-09 09:00:00',
      DBKeys.endTime: '2032-10-09 09:00:00',
    },
  ];
}

List<Map<String, dynamic>> transactionsBSCTestnetDataTest() {
  return [
    {
      DBKeys.txHash:
          '0x0999608c57697ff7a6051bbbc76f8fe7d2c552d1df7e0f0553d91798f722ec3f',
      DBKeys.function: 'transfer',
      DBKeys.fromAddress: '0x5c8CE2AaDA53a7c909e5e1ddf26Da19c32083E6D',
      DBKeys.toAddress: '0xD99D1c33F9fC3444f8101754aBC46c52416550D1',
      DBKeys.amount: '0',
      DBKeys.symbol: 'BNB',
      DBKeys.dateCreated: '2022-10-04 14:10:16.648948',
      DBKeys.status: 1,
    },
    {
      DBKeys.txHash:
          '0x4071ff1b7601ab547599fe059bfced11e7e00dff684bd99b146156e69da50b1d',
      DBKeys.function: 'transfer',
      DBKeys.fromAddress: '0x4f5d7100c48EE070caF6C8Ae940C125b23f12Fa4',
      DBKeys.toAddress: '0x8f7af74A269aD76cbd3B278A7E7080295819f161',
      DBKeys.amount: '0',
      DBKeys.symbol: 'BNB',
      DBKeys.dateCreated: '2022-10-04 14:10:16.648948',
      DBKeys.status: 1,
    },
    {
      DBKeys.txHash:
          '0x49158a8a258d9a6b264746f02e1387de6c4df4694b1f3637d6624de15844ee0b',
      DBKeys.function: 'transfer',
      DBKeys.fromAddress: '0x3f5ab9e22360921BE88e255C8a22b63B5E76dFf1',
      DBKeys.toAddress: '0xD99D1c33F9fC3444f8101754aBC46c52416550D1',
      DBKeys.amount: '1000000000000000000',
      DBKeys.symbol: 'BNB',
      DBKeys.dateCreated: '2022-10-04 14:10:16.648948',
      DBKeys.status: 1,
    },
    {
      DBKeys.txHash:
          '0x4b30e31aeced2c7e3ee65c02fc929bec5790d84d6d94077edce9bcd4d3a84b40',
      DBKeys.function: 'transfer',
      DBKeys.fromAddress: '0x47814C91626B0929c1A786846487eFdbA100846c',
      DBKeys.toAddress: '0x9027A1A724ffa5bcB1478E3AC994a706AFa7C2DE',
      DBKeys.amount: '1000000000000000000',
      DBKeys.symbol: 'BNB',
      DBKeys.dateCreated: '2022-10-04 14:10:16.648948',
      DBKeys.status: 1,
    },
  ];
}
