#imports
import socket, select, pygame, time, sys
from multiprocessing import Process, Queue, Pool
from pygame.locals import *

#Definitions
serverIP = raw_input("What is the host server IP?: ")
serverPort = 12000
clientPort = 11000
receiveBuff = 32
sendBuff = 128
receiveSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
receiveSocket.bind(("", clientPort))
sendSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sSockets = list()
sSockets.append(sendSocket)
rSockets = list()
rSockets.append(receiveSocket)



#functions
def display(str, x, y):
	text = font.render(str, True, (255, 255, 255))
	screen.blit(text, (x,y))
	pygame.display.flip()


def setup():
	background.fill((150, 150, 150))
	text = font.render("Healthy: ", True, (255, 255, 255))
	background.blit(text, (10,10))
	text = font.render("Happy: ", True, (255, 255, 255))
	background.blit(text, (10,20))
	text = font.render("What will you whisper?", True, (255, 255, 255))
	background.blit(text, (10,80))
	text = font.render("> ", True, (255, 255, 255))
	background.blit(text, (10,90))
	screen.blit(background, (0,0))
	pygame.display.flip()
	

	
#program
if __name__ == '__main__':
	pygame.init()
	screen = pygame.display.set_mode( (175,125) )
	pygame.display.set_caption('Home Souls')

	# Fill background
	background = pygame.Surface(screen.get_size())
	background = background.convert()
	font = pygame.font.Font(None, 17)
	setup()

	done = False
	message = "here"
	messageOld = ""
	inMessage = ""
	userIn = ""
	healthy = "disconnected"
	happy = "disconnected"
	nextTime = time.clock()

	while not done:
		messageOld = message

		#send and receive packets
		reads,writes,_ = select.select(rSockets,sSockets,[])
		for sock in reads:
			inMessage, clientAddress = sock.recvfrom(receiveBuff)
			healthy = str(int(inMessage)/1000)
			happy = str(int(inMessage)-int(healthy)*1000)
			screen.blit(background, (0, 0))
			pygame.display.flip()
			display(userIn,20,90)
			display(str(healthy),60,10)
			display(str(happy),60,20)
		
		if time.clock() >= nextTime:
			for sock in writes:
				words = message.split()
				for word in words:
					if sys.getsizeof(word) < sendBuff:
						sock.sendto(word.lower(),(serverIP, serverPort))
			nextTime = time.clock() + 1
			
		for evt in pygame.event.get():
			if evt.type == KEYDOWN:
				if evt.unicode.isalpha():
					userIn += evt.unicode
				elif evt.key == K_SPACE:
					userIn += " "
				elif evt.key == K_RETURN:
					message = userIn
					userIn = ""
				elif evt.key == K_BACKSPACE:
					userIn = userIn[:-1]
				elif evt.key == K_ESCAPE:
					pygame.display.quit()
					done = True
					break
				screen.blit(background, (0, 0))
				pygame.display.flip()
				display(userIn,20,90)
				display(str(healthy),60,10)
				display(str(happy),60,20)
