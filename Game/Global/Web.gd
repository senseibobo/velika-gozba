extends Node


func request_highscores(level,result_node, result_function):
	make_request("https://velika-gozba.herokuapp.com/highscores/"+str(level),HTTPClient.METHOD_GET,result_node,result_function)

func send_highscore(level,score,result_node = null,result_function = ""):
	var body : Dictionary = {
		"name" : Global.ime,
		"score" : score,
		"level" : level
	}
	if not is_instance_valid(result_node):
		var request = make_request("https://velika-gozba.herokuapp.com/highscores/",HTTPClient.METHOD_POST,self,"on_highscore_received",body)
	else:
		var request = make_request("https://velika-gozba.herokuapp.com/highscores/",HTTPClient.METHOD_POST,result_node,result_function,body)
	
func on_highscore_received(result, response_code, headers, body):
	pass

func on_highscores_received(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)

func make_request(url,method,result_node,result_function,body : Dictionary = {}):
	var query = JSON.print(body)
	var request = HTTPRequest.new()
	add_child(request)
	var headers = ["Content-Type: application/json"]
	request.request(url,headers,true,method,query)
	request.connect("request_completed",result_node,result_function)
	request.connect("request_completed",self,"free_request",[request])
	return request

func free_request(result, response_code, headers, body, request):
	request.queue_free()

func on_request_completed(result, response_code, headers, body):
	pass
