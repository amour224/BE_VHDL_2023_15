library ieee;
use ieee.std_logic_1164.all;

entity anemometre2 is
    port (
        raz_n : in std_logic;
        clk_50M : in std_logic;
        continu : in std_logic;
        start_stop : in std_logic;
        in_freq_anemo : in std_logic;
        data_valid : out std_logic;
        S_1Hz : out std_logic;
        data_anemometre : out std_logic_vector(7 downto 0)
    );
end anemometre2;

architecture bdf_type of anemometre2 is 
    component counter2
        port (
            clk_50M : in std_logic;
            in_freq_anemo : in std_logic;
            raz_n : in std_logic;
            frq : out integer range 0 to 255
        );
    end component;

    component anemo
        port (
            S_1Hz : in std_logic;
            clk_50M : in std_logic;
            continu : in std_logic;
            start_stop : in std_logic;
            raz_n : in std_logic;
            frq : in integer range 0 to 255;
            data_valid : out std_logic;
            data_anemometre : out std_logic_vector(7 downto 0)
        );
    end component;

    component diviseur2
        port (
            clk_50M : in std_logic;
            S_1Hz : out std_logic
        );
    end component;

    signal synthesized_wire_0 : std_logic;
    signal synthesized_wire_1 : integer range 0 to 255;

begin
    S_1Hz <= synthesized_wire_0;

    counter_inst : counter2
    port map (
        clk_50M => clk_50M,
        in_freq_anemo => in_freq_anemo,
        raz_n => raz_n,
        frq => synthesized_wire_1
    );

    anemo_inst : anemo
    port map (
        S_1Hz => synthesized_wire_0,
        clk_50M => clk_50M,
        continu => continu,
        start_stop => start_stop,
        raz_n => raz_n,
        frq => synthesized_wire_1,
        data_valid => data_valid,
        data_anemometre => data_anemometre
    );

    divider_inst : diviseur2
    port map (
        clk_50M => clk_50M,
        S_1Hz => synthesized_wire_0
    );
end bdf_type;
