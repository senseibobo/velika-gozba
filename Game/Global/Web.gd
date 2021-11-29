extends Node


func request_highscores(result_node, result_function):
	make_request("https://velika-gozba.herokuapp.com/highscores",HTTPClient.METHOD_GET,result_node,result_function)

func on_highscores_received(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)

func make_request(url,method,result_node,result_function,body = {}):
	var query = JSON.print(body)
	var request = HTTPRequest.new()
	add_child(request)
	request.request(url,PoolStringArray(),true,method,query)
	request.connect("request_completed",result_node,result_function)
	request.connect("request_completed",self,"free_request",[request])
	return request

func free_request(result, response_code, headers, body, request):
	request.queue_free()

func on_request_completed(result, response_code, headers, body):
	pass
