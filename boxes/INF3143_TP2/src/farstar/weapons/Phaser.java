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
 * A Phaser inflict damages to a ship based only on its force.
 */
public class Phaser extends Weapon {

    public Phaser(Integer volume, Integer mass, Integer force) {
        super(volume, mass, force);
    }

    /**
     * Removes `force` to target hull.
     *
     * @param target
     * @return true always.
     */
    @Override
    public Boolean fire(Ship target) {
        if (target == null) {
            throw new IllegalArgumentException();
        }
        target.damage(getForce());
        return true;
    }

}
