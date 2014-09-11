import socket, select, time, sys
#Definitions
serverPort = 12000
clientPort = 11000
sendBuff = 32
receiveBuff = 128
receiveSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
receiveSocket.bind(("", serverPort))
sendSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sSockets = list()
sSockets.append(sendSocket)
rSockets = list()
rSockets.append(receiveSocket)

nextTime = time.clock()
done = False
inMessage = ""
clients = list()
healthy = 50
happy = 50
outPack = ""

health = list()
unhealth = list()
upbeat = list()
depress = list()


health.extend({"vegetables","work","excersize","run","harder"})
unhealth.extend({"candy","drunk","tv","couch"})
upbeat.extend({"love","candy","drunk","games","fun"})
depress.extend({"sad","crazy","lame","work","vegetables"})


print 'The server is ready to receive'
while not done:
	#send and receive packets
	reads,writes,_ = select.select(rSockets,sSockets,[])
	for sock in reads:
		inMessage, clientLoc = sock.recvfrom(receiveBuff)
		if inMessage in health and healthy < 100:
			healthy = healthy+1
		if inMessage in unhealth and healthy > 0:
			healthy = healthy-1
		if inMessage in upbeat and happy < 100:
			happy = happy+1
		if inMessage in depress and happy > 0:
			happy = happy-1
		clientAddress,port = clientLoc
		if clientAddress not in clients:
			print "New client from: "+clientAddress
			clients.append(clientAddress)

	outPack = str(healthy*1000+happy)
	if time.clock() >= nextTime:
		for client in clients:
			for sock in writes:
				if sys.getsizeof(outPack) < sendBuff:
					sock.sendto(outPack,(client,clientPort))
		nextTime = time.clock() + .1
			

