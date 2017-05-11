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

import com.google.java.contract.Ensures;
import com.google.java.contract.Invariant;
import com.google.java.contract.Requires;

import farstar.ships.interfaces.Ship;
import farstar.weapons.exceptions.IllegalWeaponException;
import farstar.weapons.Phaser;
import farstar.weapons.Weapon;
import farstar.weapons.exceptions.WeaponException;

/**
 * A light combat ship.
 */
@Invariant({"getId() != null && !getId().isEmpty()",
    "getVolume() > 0 && getMass() > 0 && getMaxWeapons() > 0",
    "getHull() >= 0 && getHull() <= 100",
    "isDestroyed() == (getHull() == 0)"})
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
    @Requires({"weapon != null", "weapon instanceof farstar.weapons.Phaser",
        "getWeapons().size() < getMaxWeapons()"})
    @Ensures({"getWeapons().contains(weapon)",
        "getWeapons().size() == old(getWeapons().size()) + 1",
        "getMass() == old(getMass()) + weapon.getMass()"})
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

    @Ensures("result == getRawMass() + getWeaponsMass()")
    @Override
    public Integer getMass() {
        return super.getMass();
    }

    @Requires({"target != null", "target != this", "!getWeapons().isEmpty()"})
    @Ensures({"result"}) // We are guaranted that `target != null` by the requires
    @Override
    public Boolean fire(Ship target) {
        return super.fire(target);
    }

    @Requires("hull > 0")
    @Ensures("getHull() == old(getHull()) - hull")
    @Override
    public Boolean damage(Integer hull) {
        return super.damage(hull);
    }

    @Override
    public String toString() {
        return getId() + " (v: " + getVolume() + ", m: " + getMass() + ", wp: " + getWeapons().size() + ")";
    }

}
