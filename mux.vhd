----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2022 03:26:42 AM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
  Port (s0,s1:in std_logic;
        v: in std_logic_vector(15 downto 0);
        p,q,r,s : out std_logic);
end mux;

architecture Behavioral of mux is

begin
p <= (not s0 and not s1 and v(3)) or (not s0 and s1 and v(7)) or (s0 and not s1 and v(11)) or (s0 and s1 and v(15));
q <= (not s0 and not s1 and v(2)) or (not s0 and s1 and v(6)) or (s0 and not s1 and v(10)) or (s0 and s1 and v(14));
r <= (not s0 and not s1 and v(1)) or (not s0 and s1 and v(5)) or (s0 and not s1 and v(9)) or (s0 and s1 and v(13));
s <= (not s0 and not s1 and v(0)) or (not s0 and s1 and v(4)) or (s0 and not s1 and v(8)) or (s0 and s1 and v(12));
end Behavioral;
