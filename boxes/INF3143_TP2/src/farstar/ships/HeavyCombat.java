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

import farstar.freight.Item;
import farstar.ships.interfaces.CombatShip;
import farstar.ships.interfaces.Ship;
import farstar.weapons.Blaster;
import farstar.weapons.exceptions.MaxWeaponException;
import farstar.weapons.Weapon;
import farstar.weapons.exceptions.WeaponException;
import java.util.ArrayList;
import java.util.List;

/**
 * A heavy combat ship.
 */
public class HeavyCombat extends Speeder implements CombatShip {

    /**
     * The maximum weapons that can be equipped by this ship.
     */
    private Integer maxWeapons;

    /**
     * The list of weapons equipped by this ship.
     */
    private List<Weapon> weapons = new ArrayList<>();

    public HeavyCombat(String id, Integer volume, Integer mass, Integer hull, Integer maxWeapons) {
        super(id, volume, mass, hull);
        if (maxWeapons <= 0) {
            throw new IllegalArgumentException();
        }
        this.maxWeapons = maxWeapons;
    }

    /**
     * Equip a weapon
     *
     * @param weapon to equip.
     * @throws MaxWeaponException if the ship already has its maximum number of weapons.
     */
    @Override
    public void equip(Weapon weapon) throws WeaponException {
        if (weapon == null) {
            throw new IllegalArgumentException();
        }
        if (getWeapons().size() >= getMaxWeapons()) {
            throw new MaxWeaponException();
        }
        weapons.add(weapon);
    }

    @Override
    public Boolean unequip(Weapon weapon) {
        return weapons.remove(weapon);
    }

    /**
     * The mass of the ship + the mass of all its equipped weapons.
     *
     * @return the ship computed mass.
     */
    @Override
    public Integer getMass() {
        return super.getMass() + getWeaponsMass();
    }

    @Override
    public List<Weapon> getWeapons() {
        return weapons;
    }

    /**
     * The mass of all the equipped weapons.
     *
     * @return the weapons computed mass.
     */
    public Integer getWeaponsMass() {
        Integer mass = 0;
        for (Item item : weapons) {
            mass += item.getMass();
        }
        return mass;
    }

    /**
     * The list of blaster equipped by the ship.
     *
     * @return the list of blasters.
     */
    public List<Blaster> getBlasters() {
        List<Blaster> blasters = new ArrayList<>();
        for (Weapon weapon : weapons) {
            if (weapon instanceof Blaster) {
                blasters.add((Blaster) weapon);
            }
        }
        return blasters;
    }

    @Override
    public Integer getMaxWeapons() {
        return maxWeapons;
    }

    @Override
    public Boolean fire(Ship target) {
        Boolean fired = false;
        for(Weapon weapon : getWeapons()) {
            if(weapon.fire(target)) {
                fired = true;
            }
        }
        return fired;
    }

    @Override
    public String toString() {
        return getId() + " (v: " + getVolume() + ", m: " + getMass() + ", wp: " + (getWeapons().size() - getBlasters().size()) + ", wb: " + getBlasters().size() + ")";
    }

}
