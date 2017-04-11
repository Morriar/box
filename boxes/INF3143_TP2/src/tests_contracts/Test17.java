package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.exceptions.WeaponException;

public class Test17 extends LightCombat {

	public Test17(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getMass() {
		return 1;
	}

	public static void main(String[] args) throws WeaponException {
		Test17 t = new Test17("v1", 10, 20, 100, 2);
		t.getMass();
	}

}
