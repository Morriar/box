package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.exceptions.WeaponException;

public class Test11 extends LightCombat {

	public Test11(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	public static void main(String[] args) throws WeaponException {
		Test11 t = new Test11("v1", 10, 20, 100, 2);
		t.equip(null);
	}

}
