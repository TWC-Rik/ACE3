#include "script_component.hpp"
/*
 * Author: BaerMitUmlaut
 * Swaps primary and weapon on back. Can handle no primary or no weapon on back.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

private _weaponHolder = ACE_player getVariable [QGVAR(weaponHolder), objNull];
private _oldPrimary = (getUnitLoadout ACE_player)#0;
private _newPrimary = (weaponsItemsCargo _weaponHolder) param [0, []];

ACE_player removeWeapon (_oldPrimary param [0, ""]);
private _loadout = getUnitLoadout ACE_player;
_loadout set [0, _newPrimary];
ACE_player setUnitLoadout _loadout;

if (_oldPrimary isEqualTo []) then {
    [ACE_player] call FUNC(remove);
} else {
    [ACE_player, _oldPrimary] call FUNC(add);
};
