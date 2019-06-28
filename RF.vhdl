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
		Out_select : in std_logic_vector(2 downto 0);
		O0,O1,O2,O3,O4,O5,O6,O7: out std_logic_vector(15 downto 0));

end entity;

architecture Wrk of RF is

type RegisterSet is  array(0 to 7) of std_logic_vector(15 downto 0);
signal RegisterNo : RegisterSet:=(0 => x"0000", 1 => x"0011", 2 => x"0001",others => x"0000") ;
signal readen,writeen,c0, c1, c2, c3, c4, c5, c6, c7: std_logic_vector(15 downto 0);
type TempSet is  array(0 to 7) of std_logic_vector(15 downto 0);
signal TempNo : TempSet;


begin

c0 <= (others => ((not Out_select(0)) and (not Out_select(1)) and (not Out_select(2))));
c1 <= (others => ((Out_select(0)) and (not Out_select(1)) and (not Out_select(2))));
c2 <= (others => ((not Out_select(0)) and (Out_select(1)) and (not Out_select(2))));
c3 <= (others => ((Out_select(0)) and (Out_select(1)) and (not Out_select(2))));
c4 <= (others => ((not Out_select(0)) and (not Out_select(1)) and (Out_select(2))));
c5 <= (others => ((Out_select(0)) and (not Out_select(1)) and (Out_select(2))));
c6 <= (others => ((not Out_select(0)) and (Out_select(1)) and (Out_select(2))));
c7 <= (others => ((Out_select(0)) and (Out_select(1)) and (Out_select(2))));
readen <= (others => Read_En);

	Read_Data <= (readen and c0 and RegisterNo(0)) or (readen and c1 and RegisterNo(1))
or (readen and c2 and RegisterNo(2)) or (readen and c3 and RegisterNo(3))
or (readen and c4 and RegisterNo(4)) or (readen and c5 and RegisterNo(5))
or (readen and c6 and RegisterNo(6)) or (readen and c7 and RegisterNo(7));

--if(Write_En = '1') then
--	TempNo(0) <= (c0 and Write_Data);
--	TempNo(1) <= (c1 and Write_Data);
--	TempNo(2) <= (c2 and Write_Data);
--	TempNo(3) <= (c3 and Write_Data);
--	TempNo(4) <= (c4 and Write_Data);
--	TempNo(5) <= (c5 and Write_Data);
--	TempNo(6) <= (c6 and Write_Data);
--	TempNo(7) <= (c7 and Write_Data);
--end if;

--
--
--writeen <= (others => Write_En);
--
--TempNo(0) <= (writeen and c0 and Write_Data) or (not(writeen and c0) and RegisterNo(0));
--TempNo(1) <= (writeen and c1 and Write_Data) or (not(writeen and c1) and RegisterNo(1));
--TempNo(2) <= (writeen and c2 and Write_Data) or (not(writeen and c2) and RegisterNo(2));
--TempNo(3) <= (writeen and c3 and Write_Data) or (not(writeen and c3) and RegisterNo(3));
--TempNo(4) <= (writeen and c4 and Write_Data) or (not(writeen and c4) and RegisterNo(4));
--TempNo(5) <= (writeen and c5 and Write_Data) or (not(writeen and c5) and RegisterNo(5));
--TempNo(6) <= (writeen and c6 and Write_Data) or (not(writeen and c6) and RegisterNo(6));
--TempNo(7) <= (writeen and c7 and Write_Data) or (not(writeen and c7) and RegisterNo(7));
--
--RegisterNo(0) <= TempNo(0);
--RegisterNo(1) <= TempNo(1);
--RegisterNo(2) <= TempNo(2);
--RegisterNo(3) <= TempNo(3);
--RegisterNo(4) <= TempNo(4);
--RegisterNo(5) <= TempNo(5);
--RegisterNo(6) <= TempNo(6);
--RegisterNo(7) <= TempNo(7);

process(clk)
--variable index : unsigned(2 downto 0);
begin
	if(clk'event and clk='1' and rst = '0') then
		if(Write_En = '1') then
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

O0 <= RegisterNo(0);
O1 <= RegisterNo(1);
O2 <= RegisterNo(2);
O3 <= RegisterNo(3);
O4 <= RegisterNo(4);
O5 <= RegisterNo(5);
O6 <= RegisterNo(6);
O7 <= RegisterNo(7);

end Wrk;