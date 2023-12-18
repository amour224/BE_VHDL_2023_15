library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
--use IEEE.std_logic_numeric.all;

entity ControleButees is
port (
	pwm_in, sens, enable: in std_logic;
	--butee_g, butee_d : in std_logic_vector (15 downto 0);
	angle_barre : in std_logic_vector (11 downto 0);
	out_pwm, out_sens, f_g, f_d : out std_logic
);
end entity;

ARCHITECTURE bhv of ControleButees IS

	signal butee_d: std_logic_vector (15 downto 0) :=  "0000010101111000" ; -- une butee_d de 1400
	signal butee_g: std_logic_vector (15 downto 0)  := "0000000110011010" ; -- une butee_g de 410

BEGIN
process (angle_barre) 

begin
	if ((angle_barre < butee_g) and sens = '0' and enable ='1') then
		out_pwm <= '0';
		f_g <= '1';
		f_d <= '0';
	elsif (angle_barre > butee_d and sens = '1' and enable ='1') then
		out_pwm <= '0';
		f_d <= '1';
		f_g <= '0';
		else 
			out_pwm <= pwm_in;
			f_d <= '0';
			f_g <= '0';
	end if;
end process;
	out_sens <= sens;
	
end bhv;