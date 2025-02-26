extends Node

var peer = ENetMultiplayerPeer.new()

#Kot IP = "192.168.0.154"

var ip = "192.168.0.154"
var port = 12345

var status = 0
	
func connectToServer():
	if status != 2:
		peer.create_client(ip, port)
		multiplayer.multiplayer_peer = peer
		await Random.wait(1)
	return await connectionStatus()

func connectionStatus():
	match peer.get_connection_status():
		MultiplayerPeer.CONNECTION_CONNECTING:
			print("Connecting")
			status = 1
			await Random.message("Could not connect to server", 1,Vector2(0,100))
			return 1
		MultiplayerPeer.CONNECTION_CONNECTED:
			print("Connected to server at ", ip, ":", port)
			status = 2
			return 2
		MultiplayerPeer.CONNECTION_DISCONNECTED:
			print("Disconnected from server.")
			status = 0
			await Random.message("Could not connect to server",1, Vector2(0,100))
			return 0

# Interconnection --------------------------------------------------------------

@rpc("any_peer")
func message(text: String):
	print("Received from server: ", message)
	Random.message(text)
