library ieee;
use ieee.std_logic_1164.all;

entity Mux2_1_8 is
port( Sel: in std_logic;
		D0, D1: in std_logic_vector (7 downto 0);
		Q: out std_logic_vector (7 downto 0));
end Mux2_1_8;

architecture desarrollo of Mux2_1_8 is
signal temp: std_logic_vector (7 downto 0);
begin
	process(Sel)
	begin
		case Sel is
			when '0' => temp<=D0;
			when others => temp<=D1;
		end case;
	end process;
Q<=temp;
end desarrollo;