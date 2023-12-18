-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "10/25/2022 09:12:38"
                                                            
-- Vhdl Test Bench template for design  :  diviseur2
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY diviseur2_vhd_tst IS
END diviseur2_vhd_tst;


ARCHITECTURE diviseur2_arch OF diviseur2_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_50 : STD_LOGIC;
SIGNAL continu : STD_LOGIC :='1';
SIGNAL hz : STD_LOGIC;


COMPONENT diviseur2
	PORT (
	clk_50 : IN STD_LOGIC;
	continu : IN STD_LOGIC;
	hz : OUT STD_LOGIC
	);
	
END COMPONENT;
constant clk_period: time := 20 ns;


BEGIN
	i1 : diviseur2
	PORT MAP (
-- list connections between master ports and signals
	clk_50 => clk_50,
	continu => continu,
	hz => hz
	);
	

clk_process : process 
	begin 
		clk_50 <= '0';
		wait for clk_period/2;
		clk_50 <= '1';
		wait for clk_period/2;
	end process;
	
-- stimulus process
		stim_proc : process
		begin
			wait for 1010 ms;
			
			continu <= '0';
			wait;
		end process;                                          
END diviseur2_arch;
