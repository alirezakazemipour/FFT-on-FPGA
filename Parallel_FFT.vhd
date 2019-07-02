----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:24:24 06/29/2019 
-- Design Name: 
-- Module Name:    Parallel_FFT - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use work.fft_package.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Parallel_FFT is
port ( x: in signed_vector;
		 y : out comp_array);

end Parallel_FFT;

architecture Behavioral of Parallel_FFT is

component real_input_to_complex is

port ( input_real : in signed_vector;
		 input_comp : out comp_array);

end component;		


component butterfly is

port(
		c1,c2 : complex; --inputs
		w : complex;		--phase factor
		g1,g2 : out complex --outputs
		);
 
end component;

constant w : comp_array := (
("0100000000000000", "0000000000000000"),
("0011101100100001", "1110011110000010"),
("0010110101000001", "1101001010111111"),
("0001100001111110", "1100010011011111"),
("0000000000000000", "1100000000000000"),
("1110011110000010", "1100010011011111"),
("1101001010111111", "1101001010111111"),
("1100010011011111", "1110011110000010"),
("1100000000000000", "0000000000000000"),
("1100010011011111", "0001100001111110"),
("1101001010111111", "0010110101000001"),
("1110011110000010", "0011101100100001"),
("0000000000000000", "0100000000000000"),
("0001100001111110", "0011101100100001"),
("0010110101000001", "0010110101000001"),
("0011101100100001", "0001100001111110")
);


signal s, g1, g2, g3, g4, g5 : comp_array := ( others => ("0000000000000000","0000000000000000"));

begin

--Real input value transformed in complex value

sixteen_bits_complex_transform : real_input_to_complex port map(x, s);

--first stage of butterfly's.
bf11 : butterfly port map(s(0),s(32),w(0),g1(0),g1(1));
bf12 : butterfly port map(s(16),s(48),w(0),g1(2),g1(3));
bf13 : butterfly port map(s(8),s(40),w(0),g1(4),g1(5));
bf14 : butterfly port map(s(24),s(56),w(0),g1(6),g1(7));
bf15 : butterfly port map(s(4),s(36),w(0),g1(8),g1(9));
bf16 : butterfly port map(s(20),s(52),w(0),g1(10),g1(11));
bf17 : butterfly port map(s(12),s(44),w(0),g1(12),g1(13));
bf18 : butterfly port map(s(28),s(60),w(0),g1(14),g1(15));
bf19 : butterfly port map(s(2),s(34),w(0),g1(16),g1(17));
bf110 : butterfly port map(s(18),s(50),w(0),g1(18),g1(19));
bf111 : butterfly port map(s(10),s(42),w(0),g1(20),g1(21));
bf112 : butterfly port map(s(26),s(58),w(0),g1(22),g1(23));
bf113 : butterfly port map(s(6),s(38),w(0),g1(24),g1(25));
bf114 : butterfly port map(s(22),s(54),w(0),g1(26),g1(27));
bf115 : butterfly port map(s(14),s(46),w(0),g1(28),g1(29));
bf116 : butterfly port map(s(30),s(62),w(0),g1(30),g1(31));
bf117 : butterfly port map(s(1),s(33),w(0),g1(32),g1(33));
bf118 : butterfly port map(s(17),s(49),w(0),g1(34),g1(35));
bf119 : butterfly port map(s(9),s(41),w(0),g1(36),g1(37));
bf120 : butterfly port map(s(25),s(57),w(0),g1(38),g1(39));
bf121 : butterfly port map(s(5),s(37),w(0),g1(40),g1(41));
bf122 : butterfly port map(s(21),s(53),w(0),g1(42),g1(43));
bf123 : butterfly port map(s(13),s(45),w(0),g1(44),g1(45));
bf124 : butterfly port map(s(29),s(61),w(0),g1(46),g1(47));
bf125 : butterfly port map(s(3),s(35),w(0),g1(48),g1(49));
bf126 : butterfly port map(s(19),s(51),w(0),g1(50),g1(51));
bf127 : butterfly port map(s(11),s(43),w(0),g1(52),g1(53));
bf128 : butterfly port map(s(27),s(59),w(0),g1(54),g1(55));
bf129 : butterfly port map(s(7),s(39),w(0),g1(56),g1(57));
bf130 : butterfly port map(s(23),s(55),w(0),g1(58),g1(59));
bf131 : butterfly port map(s(15),s(47),w(0),g1(60),g1(61));
bf132 : butterfly port map(s(31),s(63),w(0),g1(62),g1(63));



--second stage of butterfly's.
stage2: for i in 0 to 61 generate

stage2_cond1: if i mod 2 = 0 generate
bf2i: butterfly port map(g1(i),g1(i+2),w(0),g2(i),g2(i+2));
end generate;

stage2_cond2: if i mod 2 = 0 generate
bf2i: butterfly port map(g1(i),g1(i+2),w(2),g2(i),g2(i+2));
end generate;

end generate;

--third stage of butterfly's.
bf31 : butterfly port map(g2(0),g2(4),w(0),g3(0),g3(4));
bf32 : butterfly port map(g2(1),g2(5),w(1),g3(1),g3(5));
bf33 : butterfly port map(g2(2),g2(6),w(2),g3(2),g3(6));
bf34 : butterfly port map(g2(3),g2(7),w(3),g3(3),g3(7));
bf35 : butterfly port map(g2(8),g2(12),w(0),g3(8),g3(12));
bf36 : butterfly port map(g2(9),g2(13),w(1),g3(9),g3(13));
bf37 : butterfly port map(g2(10),g2(14),w(2),g3(10),g3(14));
bf38 : butterfly port map(g2(11),g2(15),w(3),g3(11),g3(15));

--fourth stage of butterfly's.
bf41 : butterfly port map(g3(0),g3(8),w(0),y(0),y(8));
bf42 : butterfly port map(g3(1),g3(9),w(1),y(1),y(9));
bf43 : butterfly port map(g3(2),g3(10),w(2),y(2),y(10));
bf44 : butterfly port map(g3(3),g3(11),w(3),y(3),y(11));
bf45 : butterfly port map(g3(4),g3(12),w(4),y(4),y(12));
bf46 : butterfly port map(g3(5),g3(13),w(5),y(5),y(13));
bf47 : butterfly port map(g3(6),g3(14),w(6),y(6),y(14));
bf48 : butterfly port map(g3(7),g3(15),w(7),y(7),y(15));


end Behavioral;

