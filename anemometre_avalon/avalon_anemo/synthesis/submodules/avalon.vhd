library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity avalon is
    port (
        clk_50M, chipselect, write_n, reset_n : in std_logic;
        writedata : in std_logic_vector(31 downto 0);
        readdata : out std_logic_vector(31 downto 0);
        address : in std_logic_vector(1 downto 0);
        in_freq_anemo : in std_logic
    );
end entity;

architecture arch_avalon of avalon is
    signal clk: STD_LOGIC;
    signal raz_n : STD_LOGIC;
    signal continu, start_stop : STD_LOGIC;
    signal S_1Hz: STD_LOGIC;
    signal data_valid : std_logic;
    signal data_anemometre : std_logic_vector(7 downto 0);
    signal config : std_logic_vector(31 downto 0);

    component counter2
        port (
            clk_50M : in STD_LOGIC;
            in_freq_anemo : in STD_LOGIC;
            raz_n : in STD_LOGIC;
            frq : out integer range 0 to 255
        );
    end component;

    component anemo
	
        port (
            S_1Hz: in STD_LOGIC;
            clk_50M : in STD_LOGIC;
            continu : in STD_LOGIC;
            start_stop : in STD_LOGIC;
            raz_n : in STD_LOGIC;
            frq : in integer range 0 to 255;
            data_valid : out STD_LOGIC;
            data_anemometre : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component diviseur2
        port (
           clk_50M : in std_logic; 
        S_1Hz : out std_logic 
        );
    end component;

    signal SYNTHESIZED_WIRE_0 : STD_LOGIC;
    signal SYNTHESIZED_WIRE_1 : integer range 0 to 255;

begin
    S_1Hz<= SYNTHESIZED_WIRE_0;

    b2v_inst : counter2
    port map (
        clk_50M  => clk_50M ,
        in_freq_anemo => in_freq_anemo,
        raz_n => raz_n,
        frq => SYNTHESIZED_WIRE_1
    );

    b2v_inst1 : anemo
    port map (
        S_1Hz=> SYNTHESIZED_WIRE_0,
        clk_50M => clk_50M ,
        continu => continu,
        start_stop => start_stop,
        raz_n => raz_n,
        frq => SYNTHESIZED_WIRE_1,
        data_valid => data_valid,
        data_anemometre => data_anemometre
    );

    b2v_inst2 : diviseur2
    port map (
        clk_50M  => clk_50M ,
        S_1Hz=> S_1Hz
    );

    -- Processus d'écriture des registres
    process_write: process (clk_50M, reset_n)
    begin
        if reset_n = '0' then
            continu <= '0';
            start_stop <= '0';
            raz_n <= '0';
        elsif clk_50M'event and clk_50M= '1' then
            if chipselect ='1' and write_n = '0' then
                config <= writedata;
                if address = "00" then
                    start_stop <= config(2);
                elsif address = "01" then
                    continu <= config(1);
                elsif address = "10" then
                    raz_n <= config(0);
                end if;
            end if;
        end if;
    end process;

    -- Processus de lecture des registres
    process_Read: process (start_stop, continu, raz_n, data_valid, data_anemometre)
    begin
        case address is
            when "00" => readdata <= (others => '0');  -- Ajoutez ici la sortie appropriée
            when "01" => readdata <= (others => '0');  -- Ajoutez ici la sortie appropriée
            when "10" => readdata <= (others => '0');  -- Ajoutez ici la sortie appropriée
            when "11" => readdata <= X"00000" & "00" & data_valid & "0" & data_anemometre;
            when others => readdata <= (others => '0');
          end case;
    end process;

end arch_avalon;  
     
