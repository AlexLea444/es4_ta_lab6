library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity digits is
    port (
        value : in unsigned(5 downto 0);
        onesdigit : out unsigned(3 downto 0);
        tensdigit : out unsigned(3 downto 0)
    );
end digits;

architecture synth of digits is
    -- signals
    signal tensplace : unsigned(12 downto 0);

begin
    onesdigit <= value mod 4d"10";
    tensplace <= value * 7d"52";
    tensdigit <= tensplace(12 downto 9);
end;

