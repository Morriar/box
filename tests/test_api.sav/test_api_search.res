
[Client] curl -s localhost:*****/api/search
[]
[Client] curl -s localhost:*****/api/search?q=foo
[]
[Client] curl -s localhost:*****/api/search?q=BoxJava
[{"id":"dev:BoxJava","title":"BoxJava","is_active":true,"closes_at":null,"public_tests":11,"private_tests":91,"readme":"<h1 id=\"BoxJava\">BoxJava</h1>\n"}]
[Client] curl -s localhost:*****/api/search?q=dev:BoxJava
[{"id":"dev:BoxJava","title":"BoxJava","is_active":true,"closes_at":null,"public_tests":11,"private_tests":91,"readme":"<h1 id=\"BoxJava\">BoxJava</h1>\n"}]
[Client] curl -s localhost:*****/api/search?q=dev
[{"id":"dev:BoxNit","title":"BoxNit","is_active":true,"closes_at":null,"public_tests":3,"private_tests":1,"readme":null},{"id":"dev:BoxJava","title":"BoxJava","is_active":true,"closes_at":null,"public_tests":11,"private_tests":91,"readme":"<h1 id=\"BoxJava\">BoxJava</h1>\n"}]
