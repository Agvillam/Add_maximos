--Library
library ieee;
use ieee.std_logic_1164.all;

--Entity
entity mssf is
	port(
		resetn,clk,start,ingreso,comp_255,cont_max,comp_max_1,comp_max_2_1,comp_max_2_2,cont_lim: in std_logic;
		
		reset_cont,wr,en_cont,en_max_1,en_max_2,s_mux,en_lim,mux_en_new: out std_logic);
end mssf;

--Architecture
architecture solve of mssf is
	-- Signals,Constants,Variables,Components
	type estado is (t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10);
	signal y: estado; 
	begin
	--Process #1: Next state decoder and state memory
	process(resetn,clk)
	--Sequential programming
		begin
			if resetn = '0' then y<= t0;
			elsif (clk'event and clk = '1') then
				case y is
					when t0 => y <=t1;
							
					when t1 =>						  
							if  start = '0'  and comp_255= '1' and ingreso= '1' then y<=t2;
							elsif  start = '1' then y<=t4;
							else y<= t1; end if;	
					when t2 =>
							if cont_max= '1' then y<=t4;
							else y<=t3;end if;
							
					when t3 => y<=t1;
							
					when t4 =>
							if start='1' then y<=t4;
							else y<=t5;end if;
					
					when t5 => y <=t6;
					
					when t6 =>
							if comp_max_1 ='1' then y<=t7;
							elsif comp_max_2_1 = '1' and comp_max_2_2 = '1' then y<=t8;
							else y<=t10;
							end if;
												
					when t7 =>  y <=t9;
					
					when t8 =>  y <=t10;
					
					when t9 =>  y <=t10;
					
					when t10 =>
							if cont_lim = '1' then y<=t1;
							else y<=t5;end if;
					
					
				end case;
			end if;
	end process;
	--Process #2: Output decoder
	process(y)-- mealy ->(y,d,n)
	--Sequential programming
		begin
		reset_cont<='1';
		wr<='0';
		en_cont<='0';
		en_max_1<='0';
		en_max_2<='0';
		en_lim<='0';
		s_mux<='0';
		mux_en_new<='0';
				case y is
				when t0 => reset_cont<='0';
				when t1 =>
				when t2 => wr<='1';
				when t3 => en_cont<='1';
				when t4 => 
				when t5 => s_mux<='1';
				when t6 => s_mux<='1';
				when t7 => mux_en_new<='1';en_max_2<='1';s_mux<='1';
				when t8 => s_mux<='1';en_max_2<='1';
				when t9 => en_max_1<='1';s_mux<='1';
				when t10 => en_lim<='1';s_mux<='1';
			end case;
	end process;
	--Process #n... 
end solve;