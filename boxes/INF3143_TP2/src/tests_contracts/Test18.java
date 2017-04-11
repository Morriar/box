package tests_contracts;

import farstar.ships.LightCombat;
import farstar.ships.interfaces.Ship;
import farstar.weapons.exceptions.WeaponException;

public class Test18 extends LightCombat {

	public Test18(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
    public Boolean fire(Ship target) {
        return true;
    }


	public static void main(String[] args) throws WeaponException {
		Test18 t = new Test18("v1", 10, 20, 100, 2);
		t.fire(null);
	}

}
