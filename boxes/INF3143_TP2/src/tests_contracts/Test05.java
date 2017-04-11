package tests_contracts;

import farstar.ships.LightCombat;

public class Test05 extends LightCombat {

	public Test05(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getMaxWeapons() {
		return 0;
	}

	public static void main(String[] args) {
		new Test05("v1", 10, 20, 100, 2);
	}

}
