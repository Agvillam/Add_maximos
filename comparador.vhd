--2-input n-bit comparator
--https://vasanza.blogspot.com

--Library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--Entity
Entity comparador is
	generic ( n: integer :=8);--<-- nbits
	Port(
		A: in std_logic_vector(n-1 downto 0);
		B: in std_logic_vector(n-1 downto 0);
		AmenorB, AmayorB, AigualB: out std_logic);
end comparador;

--Architecture
Architecture solve of comparador is
	-- Signals,Constants,Variables,Components
	signal U,D: integer;
	Begin
		U<=conv_integer(A);
		D<=conv_integer(B);
		AmenorB<='1' when U<D else '0';
		AmayorB<='1' when U>D else '0';
		AigualB<='1' when U=D else '0';
end solve;