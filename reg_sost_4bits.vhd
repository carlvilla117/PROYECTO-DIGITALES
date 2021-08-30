library ieee;
use ieee.std_logic_1164.all;

entity reg_sost_4bits is
port (clock, resetn, En: in std_logic;
		Ent: in std_logic_vector(3 downto 0);
		Q: out std_logic_vector(3 downto 0));
end reg_sost_4bits;

architecture desarrollo of reg_sost_4bits is
signal temp: std_logic_vector(3 downto 0);
begin
process(En)
	begin
	if resetn='0' then temp<="0000";
	elsif (clock'event and clock='1') then
		if En='1' then temp<=Ent;
			else temp<=temp;
		end if;
	end  if;
end process;
Q<=temp;
end desarrollo;