library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity es4_ta_lab6 is
    port(
        a : in unsigned(3 downto 0);
        b : in unsigned(3 downto 0);
        s : in std_logic_vector(1 downto 0);
        anodes : out std_logic_vector(1 downto 0);
        segments : out std_logic_vector(6 downto 0)
    );
end es4_ta_lab6;

architecture synth of es4_ta_lab6 is
    -- components
    component SB_HFOSC is
        generic (
            CLKHF_DIV : String := "0b00"
        );
        port (
            CLKHFPU : in std_logic := 'X';
            CLKHFEN : in std_logic := 'X';
            CLKHF : out std_logic := 'X'
        );
    end component;
    component alu is
        port (
            a : in unsigned(3 downto 0);
            b : in unsigned(3 downto 0);
            s : in std_logic_vector(1 downto 0);
            y : out unsigned(5 downto 0)
        );
    end component;
    component dddd is
        port (
            value : in unsigned(5 downto 0);
            s : in std_logic;
            anodes : out std_logic_vector(1 downto 0);
            segments : out std_logic_vector(6 downto 0)
        );
    end component;

    -- signals
    signal clk : std_logic;
    signal counter : unsigned(26 downto 0) := (others => '0');

    signal value : unsigned(5 downto 0);

begin
    -- counter/timer control
    osc : SB_HFOSC generic map (CLKHF_DIV => "0b00")
                   port map (CLKHFPU => '1',
                             CLKHFEN => '1',
                             CLKHF => clk);

    process (clk) is
        begin
            if rising_edge(clk) then
                counter <= counter + 1;
            end if;
        end process;

    -- input/alu control
    math : alu port map (a => a, b => b, s => s, y => value);

    -- dddd control
    disp : dddd port map (value => value,
                          s => counter(25),
                          anodes => anodes,
                          segments => segments);
end;
