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

import farstar.freight.Container;
import farstar.freight.exceptions.FreightException;
import farstar.ships.interfaces.CombatShip;
import farstar.ships.interfaces.TransportShip;
import farstar.ships.HeavyCombat;
import farstar.ships.LightCombat;
import farstar.ships.Transporter;
import farstar.ships.interfaces.Ship;
import farstar.weapons.Phaser;
import farstar.weapons.Blaster;
import farstar.weapons.exceptions.WeaponException;

public class Main {

    public static void main(String[] args) throws WeaponException, FreightException {
        CombatShip cs1 = new LightCombat("C01", 10, 20, 100, 2);
        cs1.equip(new Phaser(1, 1, 3));
        cs1.equip(new Phaser(1, 1, 3));

        CombatShip cs2 = new HeavyCombat("C02", 30, 60, 100, 5);
        cs2.equip(new Phaser(1, 1, 3));
        cs2.equip(new Phaser(1, 1, 3));
        cs2.equip(new Blaster(5, 5, 6, 50));
        cs2.equip(new Blaster(5, 5, 6, 50));

        TransportShip ts1 = new Transporter("T01", 110, 220, 100, 80, 150);
        ts1.load(new Container(1, 1));
        ts1.load(new Container(1, 1));
        ts1.load(new Container(1, 1));
        ts1.load(new Container(1, 1));
        ts1.load(new Container(1, 1));
        ts1.load(cs1);
        ts1.load(cs2);

        TransportShip ts2 = new Transporter("T02", 500, 1000, 100, 450, 800);
        ts2.load(ts1);

        Control control = new Control();
        control.registerShip(cs1);
        control.registerShip(cs2);
        control.registerShip(ts1);
        control.registerShip(ts2);

        System.out.println("Registered ships: ");
        for (Ship ship : control.getShips()) {
            System.out.println(" * " + ship + " " + control.locate(ship.getId()));
        }
    }
}
