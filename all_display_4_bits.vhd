----------------------------------------------------------------------------------
-- Company:
-- Engineer:
-- 
-- Create Date: 17.10.2022 16:36:10
-- Design Name:
-- Module Name: all_display_4_bits - Behavioral
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

entity all_display_4_bits is
Port ( sw: in std_logic_vector(15 downto 0);
    clk : in std_logic;
    seg: out std_logic_vector (6 downto 0);
    an : out std_logic_vector(3 downto 0));
end all_display_4_bits;

architecture Behavioral of all_display_4_bits is
    signal bit_2 : std_logic_vector(1 downto 0) ;
    signal a,b,c,d : std_logic;

    component hex_bit
    Port (a,b,c,d: in std_logic;
        seg :out std_logic_vector(6 downto 0));
    end component;
    
    component clock
    Port (clk : in std_logic;
    bit_2 : out std_logic_vector(1 downto 0);
    an : out std_logic_vector(3 downto 0));
    end component;
    
    component mux
    Port (s0,s1:in std_logic;
        v: in std_logic_vector(15 downto 0);
        p,q,r,s : out std_logic);
    end component;
begin
UUT1: clock port map(clk=>clk,bit_2=>bit_2,an=>an);
UUT2 : mux port map(s0=>bit_2(1),s1 => bit_2(0),v=>sw,p=>a,q=>b,r=>c,s=>d);
UUT3 : hex_bit port map(a=>a,b=>b,c=>c,d=>d,seg=>seg);
    process (clk,bit_2)
    begin
    end process;
end Behavioral;