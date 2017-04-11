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

import farstar.freight.Item;

/**
 * A ship that can go in space.
 *
 * Each ship is registered by a unique ID (see `getId()`).
 */
public interface Ship extends Item, Comparable<Ship> {

    /**
     * Unique ID of the Ship.
     *
     * @return the ship unique ID.
     */
    abstract public String getId();

    /**
     * Remaining hull damage resistance of this ship.
     *
     * @return the remaining hull resistance.
     */
    abstract public Integer getHull();

    /**
     * Is the ship destroyed?
     *
     * @return true if the hull == 0.
     */
    abstract public Boolean isDestroyed();

    /**
     * Damage the ship hull
     *
     * @param hull number of hull points to remove.
     * @return true if the ship is destroyed.
     */
    abstract public Boolean damage(Integer hull);

    /**
     * Get the mass of the empty ship
     *
     * @return the empty ship mass
     */
    public Integer getRawMass();
}
