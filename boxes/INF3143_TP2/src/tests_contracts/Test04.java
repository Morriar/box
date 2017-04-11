package tests_contracts;

import farstar.ships.LightCombat;

public class Test04 extends LightCombat {

	public Test04(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getMass() {
		return 0;
	}

	public static void main(String[] args) {
		new Test04("v1", 10, 20, 100, 2);
	}

}
