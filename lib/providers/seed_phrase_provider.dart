import 'dart:math';
import 'package:flutter/material.dart';

import '../models/seed_phrase.dart';
import 'package:bip39/bip39.dart' as bip39;

class SeedPhraseProvider extends ChangeNotifier {
  seedPhrase1() {
    _seedphrase = bip39.generateMnemonic();
    notifyListeners();
  }

  init(String value) async {
    _phrases = SeedPhrase(status: true, mnemonic: value);
    _phrasesList.addAll(_phrases!.mnemonic.split(' '));
    Random random = Random();
    _firstIndex = random.nextInt(12);
    do {
      _secondIndex = random.nextInt(12);
    } while (_secondIndex == _firstIndex);
    do {
      _thirdIndex = random.nextInt(12);
    } while (_thirdIndex == _secondIndex || _thirdIndex == _firstIndex);
    _firstWord = _phrasesList[_firstIndex];
    _secondWord = _phrasesList[_secondIndex];
    _thirdWord = _phrasesList[_thirdIndex];
    print(
      '$_firstIndex : $_firstWord , $_secondIndex : $_secondWord , $_thirdIndex : $_thirdWord',
    );
  }

  SeedPhrase? _phrases;
  final List<String> _phrasesList = <String>[];
  late int _firstIndex;
  late int _secondIndex;
  late int _thirdIndex;
  late String _firstWord;
  String _seedphrase = 'asd asd asd asd asd asd asd asd asd asd asd asd';
  late String _secondWord;
  late String _thirdWord;
  String get seedphrase => _seedphrase;
  List<String> get phraselist => _phrasesList;
  String get phrase => _phrases!.mnemonic;

  String get firstWord => _firstWord;
  String get secondWord => _secondWord;
  String get thirdWord => _thirdWord;

  int get firstIndex => _firstIndex;
  int get secondIndex => _secondIndex;
  int get thirdIndex => _thirdIndex;

  List<String> hintForFirstPhrase() {
    List<String> temp = <String>[];
    temp.add(_firstWord);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      if (!temp.contains(_phrasesList[index])) {
        temp.add(_phrasesList[index]);
      }
    }
    temp.shuffle();
    return temp;
  }

  List<String> hintForSecondPhrase() {
    List<String> temp = <String>[];
    temp.add(_secondWord);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      if (!temp.contains(_phrasesList[index])) {
        temp.add(_phrasesList[index]);
      }
    }
    temp.shuffle();
    return temp;
  }

  List<String> hintForThirdPhrase() {
    List<String> temp = <String>[];
    temp.add(_thirdWord);
    while (temp.length < 6) {
      final int index = Random().nextInt(12);
      if (!temp.contains(_phrasesList[index])) {
        temp.add(_phrasesList[index]);
      }
    }
    temp.shuffle();
    return temp;
  }
}
