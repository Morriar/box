package tests_contracts;

import farstar.ships.LightCombat;
import farstar.weapons.Phaser;
import farstar.weapons.exceptions.WeaponException;

public class Test13 extends LightCombat {

	public Test13(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	public static void main(String[] args) throws WeaponException {
		Test13 t = new Test13("v1", 10, 20, 100, 2);
		t.equip(new Phaser(10, 10, 10));
		t.equip(new Phaser(10, 10, 10));
		t.equip(new Phaser(10, 10, 10));
	}

}
