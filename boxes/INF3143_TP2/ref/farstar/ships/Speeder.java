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

/**
 * Space speeder.
 *
 * A basic spaceship.
 */
public class Speeder implements Ship {

    /**
     * The ship id.
     */
    private String id;

    /**
     * The ship volume.
     */
    private Integer volume;

    /**
     * The ship mass.
     */
    private Integer mass;

    /**
     * The mass of the empty ship.
     */
    private Integer rawMass;

    /**
     * The ship remaining hull.
     *
     * When the hull reaches 0, the ship is destroyed.
     */
    private Integer hull;

    public Speeder(String id, Integer volume, Integer mass, Integer hull) {
        if (id == null || id.length() == 0) {
            throw new IllegalArgumentException();
        }
        if (volume <= 0 || mass <= 0 || hull < 0) {
            throw new IllegalArgumentException();
        }
        this.id = id;
        this.volume = volume;
        this.mass = mass;
        this.rawMass = mass;
        this.hull = hull;
    }

    @Override
    public String getId() {
        return id;
    }

    @Override
    public Integer getVolume() {
        return volume;
    }

    @Override
    public Integer getMass() {
        return mass;
    }

    @Override
    public Integer getRawMass() {
        return rawMass;
    }

    @Override
    public Integer getHull() {
        return hull;
    }

    @Override
    public Boolean isDestroyed() {
        return hull == 0;
    }

    @Override
    public Boolean damage(Integer hull) {
        if(hull <= 0) {
            throw new IllegalArgumentException();
        }
        this.hull -= hull;
        if(this.hull < 0) {
            this.hull = 0;
        }
        return isDestroyed();
    }

    @Override
    public int compareTo(Ship t) {
        return getId().compareTo(((Ship) t).getId());
    }

    @Override
    public String toString() {
        return getId() + " (v: " + getVolume() + ", m: " + getMass() + ")";
    }

}
