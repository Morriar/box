/*
 * Copyright 2017 Alexandre Terrasa <alexandre@moz-code.org>.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package farstar.freight;

/**
 * A freight container.
 */
public class Container implements Item {

    /**
     * The container volume.
     */
    private Integer volume;

    /**
     * The container mass.
     */
    private Integer mass;

    /**
     * Create a new container.
     *
     * @param volume must be greater than 0
     * @param mass must be greater than 0
     */
    public Container(Integer volume, Integer mass) {
        if (volume <= 0) {
            throw new IllegalArgumentException();
        }
        if (mass <= 0) {
            throw new IllegalArgumentException();
        }
        this.volume = volume;
        this.mass = mass;
    }

    @Override
    public Integer getVolume() {
        return volume;
    }

    @Override
    public Integer getMass() {
        return mass;
    }

}
