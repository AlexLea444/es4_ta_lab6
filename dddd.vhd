library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dddd is
    port(
        value : in unsigned(5 downto 0);
        s : in std_logic;
        anodes : out std_logic_vector(1 downto 0);
        segments : out std_logic_vector(6 downto 0)
    );
end dddd;

architecture synth of dddd is
    -- components
    component sevenseg is
        port (
            S : in unsigned(3 downto 0);
            segments : out std_logic_vector(6 downto 0)
        );
    end component;
    component digits is
        port (
            value : in unsigned(5 downto 0);
            onesdigit : out unsigned(3 downto 0);
            tensdigit : out unsigned(3 downto 0)
        );
    end component;

    -- signals
    signal lowerBCD : unsigned(3 downto 0);
    signal upperBCD : unsigned(3 downto 0);
    signal lowersegs : std_logic_vector(6 downto 0);
    signal uppersegs : std_logic_vector(6 downto 0);

begin
    split : digits port map (value => value,
                             onesdigit => lowerBCD,
                             tensdigit => upperBCD);
    lower : sevenseg port map (S => lowerBCD, segments => lowersegs);
    upper : sevenseg port map (S => upperBCD, segments => uppersegs);

    anodes(0) <= s;
    anodes(1) <= not s;
    segments <= lowersegs when (s = '1') else uppersegs;
end;
