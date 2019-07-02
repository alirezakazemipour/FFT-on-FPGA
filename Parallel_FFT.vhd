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
use std.textio.all;
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

constant w : comp_array2 :=(

("0100000000000000","0000000000000000"),
("0011111110110001","1111100110111010"),
("0011111011000101","1111001110000100"),
("0011110100111111","1110110101101100"),
("0011101100100001","1110011110000010"),
("0011100001110001","1110000111010101"),
("0011010100110111","1101110001110010"),
("0011000101111001","1101011101100110"),
("0010110101000001","1101001010111111"),
("0010100010011010","1100111010000111"),
("0010001110001110","1100101011001001"),
("0001111000101011","1100011110001111"),
("0001100001111110","1100010011011111"),
("0001001010010100","1100001011000001"),
("0000110001111100","1100000100111011"),
("0000011001000110","1100000001001111"),
("0000000000000000","1100000000000000"),
("1111100110111010","1100000001001111"),
("1111001110000100","1100000100111011"),
("1110110101101100","1100001011000001"),
("1110011110000010","1100010011011111"),
("1110000111010101","1100011110001111"),
("1101110001110010","1100101011001001"),
("1101011101100110","1100111010000111"),
("1101001010111111","1101001010111111"),
("1100111010000111","1101011101100110"),
("1100101011001001","1101110001110010"),
("1100011110001111","1110000111010101"),
("1100010011011111","1110011110000010"),
("1100001011000001","1110110101101100"),
("1100000100111011","1111001110000100"),
("1100000001001111","1111100110111010")
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

bf21 : butterfly port map(g1(0),g1(2),w(0),g2(0),g2(1));
bf22 : butterfly port map(g1(1),g1(3),w(2),g2(2),g2(3));
bf23 : butterfly port map(g1(2),g1(4),w(0),g2(4),g2(5));
bf24 : butterfly port map(g1(3),g1(5),w(2),g2(6),g2(7));
bf25 : butterfly port map(g1(4),g1(6),w(0),g2(8),g2(9));
bf26 : butterfly port map(g1(5),g1(7),w(2),g2(10),g2(11));
bf27 : butterfly port map(g1(6),g1(8),w(0),g2(12),g2(13));
bf28 : butterfly port map(g1(7),g1(9),w(2),g2(14),g2(15));
bf29 : butterfly port map(g1(8),g1(10),w(0),g2(16),g2(17));
bf210 : butterfly port map(g1(9),g1(11),w(2),g2(18),g2(19));
bf211 : butterfly port map(g1(10),g1(12),w(0),g2(20),g2(21));
bf212 : butterfly port map(g1(11),g1(13),w(2),g2(22),g2(23));
bf213 : butterfly port map(g1(12),g1(14),w(0),g2(24),g2(25));
bf214 : butterfly port map(g1(13),g1(15),w(2),g2(26),g2(27));
bf215 : butterfly port map(g1(14),g1(16),w(0),g2(28),g2(29));
bf216 : butterfly port map(g1(15),g1(17),w(2),g2(30),g2(31));
bf217 : butterfly port map(g1(16),g1(18),w(0),g2(32),g2(33));
bf218 : butterfly port map(g1(17),g1(19),w(2),g2(34),g2(35));
bf219 : butterfly port map(g1(18),g1(20),w(0),g2(36),g2(37));
bf220 : butterfly port map(g1(19),g1(21),w(2),g2(38),g2(39));
bf221 : butterfly port map(g1(20),g1(22),w(0),g2(40),g2(41));
bf222 : butterfly port map(g1(21),g1(23),w(2),g2(42),g2(43));
bf223 : butterfly port map(g1(22),g1(24),w(0),g2(44),g2(45));
bf224 : butterfly port map(g1(23),g1(25),w(2),g2(46),g2(47));
bf225 : butterfly port map(g1(24),g1(26),w(0),g2(48),g2(49));
bf226 : butterfly port map(g1(25),g1(27),w(2),g2(50),g2(51));
bf227 : butterfly port map(g1(26),g1(28),w(0),g2(52),g2(53));
bf228 : butterfly port map(g1(27),g1(29),w(2),g2(54),g2(55));
bf229 : butterfly port map(g1(28),g1(30),w(0),g2(56),g2(57));
bf230 : butterfly port map(g1(29),g1(31),w(2),g2(58),g2(59));
bf231 : butterfly port map(g1(30),g1(32),w(0),g2(60),g2(61));
bf232 : butterfly port map(g1(31),g1(33),w(0),g2(62),g2(63));



--third stage of butterfly's.

bf31 : butterfly port map(g2(0),g2(4),w(0),g3(0),g3(1));
bf32 : butterfly port map(g2(1),g2(5),w(1),g3(2),g3(3));
bf33 : butterfly port map(g2(2),g2(6),w(2),g3(4),g3(5));
bf34 : butterfly port map(g2(3),g2(7),w(3),g3(6),g3(7));
bf35 : butterfly port map(g2(8),g2(12),w(0),g3(8),g3(9));
bf36 : butterfly port map(g2(9),g2(13),w(1),g3(10),g3(11));
bf37 : butterfly port map(g2(10),g2(14),w(2),g3(12),g3(13));
bf38 : butterfly port map(g2(11),g2(15),w(3),g3(14),g3(15));
bf39 : butterfly port map(g2(16),g2(20),w(0),g3(16),g3(17));
bf310 : butterfly port map(g2(17),g2(21),w(1),g3(18),g3(19));
bf311 : butterfly port map(g2(18),g2(22),w(2),g3(20),g3(21));
bf312 : butterfly port map(g2(19),g2(23),w(3),g3(22),g3(23));
bf313 : butterfly port map(g2(24),g2(28),w(0),g3(24),g3(25));
bf314 : butterfly port map(g2(25),g2(29),w(1),g3(26),g3(27));
bf315 : butterfly port map(g2(26),g2(30),w(2),g3(28),g3(29));
bf316 : butterfly port map(g2(27),g2(31),w(3),g3(30),g3(31));
bf317 : butterfly port map(g2(32),g2(36),w(0),g3(32),g3(33));
bf318 : butterfly port map(g2(33),g2(37),w(1),g3(34),g3(35));
bf319 : butterfly port map(g2(34),g2(38),w(2),g3(36),g3(37));
bf320 : butterfly port map(g2(35),g2(39),w(3),g3(38),g3(39));
bf321 : butterfly port map(g2(40),g2(44),w(0),g3(40),g3(41));
bf322 : butterfly port map(g2(41),g2(45),w(1),g3(42),g3(43));
bf323 : butterfly port map(g2(42),g2(46),w(2),g3(44),g3(45));
bf324 : butterfly port map(g2(43),g2(47),w(3),g3(46),g3(47));
bf325 : butterfly port map(g2(48),g2(52),w(0),g3(48),g3(49));
bf326 : butterfly port map(g2(49),g2(53),w(1),g3(50),g3(51));
bf327 : butterfly port map(g2(50),g2(54),w(2),g3(52),g3(53));
bf328 : butterfly port map(g2(51),g2(55),w(3),g3(54),g3(55));
bf329 : butterfly port map(g2(56),g2(60),w(0),g3(56),g3(57));
bf330 : butterfly port map(g2(57),g2(61),w(1),g3(58),g3(59));
bf331 : butterfly port map(g2(58),g2(62),w(2),g3(60),g3(61));
bf332 : butterfly port map(g2(59),g2(63),w(3),g3(62),g3(63))

----fourth stage of butterfly's.
--
--stage4: for i in 0 to 55 generate
--
--bf4i: butterfly port map(g3(i),g3(i+8),w(i mod 8),g4(i),g4(i+8));
--
--end generate;
--
----fifth stage of butterfly's.
--
--stage5: for i in 0 to 47 generate
--
--bf5i: butterfly port map(g4(i),g4(i+16),w(i mod 16),g5(i),g5(i+8));
--
--end generate;
--
----sixth stage of butterfly's.
--
--stage6: for i in 0 to 31 generate
--
--bf6i: butterfly port map(g5(i),g5(i+32),w(i mod 32),y(i),y(i+32));
--
--end generate;



end Behavioral;

