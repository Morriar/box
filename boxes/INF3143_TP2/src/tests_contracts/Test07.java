package tests_contracts;

import farstar.ships.LightCombat;

public class Test07 extends LightCombat {

	public Test07(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getHull() {
		return 10000;
	}

	public static void main(String[] args) {
		new Test07("v1", 10, 20, 100, 2);
	}

}
