/*
 * Copyright 2017 Alexandre Terrasa <alexandre@moz-code.org>.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package farstar.ships.interfaces;

import farstar.weapons.Weapon;
import farstar.weapons.exceptions.WeaponException;
import java.util.List;

/**
 * A ship that can equip weapons.
 *
 * The number of weapons that a ship can equip is limited by `getMaxWeapons()`.
 */
public interface CombatShip extends Ship {

    /**
     * Equip a weapon.
     *
     * @param weapon to equip.
     * @throws WeaponException (see subclasses).
     */
    public void equip(Weapon weapon) throws WeaponException;

    /**
     * Unequip a weapon.
     *
     * @param weapon to unequip.
     * @return true if the weapon has been unequipped
     */
    public Boolean unequip(Weapon weapon);

    /**
     * Get the ship equipped weapons.
     *
     * @return the list of weapons.
     */
    public List<Weapon> getWeapons();

    /**
     * Get the number a weapon this ship can equip.
     *
     * @return the maximum number of weapons.
     */
    public Integer getMaxWeapons();

    /**
     * Fire at target with all equipped weapons.
     *
     * @param target to fire at.
     * @return true if the ship was able to fire.
     */
    public Boolean fire(Ship target);

}
