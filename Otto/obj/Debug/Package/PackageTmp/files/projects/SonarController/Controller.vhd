--The goal of this project is to be able to easily poll multiple PWM signals and place them in on board SRAM
--This code is an initial setup using heavily modified DE0-Nano sample code

--Current Goals:  	Transfer from DE0-Nano to DE2i
--					Verify SRAM read timing
--					Add logic for array handling

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


--Defining the main entity of the test board
entity DE0_NANO is
    Port ( 
		CLOCK_50 	: in STD_LOGIC;
--//////////// LED //////////
		LED			: out STD_LOGIC_VECTOR(7 DOWNTO 0);
--//////////// SW //////////
		KEY			: in STD_LOGIC_VECTOR(1 DOWNTO 0);
--//////////// SDRAM //////////
		DRAM_ADDR	: out  STD_LOGIC_VECTOR(12 DOWNTO 0);
		DRAM_DQ		: inout  STD_LOGIC_VECTOR(15 DOWNTO 0);
		DRAM_BA		: out STD_LOGIC_VECTOR(1 DOWNTO 0);
		DRAM_DQM		: out STD_LOGIC_VECTOR(1 DOWNTO 0);
		DRAM_RAS_N 	: out STD_LOGIC;
		DRAM_CAS_N 	: out STD_LOGIC;
		DRAM_CKE 	: out STD_LOGIC;
		DRAM_CLK 	: out STD_LOGIC;
		DRAM_WE_N  	: out STD_LOGIC;
		DRAM_CS_N 	: out STD_LOGIC;
--/////////// GPIO /////////////
		GPIO_0_D		: inout STD_LOGIC_VECTOR(3 DOWNTO 0)
											);
end DE0_NANO;


architecture Behavioral of DE0_NANO is
--SIGNAL 	LED_NEXT	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	PWM		:	STD_LOGIC;

begin		


--Setup system to default config and then handle mem writes
process
variable reset: boolean := TRUE;
begin

	IF(reset)THEN
		GPIO_0_D(3 DOWNTO 0) <= "11ZZ";
		DRAM_ADDR	<= "1000100011111";
		DRAM_BA		<= "00";
		DRAM_DQM		<= "00";
		DRAM_RAS_N 	<= '0';
		DRAM_CAS_N 	<= '0';
		DRAM_CKE 	<= '1';
		DRAM_CS_N 	<= '1';
		RESET := FALSE;
	END IF;
	
	DRAM_CLK 	<= CLOCK_50;
	DRAM_WE_N  	<= '1';
	
	WAIT UNTIL(CLOCK_50'EVENT) AND (CLOCK_50 = '1');

	--IF(cnt = 50000000)THEN		
	--cnt := 0;
	--ELSE
	--cnt := cnt  + 1;
	--END IF;
	
	--LED <= LED_NEXT;
	--if(cnt > 25000000)then
	--else
	--	LED <= (others => '0');
	--end if;					
		
end process;


--Timer for PWM to translate pulse length to distance
process
variable cnt: integer range 0 to 50000000;
begin
	WAIT UNTIL(CLOCK_50'EVENT) AND (CLOCK_50 = '1');

	IF(cnt = 50000000)THEN		
	cnt := 0;
	ELSE
	cnt := cnt  + 1;
	END IF;

	LED <= DRAM_DQ(7 DOWNTO 0);

end process;
	

--Output data on memory to LEDs for debug
process
variable data: integer range 0 to 1852000;
variable led_next: integer range 0 to 255;
begin

DRAM_DQ 	<= STD_LOGIC_VECTOR(to_unsigned(led_next, 16));
PWM <= GPIO_0_D(1);

led_next := data / 7263;

WAIT UNTIL(CLOCK_50'EVENT) AND (CLOCK_50 = '1');
CASE PWM IS
	when '1' =>
		data := data  + 1;
	when '0' =>
		data := 0;
end case;
end process;


				
end Behavioral;
