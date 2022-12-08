----------------------------------------------------------------------------------
-- Company:
-- Engineer:
-- 
-- Create Date: 17.10.2022 14:52:50
-- Design Name:
-- Module Name: hex_4_bit - Behavioral
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

entity hex_bit is
Port (a,b,c,d: in std_logic;
seg :out std_logic_vector(6 downto 0)
);
end hex_bit;

architecture Behavioral of hex_bit is

begin
-- an(0) <= '0';
-- an(1) <= '1';
-- an(2) <= '1';
-- an(3) <= '1';
seg(0)<= (not a and not b and not c and d) or (a and not b and c and d) or (b and not c and not d) or (a and b and not c);
seg(1)<= (not a and b and not c and d) or (not a and b and c and not d) or (a and b and not c and not d) or (a and c and d);
seg(2)<= (not a and not b and c and not d) or (a and b and not c and not d) or (a and b and c);
seg(3)<= (not a and not b and not c and d) or (not a and b and not c and not d) or (b and c and d);
seg(4)<= (not a and d) or (not a and b and not c) or (not b and not c and d);
seg(5)<= (not a and not b and d) or (not b and c and not d) or (not a and c and d) or (a and b and not c);
seg(6)<= (not a and b and c and d) or (not a and not b and not c);
--an <= an;
end Behavioral;