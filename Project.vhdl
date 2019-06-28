library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.Gates.all;

entity Project is
   port (add : in std_logic_vector(15 downto 0); clk,r: in std_logic);
end entity;

architecture Behave of Project is
  signal q4, q3, q2, q1, q0, mem_wr, rf_wren, rf_rden, alu_opcode, alu_c, alu_z, check1: std_logic;
  signal mem_add, mem_datin, mem_datout, rf_wr, rf_rd, ip, ir, op1, op2, alu_out, t1rd, t2rd,t3rd: std_logic_vector(15 downto 0);
  signal rf_insel, rf_outsel: std_logic_vector(2 downto 0);
  signal cz: std_logic_vector(1 downto 0);
  signal opcode: std_logic_vector(3 downto 0);
  signal counter1 : integer;
  signal reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7: std_logic_vector(15 downto 0);
  
  component Memory_asyncread_syncwrite is 
	port (address,Mem_datain: in std_logic_vector(15 downto 0); clk,Mem_wrbar: in std_logic;
				Mem_dataout: out std_logic_vector(15 downto 0));
	end component;
	
	component RF is
port(
		clk : in std_logic;
		rst : in std_logic;
		Write_En : in std_logic;
		Read_En : in std_logic;
		Write_Data : in std_logic_vector(15 downto 0);
		Read_Data : out std_logic_vector(15 downto 0);
		In_select : in std_logic_vector(2 downto 0);
		Out_select : in std_logic_vector(2 downto 0);
		O0,O1,O2,O3,O4,O5,O6,O7: out std_logic_vector(15 downto 0)
		);

end component;

	component ALU is
port( 
	input_vectorf1 : in std_logic_vector(15 downto 0);
	input_vectorf2 : in std_logic_vector(15 downto 0);
	Op_select : in std_logic; --0-Add 1-Nand
	output_vectorf : out std_logic_vector(15 downto 0);
	Carry_flag : out std_logic;
	Zero_flag : out std_logic
		);

end component ALU;

begin

Mem1: Memory_asyncread_syncwrite
	  port map(address => mem_add, Mem_datain => mem_datin, Mem_dataout => mem_datout, clk => clk, Mem_wrbar => mem_wr); 
	  
	  
Rf1: RF
	  port map(clk => clk, rst => r , Write_En => rf_wren, Read_en => rf_rden, Write_Data => rf_wr, Read_Data => rf_rd, In_select => rf_insel, Out_select => rf_outsel,
	  O0 => reg0, O1 => reg1, O2 => reg2,O3 => reg3, O4 => reg4, O5 => reg5, O6 => reg6,O7 => reg7);
     
Alu1: ALU
	  port map(input_vectorf1 => op1, input_vectorf2 => op2, Op_select => alu_opcode, output_vectorf => alu_out, Carry_flag => alu_c, Zero_flag => alu_z);
	  

  process(r,q4,q3,q2,q1,q0,clk,ip,ir)
     -- current state.
     variable q_var : std_logic_vector(4 downto 0);
     -- output
     variable y_var, n_check1: std_logic;
     -- next-state
     variable nq_var : std_logic_vector(4 downto 0);
	  variable counter : integer;
	  variable  t1, t2, t3, t4 ,tdummy: std_logic_vector(15 downto 0);
	  
  begin
     q_var(4) := q4; q_var(3) := q3; q_var(2) := q2; q_var(1) := q1; q_var(0) := q0;
     nq_var := q_var; y_var := '0'; n_check1 := check1; 
	  
	  if (r='1') then
	  --The address below is the starting address of all instruction pointers in memory
		ip <= "0000000000000000";
		t4 := "0000000000000000";
		cz <= "00";
		n_check1 := '0';
		counter := 0;
	  end if;
	  
	  
	  -- compute next-state, output
     case q_var is
       when "00000" =>
			if (r = '0') then
			ip <= t4;
			mem_wr <= '1';			
			mem_add <= ip;
			if (check1 = '0') then
				ir <= mem_datout;
				n_check1 := '1';
			end if;
			opcode <= ir(15 downto 12);
			if (opcode = "1100") then
			nq_var := "00010";
			elsif (opcode ="1000" or opcode = "1001") then
			nq_var := "10100";
			else 
			nq_var := "00001";
			end if;
			end if;
		 when "00001" =>
		 
			op1 <= ip;
			op2 <= "0000000000000001";
			alu_opcode <= '0';
			t4 := alu_out;
			if ((ir(1 downto 0)="10" and cz(1) = '0' and (opcode="0000" or opcode="0010")) or (ir(1 downto 0)="01" and cz(0) = '0' and (opcode="0000" or opcode="0010")) or (ir(1 downto 0)="11" and (opcode="0000" or opcode="0010")) or opcode="1100") then
				nq_var := "00000";
				n_check1 := '0';
			elsif (opcode="0011") then
				nq_var := "01001";
			elsif (opcode="0100") then
				nq_var := "00011";
			else
				nq_var := "00010";
			end if;
			
			
			
		 when "00010" =>
			ip <= t4;
			rf_rden <= '1';
			rf_wren <= '0';
			t1 := rf_rd;
			rf_outsel <= ir(11 downto 9);
			counter := 0;
			if (opcode = "0001") then
				nq_var := "00110";
			elsif (opcode ="0110") then
				nq_var := "01100";
			elsif (opcode = "0111") then
				nq_var := "10001";
			else			
				nq_var := "00011";
			end if;
			
		when "00011" =>
		
			ip <= t4;
			rf_rden <= '1';
			rf_wren <= '0';
			t2 := rf_rd;
			rf_outsel <= ir(8 downto 6);
			
			
			if (opcode = "0010") then 
				nq_var := "01000";
			elsif (opcode ="0100") then
				nq_var := "01011";
			elsif (opcode = "0101") then
				nq_var := "01011";
			elsif (opcode ="1001") then
				nq_var := "10110";
			else			
			nq_var := "00100";
			end if;
			
		when "00100" =>
			
			op1 <= t1;
			if(opcode = "1100") then
			tdummy := t2 xor "1111111111111111";
			op2 <= std_logic_vector(unsigned(tdummy) + 1);
			else
			op2 <= t2;
			end if;
			
			alu_opcode <= '0';
			t3 := alu_out;
			cz(1) <= alu_c;
			cz(0) <= alu_z;
			
			if (opcode="1100" and cz(0)='0') then
				nq_var := "00001";
			elsif (opcode="1100" and cz(0)='1') then
				nq_var := "10111";
			else 
			nq_var := "00101";
			end if;
			
		when "00101" =>
		
			rf_rden <= '0';
			rf_wren <= '1';
			rf_wr <= t3;
			rf_insel <= ir(5 downto 3);
			nq_var := "00000";
			n_check1 := '0'; 
			
		when "00110" =>
		
			op1 <= t1;
			if (ir(5)='0') then 
				op2 <= ("0000000000" & ir(5 downto 0));
			else
				op2 <= ("1111111111" & ir(5 downto 0));
			end if;
			
			alu_opcode <= '0';
			t3 := alu_out;
			cz(1) <= alu_c;
			cz(0) <= alu_z;
			nq_var := "00111";
			
		when "00111" =>
		
			rf_rden <= '0';
			rf_wren <= '1';
			rf_wr <= t3;
			rf_insel <= ir(8 downto 6);
			nq_var := "00000";
			n_check1 := '0';
			
		when "01000" =>
		
			op1 <= t1;
			op2 <= t2;
			alu_opcode <= '1';
			t3 := alu_out;
			--Do check this part, not sure about this
			--cz(1) <= alu_c;
			cz(0) <= alu_z;
			nq_var := "00101";
			
		when "01001" =>
			
			ip <= t4;
			t3 := ir(8 downto 0) & "0000000";
			nq_var := "01010";
		
		when "01010" =>
		
			rf_rden <= '0';
			rf_wren <= '1';
			rf_wr <= t3;
			rf_insel <= ir(11 downto 9);
			if t3="0000000000000000" then
				cz(0) <= '1';
			else
				cz(1) <= '0';
			end if;	
			nq_var := "00000";
			n_check1 := '0';
			
		when "01011" =>
		
			op1 <= t2;
			if (ir(5)='0') then 
				op2 <= ("0000000000" & ir(5 downto 0));
			else
				op2 <= ("1111111111" & ir(5 downto 0));
			end if;
			
			alu_opcode <= '0';
			if (opcode = "0100") then
			t1 := alu_out;
			else
			t3 := alu_out;
			end if;
			cz(0) <= alu_z;
			if (opcode="0101") then
				nq_var := "01101";
			else 
			nq_var := "01100";
			end if;
			
		when "01100" =>
		
			mem_wr <= '1';
			mem_add <= t1rd;
			t3 := mem_datout;
			
			--counter := 0;
			if (opcode="0110") then
			nq_var := "01110";
			else
			nq_var := "01010";
			end if;
			
		when "01101" =>
			
			mem_wr <= '0';			
			mem_add <= t3;
			mem_datin <= t1;
			nq_var := "00000";
			n_check1 := '0';
			
		when "01110" =>
			
			rf_rden <= '0';
			rf_wren <= '1';
			rf_wr <= t3;
			rf_insel <= std_logic_vector(to_unsigned(counter1,3));
			counter := counter1+1;
			if (counter=8) then
				nq_var := "00000";
				n_check1 := '0';
			else 
				nq_var := "01111";
			end if;
				
		when "01111" =>
		
			op1 <= t1rd;
			op2 <= "0000000000000001";
			alu_opcode <= '0';
			t1 := alu_out;
			nq_var := "01100";
			
		when "10001" =>
		
			rf_rden <= '1';
			rf_wren <= '0';
			rf_outsel <= std_logic_vector(to_unsigned(counter1,3));
			t3 := rf_rd;
			counter := counter1+1;
			if (counter=9) then
				nq_var := "00000";
				n_check1 := '0';
			else 
				nq_var := "10010";
			end if;
				
		when "10010" =>
		
			mem_wr <= '0';			
			mem_add <= t1;
			mem_datin <= t3;
			nq_var := "10011";
		
		when "10011" =>
		
			op1 <= t1rd;
			op2 <= "0000000000000001";
			alu_opcode <= '0';
			t1 := alu_out;
			nq_var := "10001";
			
			
			
			
		when "10100" =>
			
		   rf_rden <= '0';
			rf_wren <= '1';
			rf_wr <= ip;
			rf_insel <= ir(11 downto 9);
			if (opcode="1000") then
				nq_var := "10101";
			else
				nq_var := "00011";
			end if;
				
		when "10101" =>
		
			op1 <= "0000000" & ir(8 downto 0);
			op2 <= t4;
			alu_opcode <= '0';
			ip <= alu_out;
			nq_var := "00000";
			n_check1 := '0';
			t4 := ip;
			
		when "10110" =>
		
			t4 := t2rd;
			nq_var := "00000";
			n_check1 := '0';
			
		when "10111" =>
		
			op1 <= "0000000000" & ir(5 downto 0);
			op2 <= ip;
			alu_opcode <= '0';
			t4 := alu_out;
			nq_var := "00000";
			n_check1 := '0';
				
				
		 
       when others => null;
     end case;
  
     -- y(k)
     --y <= y_var;
  
     -- q(k+1) = nq(k)
     if(clk'event and clk = '1') then
		    --y <= y_var;
          if(r = '1') then
             q4 <= '0'; q3 <= '0'; q2 <= '0'; q1 <= '0'; q0 <= '0'; check1 <= '0';          else
				 q4 <= nq_var (4);
				 q3 <= nq_var (3);
				 q2 <= nq_var (2);
             q1 <= nq_var (1);
             q0 <= nq_var (0);
				 check1 <= n_check1;
				 t1rd <= t1;
				 t2rd <= t2;
				 t3rd <= t3;
				 counter1 <= counter;
          end if;
			 
     end if;
  end process;

end Behave;