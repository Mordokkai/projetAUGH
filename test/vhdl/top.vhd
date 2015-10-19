library ieee;
use ieee.std_logic_1164.all;

entity top is
	port (
		clock : in  std_logic;
		reset : in  std_logic;
		start : in  std_logic;
		stdout_ack : in  std_logic;
		stdin_ack : in  std_logic;
		stdout_data : out std_logic_vector(7 downto 0);
		stdout_rdy : out std_logic;
		stdin_data : in  std_logic_vector(7 downto 0);
		stdin_rdy : out std_logic
	);
end top;

architecture augh of top is

	-- Declaration of components

	component output is
		port (
			wa0_addr : in  std_logic;
			wa0_en : in  std_logic;
			ra0_addr : in  std_logic;
			wa0_data : in  std_logic_vector(7 downto 0);
			clk : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0)
		);
	end component;

	component input is
		port (
			wa0_addr : in  std_logic_vector(1 downto 0);
			wa0_en : in  std_logic;
			ra0_addr : in  std_logic_vector(1 downto 0);
			wa0_data : in  std_logic_vector(7 downto 0);
			clk : in  std_logic;
			ra0_data : out std_logic_vector(7 downto 0)
		);
	end component;

	component add_3 is
		port (
			output : out std_logic_vector(7 downto 0);
			in_a : in  std_logic_vector(7 downto 0);
			in_b : in  std_logic_vector(7 downto 0)
		);
	end component;

	component fsm_4 is
		port (
			clock : in  std_logic;
			reset : in  std_logic;
			in1 : in  std_logic;
			in2 : in  std_logic;
			in0 : in  std_logic;
			out0 : out std_logic;
			out3 : out std_logic;
			out4 : out std_logic;
			out8 : out std_logic;
			out9 : out std_logic;
			out11 : out std_logic;
			out13 : out std_logic;
			out17 : out std_logic;
			out19 : out std_logic;
			out21 : out std_logic;
			out22 : out std_logic;
			out23 : out std_logic;
			out25 : out std_logic;
			out27 : out std_logic;
			out30 : out std_logic;
			in3 : in  std_logic;
			in4 : in  std_logic
		);
	end component;

	component cmp_26 is
		port (
			eq : out std_logic;
			in1 : in  std_logic_vector(7 downto 0);
			in0 : in  std_logic_vector(7 downto 0)
		);
	end component;

	-- Declaration of signals

	signal sig_clock : std_logic;
	signal sig_reset : std_logic;
	signal sig_start : std_logic;
	signal sig_27 : std_logic;
	signal sig_28 : std_logic;
	signal sig_29 : std_logic;
	signal sig_30 : std_logic;
	signal sig_31 : std_logic;
	signal sig_32 : std_logic;
	signal sig_33 : std_logic;
	signal sig_34 : std_logic;
	signal sig_35 : std_logic;
	signal sig_36 : std_logic;
	signal sig_37 : std_logic;
	signal sig_38 : std_logic;
	signal sig_39 : std_logic;
	signal sig_40 : std_logic;
	signal sig_41 : std_logic;
	signal sig_42 : std_logic_vector(7 downto 0);
	signal sig_43 : std_logic_vector(7 downto 0);
	signal sig_44 : std_logic_vector(7 downto 0);
	signal sig_45 : std_logic_vector(1 downto 0);
	signal augh_test_0 : std_logic;
	signal augh_test_1 : std_logic;

	-- Other inlined components

	signal mux_13 : std_logic_vector(7 downto 0);
	signal mux_17 : std_logic_vector(1 downto 0);
	signal bidon_inter : std_logic_vector(7 downto 0) := (others => '0');
	signal bidon_in1 : std_logic_vector(7 downto 0) := (others => '0');
	signal bidon_in2 : std_logic_vector(7 downto 0) := (others => '0');
	signal mux_22 : std_logic_vector(7 downto 0);
	signal mux_12 : std_logic_vector(2 downto 0);

	-- This utility function is used for inlining MUX behaviour

	-- Little utility function to ease concatenation of an std_logic
	-- and explicitely return an std_logic_vector
	function repeat(N: natural; B: std_logic) return std_logic_vector is
		variable result: std_logic_vector(N-1 downto 0);
	begin
		result := (others => B);
		return result;
	end;

begin

	-- Instantiation of components

	output_i : output port map (
		wa0_addr => sig_38,
		wa0_en => sig_37,
		ra0_addr => sig_41,
		wa0_data => mux_22,
		clk => sig_clock,
		ra0_data => stdout_data
	);

	input_i : input port map (
		wa0_addr => sig_45,
		wa0_en => sig_40,
		ra0_addr => mux_17,
		wa0_data => stdin_data,
		clk => sig_clock,
		ra0_data => sig_43
	);

	add_3_i : add_3 port map (
		output => sig_42,
		in_a => bidon_inter,
		in_b => sig_44
	);

	fsm_4_i : fsm_4 port map (
		clock => sig_clock,
		reset => sig_reset,
		in1 => stdin_ack,
		in2 => augh_test_1,
		in0 => stdout_ack,
		out0 => stdout_rdy,
		out3 => sig_41,
		out4 => sig_40,
		out8 => sig_39,
		out9 => sig_38,
		out11 => sig_37,
		out13 => sig_36,
		out17 => sig_35,
		out19 => sig_34,
		out21 => sig_33,
		out22 => sig_32,
		out23 => sig_31,
		out25 => sig_30,
		out27 => sig_29,
		out30 => sig_28,
		in3 => augh_test_0,
		in4 => sig_start
	);

	cmp_26_i : cmp_26 port map (
		eq => sig_27,
		in1 => sig_43,
		in0 => "00000001"
	);

	-- Behaviour of component 'mux_13' model 'mux'
	mux_13 <=
		(repeat(8, sig_32) and bidon_in2) or
		(repeat(8, sig_31) and bidon_in1) or
		(repeat(8, sig_34) and sig_42);

	-- Behaviour of component 'mux_17' model 'mux'
	mux_17 <=
		(repeat(2, sig_30) and "01") or
		(repeat(2, sig_35) and "11");

	-- Behaviour of component 'mux_22' model 'mux'
	mux_22 <=
		(repeat(8, sig_36) and sig_42) or
		(repeat(8, sig_38) and "10011010");

	-- Behaviour of component 'mux_12' model 'mux'
	mux_12 <=
		(repeat(3, sig_34) and "101") or
		(repeat(3, sig_36) and "001");

	-- Behaviour of all components of model 'reg'
	-- Registers with clock = sig_clock and no reset
	process(sig_clock)
	begin
		if rising_edge(sig_clock) then
			if sig_33 = '1' then
				bidon_inter <= mux_13;
			end if;
			if sig_28 = '1' then
				bidon_in1 <= sig_43;
			end if;
			if sig_29 = '1' then
				bidon_in2 <= sig_43;
			end if;
		end if;
	end process;

	-- Remaining signal assignments
	-- Those who are not assigned by component instantiation

	sig_clock <= clock;
	sig_reset <= reset;
	sig_start <= start;
	sig_44 <= "00000" & mux_12;
	sig_45 <= '0' & sig_39;
	augh_test_0 <= sig_27;
	augh_test_1 <= sig_27;

	-- Remaining top-level ports assignments
	-- Those who are not assigned by component instantiation

	stdin_rdy <= sig_40;

end architecture;
