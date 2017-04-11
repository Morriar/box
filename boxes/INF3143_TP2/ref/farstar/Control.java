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
package farstar;

import farstar.ships.interfaces.Ship;
import farstar.ships.interfaces.TransportShip;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Control {

    private Map<String, Ship> ships = new HashMap<>();

    public Boolean registerShip(Ship ship) {
        if (ships.containsKey(ship.getId())) {
            return false;
        }
        ships.put(ship.getId(), ship);
        return true;
    }

    public Ship getShip(String id) {
        return ships.get(id);
    }

    public List<Ship> getShips() {
        List<Ship> ships = new ArrayList<>(this.ships.values());
        Collections.sort(ships);
        return ships;
    }

    public List<TransportShip> getTransportShips() {
        List<TransportShip> ships = new ArrayList<>();
        for (Ship ship : getShips()) {
            if (!(ship instanceof TransportShip)) {
                continue;
            }
            ships.add((TransportShip) ship);
        }
        return ships;
    }

    public String locate(String id) {
        Ship ship = getShip(id);
        if(ship == null) {
            return "unknown";
        }
        TransportShip transporter = null;
        for(TransportShip tship : getTransportShips()) {
            if(tship.contains(ship)) {
                if(transporter == null) {
                    transporter = tship;
                } else {
                    if(transporter.contains(tship)) {
                        transporter = tship;
                    }
                }
            }
        }
        if(transporter != null) {
            return "in " + transporter.getId();
        }
        return "in space";
    }

}
