package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.Phaser;
import farstar.weapons.exceptions.WeaponException;

public class Test16 extends LightCombat {

	public Test16(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getMass() {
		return 1;
	}

	public static void main(String[] args) throws WeaponException {
		Test16 t = new Test16("v1", 10, 20, 100, 2);
		t.equip(new Phaser(10, 10, 10));
	}

}
