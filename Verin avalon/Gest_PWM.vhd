library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity Gest_PWM is
    port (
        clk_50MHz, reset_n : in std_logic;
        out_pwm_sig : out std_logic
    );
end entity;

architecture arch_pwm_nano of Gest_PWM IS
    signal freq : std_logic_vector(15 downto 0) := "0000011111010000";  
    signal duty : std_logic_vector(15 downto 0) := "0000010111011100";  
    signal counter : std_logic_vector(15 downto 0);
    signal pwm_signal : std_logic;

begin
    divide: process (clk_50MHz, reset_n)
    begin
        if reset_n = '0' then
            counter <= (others => '0');
        elsif rising_edge(clk_50MHz) then
            if counter >= freq then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process divide;

    compare: process (clk_50MHz, reset_n)
    begin
        if reset_n = '0' then
            pwm_signal <= '0';
        elsif rising_edge(clk_50MHz) then
            if to_integer(unsigned(counter)) >= to_integer(unsigned(duty)) then
                pwm_signal <= '0';
            else
                pwm_signal <= '1';
            end if;
        end if;
    end process compare;

    out_pwm_sig <= pwm_signal;

end arch_pwm_nano;