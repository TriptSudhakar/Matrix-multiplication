LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
ENTITY tb_RAM_block IS
END tb_RAM_block;
ARCHITECTURE behavior OF tb_RAM_block IS
COMPONENT dist_mem_gen_2
Port (clk: in std_logic;
      a : in std_logic_vector(13 downto 0);
      d: in std_logic_vector(15 downto 0);
      we: in std_logic;
      spo : out std_logic_vector(15 downto 0));
END COMPONENT;
--Inputs
signal clock : std_logic := '0';
signal rdaddress : std_logic_vector(13 downto 0) := (others => '0');
signal data : std_logic_vector(15 downto 0) := (others => '0');
--Outputs
signal w : std_logic_vector(15 downto 0) := (others => '0');
-- Clock period definitions
constant clock_period : time := 10 ns;
signal i: integer;
BEGIN
-- Read image in VHDL
uut: dist_mem_gen_2 port map(clk => clock,a=>rdaddress,d=>data,we=>'0',spo =>w);
-- Clock process definitions
clock_process :process
begin
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    wait for clock_period/2;
end process;
-- Stimulus process
stim_proc: process
begin
    for i in 0 to 16383 loop
    rdaddress <= std_logic_vector(to_unsigned(i, 14));
    wait for 20 ns;
    end loop;
    wait;
end process;
END;