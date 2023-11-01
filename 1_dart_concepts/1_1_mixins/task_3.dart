/// Object equipable by a [Character].
abstract class Item {}

/// Mixin for [Item], representing a weapon.
mixin Weapon on Item {
  int get damage;
}

/// Mixin for [Item], representing armor.
mixin Armor on Item {
  int get defense;
}

/// [Item] representing a sword.
class Sword extends Item with Weapon {
  @override
  int get damage => 10;
}

/// [Item] representing a shield.
class Shield extends Item with Armor {
  @override
  int get defense => 5;
}

/// Enum representing character slots.
enum CharacterSlot {
  leftHand,
  rightHand,
  hat,
  torso,
  legs,
  shoes,
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
    return equipped.whereType<Weapon>().map((item) => item.damage).fold(0, (a, b) => a + b);
  }

  /// Returns the total defense of this [Character].
  int get defense {
    return equipped.whereType<Armor>().map((item) => item.defense).fold(0, (a, b) => a + b);
  }

  /// Equips the provided [item], putting it in the corresponding slot.
  ///
  /// If the slot is already occupied, throws an [OverflowException].
  void equip(Item item, CharacterSlot slot) {
    switch (slot) {
      case CharacterSlot.leftHand:
        if (leftHand != null) throw OverflowException();
        leftHand = item;
        break;
      case CharacterSlot.rightHand:
        if (rightHand != null) throw OverflowException();
        rightHand = item;
        break;
      case CharacterSlot.hat:
        if (hat != null) throw OverflowException();
        hat = item;
        break;
      case CharacterSlot.torso:
        if (torso != null) throw OverflowException();
        torso = item;
        break;
      case CharacterSlot.legs:
        if (legs != null) throw OverflowException();
        legs = item;
        break;
      case CharacterSlot.shoes:
        if (shoes != null) throw OverflowException();
        shoes = item;
        break;
    }
  }
}

/// [Exception] indicating there's no place left in the [Character]'s slot.
class OverflowException implements Exception {}

void main() {
  final sword = Sword();
  final shield = Shield();
  final character = Character();

  try {
    character.equip(sword, CharacterSlot.leftHand);
    character.equip(shield, CharacterSlot.leftHand); // This will throw OverflowException.
  } catch (e) {
    print('Error: $e');
  }

  print('Total Damage: ${character.damage}');
  print('Total Defense: ${character.defense}');
}
