package tests_contracts;

import farstar.ships.LightCombat;

public class Test09 extends LightCombat {

	public Test09(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getHull() {
		return 0;
	}
	
	@Override
	public Boolean isDestroyed() {
		return false;
	}

	public static void main(String[] args) {
		new Test09("v1", 10, 20, 100, 2);
	}

}
