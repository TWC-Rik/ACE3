#include "script_component.hpp"

["weapon", FUNC(onWeaponChange)] call CBA_fnc_addPlayerEventHandler;

["unit", {
    params ["_newUnit", "_oldUnit"];

    private _inventoryEHs = _oldUnit getVariable [QGVAR(inventoryEHs), []];
    { _oldUnit removeEventHandler _x } forEach _inventoryEHs;

    _inventoryEHs = [
        _newUnit addEventHandler ["InventoryOpened", {
            params ["", "_fst", "_snd"];

            if (isNull _snd) then {
                _snd = _fst;
            };
            GVAR(openedContainers) = [_fst, _snd];
        }],
        _newUnit addEventHandler ["InventoryClosed", {
            GVAR(openedContainers) = [objNull, objNull];
        }]
    ];

    _newUnit setVariable [QGVAR(inventoryEHs), _inventoryEHs];
}, true] call CBA_fnc_addPlayerEventHandler;

["loadout", {
    // One frame delay, because dropping from inventory isn't instant but still handled by us
    // See also fnc_onDragWOB
    [{
        private _hasWeaponHolder = !isNull (ACE_player getVariable [QGVAR(weaponHolder), objNull]);
        private _hasFakeWeapon = secondaryWeapon ACE_player == QGVAR(weapon);

        if !(_hasWeaponHolder isEqualTo _hasFakeWeapon) then {
            [ACE_player] call FUNC(remove);
        };
    }] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addPlayerEventHandler;
