
[Client] curl -s localhost:*****/api/boxes/NOTFOUND
{"status":404,"message":"Box `NOTFOUND` not found"}
[Client] curl -s localhost:*****/api/boxes/dev:BoxJava
{"id":"dev:BoxJava","title":"BoxJava","is_active":true,"closes_at":null,"tests":[{"path":"tests/test10.in","name":"test10"},{"path":"tests/test1.in","name":"test1"},{"path":"tests/test2.in","name":"test2"},{"path":"tests/test3.in","name":"test3"},{"path":"tests/test4.in","name":"test4"},{"path":"tests/test5.in","name":"test5"},{"path":"tests/test6.in","name":"test6"},{"path":"tests/test7.in","name":"test7"},{"path":"tests/test8.in","name":"test8"},{"path":"tests/test9.in","name":"test9"}],"readme":"<h1 id=\"BoxJava\">BoxJava</h1>\n"}
[Client] curl -s localhost:*****/api/boxes/dev:BoxNit
{"id":"dev:BoxNit","title":"BoxNit","is_active":true,"closes_at":null,"tests":[{"path":"tests/test1.in","name":"test1"},{"path":"tests/test2.in","name":"test2"}],"readme":null}
[Client] curl -s localhost:*****/api/boxes/BoxPep
{"id":"BoxPep","title":"BoxPep","is_active":true,"closes_at":null,"tests":[{"path":"tests/test10.in","name":"test10"},{"path":"tests/test1.in","name":"test1"},{"path":"tests/test2.in","name":"test2"},{"path":"tests/test3.in","name":"test3"},{"path":"tests/test4.in","name":"test4"},{"path":"tests/test5.in","name":"test5"},{"path":"tests/test6.in","name":"test6"},{"path":"tests/test7.in","name":"test7"},{"path":"tests/test8.in","name":"test8"},{"path":"tests/test9.in","name":"test9"}],"readme":null}
