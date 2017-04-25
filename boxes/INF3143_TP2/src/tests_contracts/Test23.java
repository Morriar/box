package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.exceptions.WeaponException;

public class Test23 extends LightCombat {

	public Test23(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	public static void main(String[] args) throws WeaponException {
		Test23 t = new Test23("v1", 10, 20, 100, 2);
		t.damage(0);
	}

}
