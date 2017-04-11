package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.exceptions.WeaponException;

public class Test24 extends LightCombat {

	public Test24(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}
	
	@Override
	public Boolean damage(Integer damages) {
		return true;
	}

	public static void main(String[] args) throws WeaponException {
		Test24 t = new Test24("v1", 10, 20, 100, 2);
		t.damage(50);
	}

}
