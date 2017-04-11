package tests_contracts;

import farstar.ships.LightCombat;

public class Test10 extends LightCombat {

	public Test10(String id, Integer volume, Integer mass, Integer hull,
			Integer maxWeapons) {
		super(id, volume, mass, hull, maxWeapons);
	}

	@Override
	public Integer getHull() {
		return 1;
	}
	
	@Override
	public Boolean isDestroyed() {
		return false;
	}

	public static void main(String[] args) {
		new Test10("v1", 10, 20, 100, 2);
	}

}
