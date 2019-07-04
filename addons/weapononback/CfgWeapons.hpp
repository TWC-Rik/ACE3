class CfgWeapons {
    class ACE_FakePrimaryWeapon;
    class GVAR(weapon): ACE_FakePrimaryWeapon {
        picture = "\A3\Weapons_F\Data\clear_empty.paa";
        displayName = CSTRING(FakeWeaponDisplayName);
        type = TYPE_WEAPON_SECONDARY;
        class WeaponSlotsInfo {
            mass = 1;
        };
    };
};
