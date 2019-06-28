-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  Full-adder.

library ieee;
use ieee.std_logic_1164.all;
entity Bit_adder is
   port( input_vector1: in std_logic_vector(15 downto 0);
	      input_vector2 :in std_logic_vector(15 downto 0);
       	output_vector: out std_logic_vector(16 downto 0));
end entity;

architecture Addition of Bit_adder is
   component Full_Adder is
     port(A,B,Cin: in std_logic;
         	S,Cout: out std_logic);
   end component;
   component Half_Adder is
     port(A,B: in std_logic;
         	S,C: out std_logic);
   end component;
 signal M,N,O,P,Q,E,F,G,H,I,J,L,K,R,T: std_logic;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   haa: Half_Adder 
			port map (
					-- order of inputs Cin B A
					B   => input_vector2(0),
					A   => input_vector1(0),
                                        -- order of outputs S Cout
					S => output_vector(0),
					C => M);
  add_instance_1: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => M,
					B   => input_vector2(1),
					A   => input_vector1(1),
                                        -- order of outputs S Cout
					S => output_vector(1),
					Cout => N);
   add_instance_2: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => N,
					B   => input_vector2(2),
					A   => input_vector1(2),
                                        -- order of outputs S Cout
					S => output_vector(2),
					Cout => O);
  add_instance_3: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => O,
					B   => input_vector2(3),
					A   => input_vector1(3),
                                        -- order of outputs S Cout
					S => output_vector(3),
					Cout => P);
  add_instance_4: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => P,
					B   => input_vector2(4),
					A   => input_vector1(4),
                                        -- order of outputs S Cout
					S => output_vector(4),
					Cout => Q);
  add_instance_5: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => Q,
					B   => input_vector2(5),
					A   => input_vector1(5),
                                        -- order of outputs S Cout
					S => output_vector(5),
					Cout => E);
  add_instance_6: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => E,
					B   => input_vector2(6),
					A   => input_vector1(6),
                                        -- order of outputs S Cout
					S => output_vector(6),
					Cout => F);
  add_instance_7: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => F,
					B   => input_vector2(7),
					A   => input_vector1(7),
                                        -- order of outputs S Cout
					S => output_vector(7),
					Cout => G
					);
					
  add_instance_8: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => G,
					B   => input_vector2(8),
					A   => input_vector1(8),
                                        -- order of outputs S Cout
					S => output_vector(8),
					Cout => H
					);


  add_instance_9: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => H,
					B   => input_vector2(9),
					A   => input_vector1(9),
                                        -- order of outputs S Cout
					S => output_vector(9),
					Cout => I
					);

  add_instance_10: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => I,
					B   => input_vector2(10),
					A   => input_vector1(10),
                                        -- order of outputs S Cout
					S => output_vector(10),
					Cout => J
					);
 
 add_instance_11: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => J,
					B   => input_vector2(11),
					A   => input_vector1(11),
                                        -- order of outputs S Cout
					S => output_vector(11),
					Cout => K
					);

 add_instance_12: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => K,
					B   => input_vector2(12),
					A   => input_vector1(12),
                                        -- order of outputs S Cout
					S => output_vector(12),
					Cout => L
					);

 add_instance_13: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => L,
					B   => input_vector2(13),
					A   => input_vector1(13),
                                        -- order of outputs S Cout
					S => output_vector(13),
					Cout => R
					);
					
 add_instance_14: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => R,
					B   => input_vector2(14),
					A   => input_vector1(14),
                                        -- order of outputs S Cout
					S => output_vector(14),
					Cout => T
					);
					
 add_instance_15: Full_Adder 
			port map (
					-- order of inputs Cin B A
					Cin => T,
					B   => input_vector2(15),
					A   => input_vector1(15),
                                        -- order of outputs S Cout
					S => output_vector(15),
					Cout => output_vector(16)
					);
					
end Addition;

