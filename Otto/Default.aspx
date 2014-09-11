<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Otto.Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="content-section" id="projects">
	<p class="sectionHead">Projects</p>
	<div class="boxed">
		<ul><p class="listHead">Current Projects</p>						
			<li><a href="#SonarController">Sonar Sensor Array (VHDL)</a></li>
			<li><a href="#RobotLamp">Robot Lamp (Arduino)</a></li>					
		</ul>
		<ul><p class="listHead">Retired Projects</p>
			<li><a href="#JungleTimers">Jungle Timers for League of Legends (C++)</a></li>
		</ul>
		<ul><p class="listHead">Personal Coursework</p>
			<li><a href="#ARM-LED">ARM-LED (ARM Assembly)</a></li>
			<li><a href="#HomeSouls">HomeSouls (Python w/pygame)</a></li>
			<li><a href="#Transmission">Simulated Transmission (Verilog)</a></li>
		</ul>
	</div>
	<div class="boxed" id="SonarController">
		<p class="description"><strong>Sonar Sensor Array (VHDL): </strong>
			This is a project I'm doing for the MCECS bot team at Portland State University.  The goal is to optimize the reading of an array of sonar sensors.  Currently the control system is in place for a single sonar sensor.  Next step goals involve reading stored data over PCIE before moving on to implementing the full array.
		</p>
		<p class="codeList-head">Links:</p>
		<ul class="codeList">
			<li><a href="projects\SonarController\Controller.vhd">Controller Code</a></li>
		</ul>		
	</div>
	<div class="boxed" id="RobotLamp">
		<p class="description"><strong>Robot Lamp (Arduino): </strong>
			This robot lamp is intended to respond to local movement and ambient light conditions to determine angle and brightness of its output.  Logic is controlled with an Arduino Uno.  The head consists of a series of LEDs, a phototransistor, and a sonic sensor array.  Two servos are used to adjust the angle of the lamp.  
			<br><br>Currently this project is on hold until I am able to get parts. 8/10/2014
		</p>
		<p class="codeList-head">Links:</p>
		<ul class="codeList">
			<li><a href="projects\RobotLamp\LampHeadSch.pdf">Schematic Rev1</a></li>
			<li><a href="http://arduino.cc/en/Main/arduinoBoardUno">Arduino Uno</a></li>
		</ul>		
	</div>
	<div class="boxed" id="JungleTimers">
		<p class="description"><strong>Jungle Timers for League of Legends (C++): </strong>
			A set of timers for League of Legends with timers setup to help track progress in game.  I created this because the majority of timers are build to run on the same computer that you are playing the game.  I personally prefer to use a touch screen laptop adjacent to me to handle my timers.
			<br><br>Currently in an Alpha state.  The program has issues with screen display flicker as well as not being sorted between red/blue sides.
			<br><br>Cancelled due to the feature being added to the in game UI.
		</p>
		<p class="codeList-head">Links:</p>
		<ul class="codeList">
			<li><a href="projects\JungleTimers\JungleTimers.zip">Program zip</a></li>
			<li><a href="projects\JungleTimers\JungleTimers-src.zip">Source zip</a></li>
		</ul>		
	</div>
	<div class="boxed" id="ARM-LED">
		<p class="description"><strong>ARM-LED (ARM Assembly): </strong>
			This was a simple ARM Assembly program.  It uses interrupt handlers to cause an LED to blink.  This was an assignment for a course on micro-controllers.
		</p>
		<p class="codeList-head">Code:</p>
		<ul class="codeList">
			<li><a href="projects\ARM-LED\ARM-LED-blink.s">ARM-LED-blink.s</a></li>
		</ul>				
	</div>
	<div class="boxed" id="HomeSouls">
		<p class="description"><strong>HomeSouls (Python w/pygame): </strong>
			This was a small python project I did for a course on networking.  The goal was to create a simple UDP server and client.  I decided to incorporate pygame to give the setup a better user interface.
		</p>
		<p class="codeList-head">Code:</p>
		<ul class="codeList">
			<li><a href="projects\HomeSouls\HomeSoulsServer.py">HomeSoulsServer.py</a></li>
			<li><a href="projects\HomeSouls\HomeSoulsClient.py">HomeSoulsClient.py</a></li>
			<li><a href="projects\HomeSouls\GameClientRFC.txt">GameClientRFC.txt</a></li>
		</ul>				
	</div>
	<div class="boxed" id="Transmission">
		<p class="description"><strong>Simulated Transmission (Verilog): </strong>
			My goal with this code was to mock up using a Cyclone IV FPGA to control the motors of a robot I was working on at the time.  The intention was to give the user input a responsiveness similar to a car transmission.  I completed the project as an extra credit assignment for a HDL course.
		</p>
		<p class="codeList-head">Code:</p>
		<ul class="codeList">
			<li><a href="projects\Transmission\ECE351_ProjectEC.v">ECE351_ProjectEC.v</a></li>
			<li><a href="projects\Transmission\determineRPM.v">determineRPM.v</a></li>
			<li><a href="projects\Transmission\displayRPM.v">displayRPM.v</a></li>
			<li><a href="projects\Transmission\transmission.v">transmission.v</a></li>
			<li><a href="projects\Transmission\351ExtraProject.docx">351ExtraProject.docx</a></li>
		</ul>
	</div>
</div>

</asp:Content>
