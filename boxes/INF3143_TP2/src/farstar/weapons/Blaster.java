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

import farstar.ships.interfaces.Ship;

/**
 * A Blaster inflict damages to a ship hull only if it has enough gas.
 */
public class Blaster extends Weapon {

    /**
     * Gas quantity (over 100%).
     */
    private Integer gas;

    /**
     * Create a new Blaster.
     *
     * @param volume
     * @param mass
     * @param force
     * @param gas the gas quantity.
     */
    public Blaster(Integer volume, Integer mass, Integer force, Integer gas) {
        super(volume, mass, force);
        if (gas < 0) {
            throw new IllegalArgumentException();
        }
        this.gas = gas;
    }

    /**
     * The blaster can inflict damages only if it has enough gas.
     *
     * To fire, the blaster need a least `force` gas. After firing: * the
     * blaster loose `force` gas. * the target loose `force` hull.
     *
     * @param target the ship to fire to.
     * @return true if the blaster fired (enough gas).
     */
    @Override
    public Boolean fire(Ship target) {
        if (gas < getForce()) {
            return false;
        }
        if (target == null) {
            throw new IllegalArgumentException();
        }
        target.damage(getForce());
        gas -= getForce();
        return true;
    }

    /**
     * Replenish weapon gas.
     *
     * The maximum is 100.
     *
     * @param gas quantity of gas to add.
     */
    public void reload(Integer gas) {
        if (gas <= 0) {
            throw new IllegalArgumentException();
        }
        this.gas += gas;
        if (this.gas > 100) {
            this.gas = 100;
        }
    }

    public Integer getGas() {
        return gas;
    }

}
