
[Client] curl -s localhost:*****/api/boxes/NOTFOUND
{"status":404,"message":"Box `NOTFOUND` not found"}
[Client] curl -s localhost:*****/api/boxes/dev:BoxJava
{"id":"dev:BoxJava","title":"BoxJava","is_active":true,"closes_at":null,"public_tests":11,"private_tests":91,"readme":"<h1 id=\"BoxJava\">BoxJava</h1>\n"}
[Client] curl -s localhost:*****/api/boxes/dev:BoxNit
{"id":"dev:BoxNit","title":"BoxNit","is_active":true,"closes_at":null,"public_tests":3,"private_tests":1,"readme":null}
[Client] curl -s localhost:*****/api/boxes/BoxPep
{"id":"BoxPep","title":"BoxPep","is_active":true,"closes_at":null,"public_tests":11,"private_tests":51,"readme":null}
