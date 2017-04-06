# Copyright 2017 Alexandre Terrasa <alexandre@moz-code.org>.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import api

var model = new Model
model.load_boxes("boxes/")

var app = new App

app.use("/api", new APIRouter(model))
app.use("/*", new StaticHandler("www", "index.html"))

app.use_after("/*", new ConsoleLog)

app.listen("0.0.0.0", 3000)
