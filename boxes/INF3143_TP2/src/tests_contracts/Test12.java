package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.Blaster;
import farstar.weapons.exceptions.WeaponException;

public class Test12 extends LightCombat {

	public Test12(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	public static void main(String[] args) throws WeaponException {
		Test12 t = new Test12("v1", 10, 20, 100, 2);
		t.equip(new Blaster(10, 10, 10, 10));
	}

}
