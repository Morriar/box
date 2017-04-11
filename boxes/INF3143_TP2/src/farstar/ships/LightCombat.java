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
package farstar.ships;

import farstar.ships.interfaces.Ship;
import farstar.weapons.exceptions.IllegalWeaponException;
import farstar.weapons.Phaser;
import farstar.weapons.Weapon;
import farstar.weapons.exceptions.WeaponException;

/**
 * A light combat ship.
 */
public class LightCombat extends HeavyCombat {

    public LightCombat(String id, Integer volume, Integer mass, Integer hull, Integer maxWeapons) {
        super(id, volume, mass, hull, maxWeapons);
    }

    /**
     * A light combat ship can only equip phasers.
     *
     * @param weapon the weapon to equip.
     * @throws WeaponException if the weapon is not a phaser.
     */
    @Override
    public void equip(Weapon weapon) throws WeaponException {
        if (weapon == null) {
            throw new IllegalArgumentException();
        }
        if (!(weapon instanceof Phaser)) {
            throw new IllegalWeaponException();
        }
        super.equip(weapon);
    }

    @Override
    public Integer getMass() {
        return super.getMass();
    }

    @Override
    public Boolean fire(Ship target) {
        return super.fire(target);
    }

    @Override
    public Boolean damage(Integer hull) {
        return super.damage(hull);
    }

    @Override
    public String toString() {
        return getId() + " (v: " + getVolume() + ", m: " + getMass() + ", wp: " + getWeapons().size() + ")";
    }

}
