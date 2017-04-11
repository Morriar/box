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

import farstar.freight.exceptions.FreightException;
import farstar.freight.Item;
import farstar.freight.exceptions.MassException;
import farstar.freight.exceptions.VolumeException;
import farstar.ships.interfaces.TransportShip;
import java.util.ArrayList;
import java.util.List;

/**
 * A ship that can transport items.
 *
 * A transport ship is limited by its maxVolume and maxMass capacity.
 */
public class Transporter extends Speeder implements TransportShip {

    /**
     * The maximum volume capacity of the ship.
     */
    private Integer maxVolume;

    /**
     * The maximum mass capacity of the ship.
     */
    private Integer maxMass;

    private List<Item> items = new ArrayList<>();

    public Transporter(String id, Integer volume, Integer mass, Integer hull, Integer maxVolume, Integer maxMass) {
        super(id, volume, mass, hull);
        if (maxVolume <= 0 || maxMass <= 0) {
            throw new IllegalArgumentException();
        }
        this.maxVolume = maxVolume;
        this.maxMass = maxMass;
    }

    @Override
    public void load(Item item) throws FreightException {
        if (item == null) {
            throw new IllegalArgumentException();
        }
        if (getItemsVolume() + item.getVolume() > this.getMaxVolume()) {
            throw new VolumeException();
        }
        if (getItemsMass() + item.getMass() > this.getMaxMass()) {
            throw new MassException();
        }
        items.add(item);
    }

    @Override
    public Boolean unload(Item item) {
        return items.remove(item);
    }

    @Override
    public Boolean contains(Item item) {
        if (getItems().contains(item)) {
            return true;
        }
        for (Item sitem : getItems()) {
            if (!(sitem instanceof TransportShip)) {
                continue;
            }
            if (((TransportShip) sitem).contains(item)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public Integer getVolume() {
        return super.getVolume();
    }

    /**
     * The total volume of all the loaded items.
     *
     * @return the items volume.
     */
    public Integer getItemsVolume() {
        Integer volume = 0;
        for (Item item : items) {
            volume += item.getVolume();
        }
        return volume;
    }

    @Override
    public Integer getMass() {
        return super.getMass() + getItemsMass();
    }

    /**
     * The total mass of the items.
     *
     * @return the items mass.
     */
    public Integer getItemsMass() {
        Integer mass = 0;
        for (Item item : items) {
            mass += item.getMass();
        }
        return mass;
    }

    @Override
    public List<Item> getItems() {
        return items;
    }

    @Override
    public Integer getMaxVolume() {
        return maxVolume;
    }

    @Override
    public Integer getMaxMass() {
        return maxMass;
    }

    @Override
    public String toString() {
        return getId() + " (v: " + getVolume() + ", m: " + getMass() + ", i: " + getItems().size() + ")";
    }

}
