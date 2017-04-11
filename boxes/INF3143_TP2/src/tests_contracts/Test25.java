package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.exceptions.WeaponException;

public class Test25 extends LightCombat {

	public Test25(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	public static void main(String[] args) throws WeaponException {
		Test25 t = new Test25("v1", 10, 20, 100, 2);
		t.damage(50);
	}

}
