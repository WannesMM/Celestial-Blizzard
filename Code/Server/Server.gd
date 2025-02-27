extends Node

var serverVersion
var gameVersion = "PreAlpha"

var client = ENetMultiplayerPeer.new()

#Kot IP = "192.168.0.154"

var ip = "192.168.0.154"
var port = 12345

var status = 0

signal versionGiven

func connectToServer():
	if status != 2:
		client.create_client(ip, port)
		multiplayer.multiplayer_peer = client
		await Random.wait(1)
	return await connectionStatus()

func connectionStatus():
	match client.get_connection_status():
		MultiplayerPeer.CONNECTION_CONNECTING:
			print("Connecting")
			status = 1
			await Random.message("Could not connect to server", 1,Vector2(0,100))
			return 1
		MultiplayerPeer.CONNECTION_CONNECTED:
			print("Connected to server at ", ip, ":", port)
			print("Client's unique ID:", multiplayer.get_unique_id())
			status = 2
			return 2
		MultiplayerPeer.CONNECTION_DISCONNECTED:
			print("Disconnected from server.")
			status = 0
			await Random.message("Could not connect to server",1, Vector2(0,100))
			return 0

func getServerVersion():
	rpc_id(1,"requestServerVersion")
	await versionGiven
	if serverVersion != gameVersion:
		await Random.message("A newer version is available",4,Vector2(0,100))
	return serverVersion

func createAccount(name: String, password: String):
	rpc_id(1,"createNewAccount",name,password)

# Interconnection --------------------------------------------------------------

@rpc("authority")
func message(text: String):
	print("Received from server: ", text)
	Random.message(text)

@rpc("authority")
func receiveServerVersion(version: String):
	serverVersion = version
	versionGiven.emit()

@rpc("any_peer")
func requestServerVersion():
	pass

@rpc("any_peer")
func createNewAccount():
	pass
