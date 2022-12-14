import 'package:walletika_sdk/walletika_sdk.dart';
import 'package:web3dart/credentials.dart';

void main() async {
  String username = 'username';
  EthereumAddress address = EthereumAddress.fromHex(
    '0xC94EA8D9694cfe25b94D977eEd4D60d7c0985BD3',
  );

  // initialize walletika SDK
  await walletikaSDKInitialize();

  // Add new address book
  bool isAdded = await addNewAddressBook(username: username, address: address);

  // Get all addresses book
  List<AddressBookData> allAddressesBook = [
    await for (AddressBookData item in getAllAddressesBook()) item
  ];

  // Remove a address book
  bool isRemoved = await removeAddressBook(allAddressesBook[0]);
}
