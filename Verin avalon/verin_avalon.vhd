library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity verin_avalon is
port (
clk, chipselect, write_n, reset_n : in std_logic;
writedata : in std_logic_vector (31 downto 0);
readdata : out std_logic_vector (31 downto 0);
address: in std_logic_vector (2 downto 0);

data_in :  IN  STD_LOGIC;
cs :  OUT  STD_LOGIC;
un_M :  OUT  STD_LOGIC;
out_pwm :  OUT  STD_LOGIC;
out_sens :  OUT  STD_LOGIC

--fin_course_g :  OUT  STD_LOGIC;
--fin_course_d :  OUT  STD_LOGIC;
--raz_n :  IN  STD_LOGIC;
--sens :  IN  STD_LOGIC;
--butee_d :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
--butee_g :  IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
--duty :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
--freq :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
--data_out :  OUT  STD_LOGIC_VECTOR(11 DOWNTO 0)
);
end entity;


ARCHITECTURE arch_VerAvalon of verin_avalon IS

signal fin_course_g :  STD_LOGIC;
signal fin_course_d :  STD_LOGIC;
signal raz_n :  STD_LOGIC;
signal sens :   STD_LOGIC;
signal butee_d :  STD_LOGIC_VECTOR(11 DOWNTO 0);
signal butee_g :  STD_LOGIC_VECTOR(11 DOWNTO 0);
signal duty :  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal freq :  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal Angle_barre :  STD_LOGIC_VECTOR(11 DOWNTO 0); --
signal config : std_logic_vector(31 downto 0);


COMPONENT ChipSelect is
	port(
		start_c : in std_logic;
		clk_1M : in std_logic;
		raz_n : in std_logic;
		cs : out std_logic);
END COMPONENT;

COMPONENT GestionADC is
	port(
		start_conv : in std_logic;
		cs : in std_logic;
		clk_1M : in std_logic;
		raz_n : in std_logic;
		data_in : in std_logic;
		data_out : out std_logic_vector(11 downto 0)
		);
END COMPONENT;

COMPONENT Sig_1MHz is
port (
	clk_50 : in std_logic;
	raz_n : in std_logic;
	clk_1M : out std_logic);
END COMPONENT;

COMPONENT ControleButees is
port (
	pwm_in, sens, enable: in std_logic;
	--butee_g, butee_d : in std_logic_vector (15 downto 0);
	angle_barre : in std_logic_vector (11 downto 0);
	out_pwm, out_sens, f_g, f_d : out std_logic
);
END COMPONENT;

COMPONENT Sig_10Hz is
port (
	raz_n : in std_logic;
	clk_1M : in std_logic;
	start_conv : out std_logic);
END COMPONENT;

COMPONENT Gest_PWM is

port (
clk_50M, raz_n: in std_logic;
frequence, C_duty : in std_logic_vector (31 downto 0);
S_PWM : out std_logic
);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(11 DOWNTO 0);


BEGIN 
cs <= SYNTHESIZED_WIRE_3;
un_M <= SYNTHESIZED_WIRE_9;
Angle_barre <= SYNTHESIZED_WIRE_6;


b2v_inst : ChipSelect
PORT MAP(start_c => SYNTHESIZED_WIRE_8,
		 clk_1M  => SYNTHESIZED_WIRE_9,
		 raz_n => raz_n,
		 cs => SYNTHESIZED_WIRE_3);


b2v_inst1 : GestionADC
PORT MAP(start_conv => SYNTHESIZED_WIRE_8,
		 cs => SYNTHESIZED_WIRE_3,
		 clk_1M => SYNTHESIZED_WIRE_9,
		 raz_n => raz_n,
		 data_in => data_in,
		 data_out => SYNTHESIZED_WIRE_6);


b2v_inst2 : Sig_1MHz
PORT MAP(clk_50 => clk,
		 raz_n => raz_n,
		 clk_1M => SYNTHESIZED_WIRE_9);


b2v_inst3 : ControleButees
PORT MAP(pwm => SYNTHESIZED_WIRE_5,
		 sens => sens,
		 angle_barre => SYNTHESIZED_WIRE_6,
		 butee_d => butee_d,
		 butee_g => butee_g,
		 out_pwm => out_pwm,
		 out_sens => out_sens,
		 fin_course_g => fin_course_g,
		 fin_course_d => fin_course_d);


b2v_inst4 : Sig_10Hz
PORT MAP(raz_n => raz_n,
		 clk_1M => SYNTHESIZED_WIRE_9,
		 start_conv => SYNTHESIZED_WIRE_8);


b2v_inst5 : Gest_PWM
PORT MAP(clk => clk,
		 raz_n => raz_n,
		 duty => duty,
		 freq => freq,
		 pwm_out => SYNTHESIZED_WIRE_5);
		 
		 
-- écriture registres
process_write: process (clk, reset_n)
begin
	if reset_n = '0' then
		freq <= (others => '0');
		duty <= (others => '0');
		raz_n <= '0';
	elsif clk'event and clk = '1' then
			if chipselect ='1' and write_n = '0' then
				if address = "000" then
					freq <= writedata;
				end if;
				if address = "001" then
					duty <= writedata;
				end if;
				if address = "010" then
					butee_g <= writedata (11 downto 0);
				end if;
				if address = "011" then
					butee_d <= writedata (11 downto 0);
				end if;
				if address = "100" then
					config <= writedata;
					fin_course_g <= config(4);
					fin_course_d <= config(3);
					sens <= config(2);
					--enable_pwm <= config(1);
					raz_n <= config(0);
				end if;
				--if address = "010" then
				--Angle_barre <= writedata (11 downto 0); -- ligne 42
				--end if;
			end if;
	end if;
end process;

-- lecture registres
process_Read:
PROCESS(freq, duty, butee_g, butee_d, Angle_barre)
BEGIN
	case address is
		when "000" => readdata <= freq ;
		when "001" => readdata <= duty ;
		when "010" => readdata(11 downto 0) <= butee_g ;
		when "011" => readdata(11 downto 0) <= butee_d ;
		when "100" => readdata <= config ;
		when "101" => readdata <= X"00000"&Angle_barre ;
		when others => readdata <= (others => '0');
		--when "10" => readdata <= X"0000000"&"000"&raz_n ;
		--when "11" => readdata <= X"00000"&"00"&data_valid&"0"&data_anemometre;
	end case;
	--readdata <= X"00000"&"00"&data_valid&"0"&data_anemometre;
END PROCESS process_Read ;
END arch_VerAvalon ;