----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2022 20:02:21
-- Design Name: 
-- Module Name: control_fsm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_fsm is
  Port (clk: in std_logic;
        v: in std_logic_vector(13 downto 0);
        an: out std_logic_vector(3 downto 0);
        seg: out std_logic_vector(6 downto 0));
end control_fsm;

architecture Behavioral of control_fsm is

component all_display_4_bits is
Port ( sw: in std_logic_vector(15 downto 0);
    clk : in std_logic;
    seg: out std_logic_vector (6 downto 0);
    an : out std_logic_vector(3 downto 0));
end component;

component selection is
Port (v,adram : in std_logic_vector(0 to 13);
        we : in std_logic;
        res : out std_logic_vector(0 to 13));
end component;

component dist_mem_gen_0 is
Port  ( clk: in std_logic;
       a : in std_logic_vector(13 downto 0);
       spo: out std_logic_vector(7 downto 0));
end component;
 
component dist_mem_gen_1 is
Port  ( clk: in std_logic;
       a : in std_logic_vector(13 downto 0);
       spo: out std_logic_vector(7 downto 0));
end component;

component dist_mem_gen_2 is
Port (clk: in std_logic;
      a : in std_logic_vector(13 downto 0);
      d: in std_logic_vector(15 downto 0);
      we: in std_logic;
      spo : out std_logic_vector(15 downto 0));
end component;

signal counter,index,mult_done,write,idc: integer:=0;
signal rows,cols : integer:=0;
signal last : std_logic := '0';
signal first,second: std_logic_vector(7 downto 0); -- to store the elements to multiply
signal ad1,ad2,adram: std_logic_vector(13 downto 0):="00000000000000"; -- addresses
signal element,stored: std_logic_vector(15 downto 0):="0000000000000000";
signal we: std_logic:= '0';
signal re: std_logic:= '1';
signal acc,product: std_logic_vector(15 downto 0):="0000000000000000";
signal sel : std_logic_vector(0 to 13);

begin
UUT1: dist_mem_gen_0 port map(clk => clk,a => ad1,spo => first); -- element from first matrix
UUT2: dist_mem_gen_1 port map(clk => clk,a => ad2,spo => second); -- element from second matrix
UUT3: selection port map(v=>v,adram=>adram,we=>we,res=>sel);
UUT4: dist_mem_gen_2 port map(clk => clk,a=>sel,d=>element,we=>we,spo => stored);
UUT5: all_display_4_bits port map(clk=>clk,sw=>stored,seg=>seg,an=>an);

process (clk)
begin
if rising_edge(clk) then    
    if we = '1' and re = '0' then
        if write = 0 then
            ad1 <= std_logic_vector(to_unsigned(rows,14));
            ad2 <= std_logic_vector(to_unsigned(128*cols,14));
            write <= 1;
        elsif write<5 then
            write <= write + 1;
        elsif write = 5 then
            write <= 0;
            re <= '1';
            we <= '0';
            if adram/="11111111111111" then
                adram <= std_logic_vector(to_unsigned(128*cols+rows,14));
            end if;
        end if;
    end if;
    
    if mult_done = 16384 and last = '0' then
        if index = 128 then
            if idc = 0 then
                element <= product; 
--                mult_done <= mult_done+1;
                cols <= cols + 1;
                idc <= 1;
            elsif idc<5 then
                idc <= idc + 1;
            elsif idc = 5 then
                idc <= 0;
                product <= "0000000000000000";
                acc <= "0000000000000000";
                we <= '1';
                re <= '0';
                index <= 0;
                if cols = 128 then
                    cols <= 0;
                    rows <= rows + 1;
                end if;
                last<='1';
            end if;
        elsif index/= 0 and index < 128 then
            if counter = 0 then
                counter <= 1;
                acc <= std_logic_vector(unsigned(first)*unsigned(second));
                ad1 <= ad1 + "00000010000000";
                ad2 <= ad2 + "00000000000001";
            elsif counter<5 then
                counter <= counter + 1;
            elsif counter = 5 then
                product <= product + acc;
                counter <= counter + 1;
            elsif counter < 10 then
                counter <= counter + 1;
            elsif counter = 10 then
                counter <= 0;
                index <= index + 1;
            end if;
        elsif index = 0 then
            if counter = 0 then
                ad1 <= "00000001111111";
                ad2 <= "11111110000000";
            elsif counter = 1 then
                counter <= counter + 1;
                acc <= std_logic_vector(unsigned(first)*unsigned(second));
                ad1 <= ad1 + "00000010000000";
                ad2 <= ad2 + "00000000000001";
            elsif counter<5 then
                counter <= counter + 1;
            elsif counter = 5 then
                product <= product + acc;
                counter <= counter + 1;
            elsif counter < 10 then
                counter <= counter + 1;
            elsif counter = 10 then
                counter <= 0;
                index <= index + 1;
            end if;
        end if;
    end if;
    
    if mult_done<16384 and we = '0' and re = '1' then 
        if index = 128 then
            if idc = 0 then
                element <= product; 
                mult_done <= mult_done+1;
                cols <= cols + 1;
                idc <= 1;
            elsif idc<5 then
                idc <= idc + 1;
            elsif idc = 5 then
                idc <= 0;
                product <= "0000000000000000";
                acc <= "0000000000000000";
                we <= '1';
                re <= '0';
                index <= 0;
                if cols = 128 then
                    cols <= 0;
                    rows <= rows + 1;
                end if;
            end if;
        elsif index < 128 then
            if counter = 0 then
                counter <= 1;
                acc <= std_logic_vector(unsigned(first)*unsigned(second));
                ad1 <= ad1 + "00000010000000";
                ad2 <= ad2 + "00000000000001";
            elsif counter<5 then
                counter <= counter + 1;
            elsif counter = 5 then
                product <= product + acc;
                counter <= counter + 1;
            elsif counter < 10 then
                counter <= counter + 1;
            elsif counter = 10 then
                counter <= 0;
                index <= index + 1;
            end if;
        end if;
    end if;    
end if;
end process;

end Behavioral;