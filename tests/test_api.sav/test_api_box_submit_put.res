
[Client] curl -X PUT -s localhost:*****/api/boxes/NOTFOUND/submit
{"status":404,"message":"Box `NOTFOUND` not found"}
[Client] curl -X PUT -s localhost:*****/api/boxes/dev:BoxNit/submit
{"status":403,"message":"Box does not accept submissions"}
[Client] curl -X PUT -d @test_api_box_submit_put.json -s localhost:*****/api/boxes/dev:BoxJava/submit
{"tests_results":[{"test_name":"make","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test1","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test10","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test2","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test3","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test4","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test5","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test6","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test7","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test8","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""},{"test_name":"test9","is_passed":false,"cmd":"","code":"","err":"","log":"","out":"","diff":""}],"tests_passed":0,"tests_failed":11,"is_runned":false,"is_passed":false}
[Client] rm -f test_api_box_submit_put.json

[Client] rm -rf data/test_api/BoxJava/submissions

