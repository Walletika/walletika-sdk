import 'package:aesdatabase/aesdatabase.dart';
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

  group("AddressBook Storage Group:", () {
    test("Test (addNewAddressBook)", () async {
      for (Map<String, dynamic> wallet in wallets) {
        String address = wallet[DBKeys.address];
        String username = wallet[DBKeys.username];

        bool isAdded = await addNewAddressBook(
          username: username,
          address: EthereumAddress.fromHex(address),
        );

        printDebug("""
username: $username
isAdded: $isAdded
        """);

        expect(isAdded, isTrue);
      }
    });

    test("Test (getAllAddressesBook)", () async {
      List<AddressBookData> allAddressesBook = [
        await for (AddressBookData item in getAllAddressesBook()) item
      ];

      for (int index = 0; index < allAddressesBook.length; index++) {
        AddressBookData addressBookData = allAddressesBook[index];
        String address = addressBookData.address.hexEip55;
        String username = addressBookData.username;

        printDebug("""
address: $address
username: $username
        """);

        expect(address, equals(wallets[index][DBKeys.address]));
        expect(username, equals(wallets[index][DBKeys.username]));
      }

      expect(allAddressesBook.length, equals(wallets.length));
    });

    test("Test (removeAddressBook)", () async {
      List<AddressBookData> allAddressesBook = [
        await for (AddressBookData item in getAllAddressesBook()) item
      ];

      for (int index = 0; index < allAddressesBook.length; index++) {
        AddressBookData addressBookData = allAddressesBook[index];
        String username = addressBookData.username;

        bool isRemoved = await removeAddressBook(addressBookData);
        bool isExists = [
          await for (DBRow row in addressesBookDB.select(
            items: addressBookData.toJson(),
          ))
            row
        ].isNotEmpty;

        printDebug("""
username: $username
isRemoved: $isRemoved
isExists: $isExists
        """);

        expect(isRemoved, isTrue);
        expect(isExists, isFalse);
      }
    });
  });
}
