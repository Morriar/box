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
package farstar.weapons;

import farstar.freight.Item;
import farstar.ships.interfaces.Ship;

/**
 * A weapon can inflict damages to a ship hull.
 *
 * Damages depend on the weapon force.
 */
abstract public class Weapon implements Item {

    /**
     * The weapon volume.
     */
    private Integer volume;

    /**
     * The weapon mass.
     */
    private Integer mass;

    /**
     * The weapon force.
     *
     * Used to compute the weapon inflicted damages.
     */
    private Integer force;

    /**
     * Create a new Weapon.
     *
     * @param volume the weapon volume.
     * @param mass the weapon mass.
     * @param force the weapon force.
     */
    public Weapon(Integer volume, Integer mass, Integer force) {
        if (volume <= 0 || mass <= 0 || force <= 0) {
            throw new IllegalArgumentException();
        }
        this.volume = volume;
        this.mass = mass;
        this.force = force;
    }

    /**
     * Fire at the targeted ship.
     *
     * @param target the ship to fire to.
     * @return true if the weapon inflicted damages.
     */
    abstract public Boolean fire(Ship target);

    @Override
    public Integer getVolume() {
        return volume;
    }

    @Override
    public Integer getMass() {
        return mass;
    }

    public Integer getForce() {
        return force;
    }

}
