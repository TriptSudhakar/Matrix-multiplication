----------------------------------------------------------------------------------
-- Company:
-- Engineer:
-- 
-- Create Date: 20.10.2022 22:40:47
-- Design Name:
-- Module Name: clock - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock is
Port (clk : in std_logic;
bit_2 : out std_logic_vector(1 downto 0):="00";
an : out std_logic_vector(3 downto 0):="1110");
end clock;

architecture Behavioral of clock is
signal counter: integer := 0;
begin
--counter <= 0;
process (clk,counter)
begin
if rising_edge(clk) then
    if counter = 25000 then
        bit_2 <= "01";
        an <= "1101";
        counter<= counter + 1;
    elsif counter = 50000 then
        bit_2 <= "10";
        an <= "1011";
        counter<= counter + 1;
    elsif counter = 75000 then
        bit_2 <= "11";
        an <= "0111";
        counter<= counter + 1;
    elsif counter = 100000 then
        bit_2 <= "00";
        an <= "1110";
        counter<=0;
    else
        counter<= counter + 1;
    end if;

end if;
end process;

end Behavioral;