library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    port (
        a : in unsigned(3 downto 0);
        b : in unsigned(3 downto 0);
        s : in std_logic_vector(1 downto 0);
        y : out unsigned(5 downto 0)
    );
end alu;

architecture synth of alu is
    signal big_a : unsigned(5 downto 0);
    signal big_b : unsigned(5 downto 0);
begin
    big_a <= "00" & a;
    big_b <= "00" & b;
    y <= big_a and big_b when s = "00" else
         big_a or big_b when s = "01" else
         big_a + big_b when s = "10" else
         big_a - big_b;
end;
