library ieee;
use ieee.std_logic_1164.all;

entity RF is
port(
		clk : in std_logic;
		rst : in std_logic;
		Write_En : in std_logic;
		Read_En : in std_logic;
		Write_Data : in std_logic_vector(15 downto 0);
		Read_Data : out std_logic_vector(15 downto 0);
		In_select : in std_logic_vector(2 downto 0);
		Out_select : in std_logic_vector(2 downto 0)
		);

end entity;

architecture Wrk of RF is

type RegisterSet is  array(0 to 7) of std_logic_vector(15 downto 0);
signal RegisterNo : RegisterSet:=(0 => x"0000", 1 => x"0111", others => x"0101") ;

begin
process(clk,rst,Read_En,Write_En,Write_Data,In_select,Out_select)
--variable index : unsigned(2 downto 0);
begin
	if(clk'event and clk='1' and rst = '0') then
		if(Read_En = '1') then
				case Out_select is
				  when "000" => 	
				  Read_Data <= RegisterNo(0) ;
				  
				  when "001" =>
				  Read_Data <= RegisterNo(1) ;
				  
				  when "010" =>
				  Read_Data <= RegisterNo(2) ;
				  
				  when "011" =>
				  Read_Data <= RegisterNo(3) ;
				  
				  when "100" =>
				  Read_Data <= RegisterNo(4) ;
				  
				  when "101" =>
				  Read_Data <= RegisterNo(5) ;
				  
				  when "110" =>
				  Read_Data <= RegisterNo(6) ;
				  
				  when "111" =>
				  Read_Data <= RegisterNo(7) ;
				  
				  when others => null;
				end case ;

		elsif(Write_En = '1') then
				case In_select is
				 when "000" =>
				 RegisterNo(0) <= Write_Data ;
				 
				 when "001" =>
				 RegisterNo(1) <= Write_Data ;
				 
				 when "010" =>
				 RegisterNo(2) <= Write_Data ;
				 
				 when "011" =>
				 RegisterNo(3) <= Write_Data ;
				 
				 when "100" =>
				 RegisterNo(4) <= Write_Data ;
				 
				 when "101" =>
				 RegisterNo(5) <= Write_Data ;
				 
				 when "110" =>
				 RegisterNo(6) <= Write_Data ;
				 
				 when "111" =>
				 RegisterNo(7) <= Write_Data; 
				 
				 when others => null;
			
			end case;
							 
	end if;
	
end if;
end process;
end Wrk;