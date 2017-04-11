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
 * An item has a volume and a mass.
 */
public interface Item {

    /**
     * Get the item volume.
     *
     * @return the item volume.
     */
    abstract public Integer getVolume();

    /**
     * Get the item mass.
     *
     * @return the item mass.
     */
    abstract public Integer getMass();

}
