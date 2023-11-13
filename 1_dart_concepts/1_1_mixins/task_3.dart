/// Object equipable by a [Character].
abstract class Item {}

/// Mixin for weapons, providing damage property.
mixin Weapon on Item {
  int get damage;
}

/// Mixin for armor, providing defense property.
mixin Armor on Item {
  int get defense;
}

/// Entity equipping [Item]s.
class Character {
  Item? leftHand;
  Item? rightHand;
  Item? hat;
  Item? torso;
  Item? legs;
  Item? shoes;

  /// Returns all the [Item]s equipped by this [Character].
  Iterable<Item> get equipped =>
      [leftHand, rightHand, hat, torso, legs, shoes].whereType<Item>();

  /// Returns the total damage of this [Character].
  int get damage {
    return equipped.whereType<Weapon>().map((weapon) => weapon.damage).fold(0, (a, b) => a + b);
  }

  /// Returns the total defense of this [Character].
  int get defense {
    return equipped.whereType<Armor>().map((armor) => armor.defense).fold(0, (a, b) => a + b);
  }

  /// Equips the provided [item], meaning putting it to the corresponding slot.
  ///
  /// If there's already a slot occupied, then throws a [OverflowException].
  void equip(Item item) {
    if (item is Weapon && (leftHand == null || rightHand == null)) {
      if (leftHand == null) {
        leftHand = item;
      } else {
        rightHand = item;
      }
    } else if (item is Armor) {
      switch (item.runtimeType) {
        case Hat:
          hat = item;
          break;
        case Torso:
          torso = item;
          break;
        case Legs:
          legs = item;
          break;
        case Shoes:
          shoes = item;
          break;
      }
    } else {
      throw OverflowException();
    }
  }
}

/// [Exception] indicating there's no place left in the [Character]'s slot.
class OverflowException implements Exception {
   @override
  String toString() => 'No place left in the Character\'s slot.';
}

/// Example classes implementing the mixins
class Sword extends Item with Weapon {
  @override
  int get damage => 10;
}

class Helmet extends Item with Armor {
  @override
  int get defense => 5;
}

class Hat extends Item with Armor {
  @override
  int get defense => 2;
}

class Torso extends Item with Armor {
  @override
  int get defense => 8;
}

class Legs extends Item with Armor {
  @override
  int get defense => 7;
}

class Shoes extends Item with Armor {
  @override
  int get defense => 3;
}

void main() {
  final character = Character();
  final sword = Sword();
  final helmet = Helmet();
  final hat = Hat();
  final torso = Torso();
  final legs = Legs();
  final shoes = Shoes();

  character.equip(sword);
  character.equip(helmet);
  character.equip(hat);
  character.equip(torso);
  character.equip(legs);
  character.equip(shoes);

  print('Total damage: ${character.damage}');
  print('Total defense: ${character.defense}');
}
