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

import farstar.freight.exceptions.FreightException;
import farstar.freight.Item;
import java.util.List;

/**
 * A ship that can transport freight.
 *
 * A transport ship can load items for transportation. Each transport ship has a
 * limited volume and mass capacity.
 */
public interface TransportShip extends Ship {

    /**
     * Load an item into this ship.
     *
     * @param item the item to load.
     * @throws FreightException if the client try to load an item that exceeds
     * the ship max volume or mass.
     */
    public void load(Item item) throws FreightException;

    /**
     * Unload an item from this ship.
     *
     * @param item the item to unload.
     * @return true if the item has been unloaded.
     */
    public Boolean unload(Item item);

    /**
     * Does this transporter contains the item?
     * @param item the item to look for.
     * @return true if this or one of its contained ship contains the item.
     */
    public Boolean contains(Item item);

    /**
     * The list of items contained by this ship.
     *
     * @return the list of loaded items.
     */
    public List<Item> getItems();

    /**
     * Get this ship max volume.
     *
     * @return the ship max volume.
     */
    public Integer getMaxVolume();

    /**
     * Get this ship max mass.
     *
     * @return the ship max mass.
     */
    public Integer getMaxMass();
}
