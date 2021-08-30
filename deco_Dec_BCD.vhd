library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity deco_Dec_BCD is
	Port ( entrada: in std_logic_vector(9 downto 0);
		    salida : out std_logic_vector(3 downto 0));
end deco_Dec_BCD;

architecture solution of deco_Dec_BCD is
Begin
	With entrada Select
		Salida <= 	"0001" when "0000000010",
						"0010" when "0000000100",
						"0011" when "0000001000",
						"0100" when "0000010000",
						"0101" when "0000100000",
						"0110" when "0001000000",
						"0111" when "0010000000",
						"1000" when "0100000000",
						"1001" when "1000000000",
						"0000" when others;
end solution;