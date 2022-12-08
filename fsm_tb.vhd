----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2022 21:30:36
-- Design Name: 
-- Module Name: matrix - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_tb is
--  Port ( );
end fsm_tb;

architecture Behavioral of fsm_tb is

component control_fsm is
Port (clk: in std_logic;
        v: in std_logic_vector(13 downto 0);
        an: out std_logic_vector(3 downto 0);
        seg: out std_logic_vector(6 downto 0));
end component;

signal v : std_logic_vector(13 downto 0):="00000000000000";
signal an : std_logic_vector (3 downto 0);
signal clk : std_logic;
signal seg : std_logic_vector(6 downto 0);
constant clk_period: time := 10 ns;

begin
UUT : control_fsm port map (v=>v,clk => clk,an => an,seg => seg);
    clk_process: process
    begin
        clk<='0';
        wait for clk_period/2;
        clk<='1';
        wait for clk_period/2;
    end process;
    
    stim_proc: process
    begin
        for i in 0 to 16383 loop
        v <= std_logic_vector(to_unsigned(i, 14));
        wait for 20 ns;
        end loop;
        wait;
    end process;
end Behavioral;
