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


signal s, g1, g2, g3 : comp_array := ( others => ("0000000000000000","0000000000000000"));

begin

--Real input value transformed in complex value

sixteen_bits_complex_transform : real_input_to_complex port map(x, s);

----first stage of butterfly's.
--bf11 : butterfly port map(s(0),s(8),w(0),g1(0),g1(8));
--bf12 : butterfly port map(s(1),s(9),w(1),g1(1),g1(9));
--bf13 : butterfly port map(s(2),s(10),w(2),g1(2),g1(10));
--bf14 : butterfly port map(s(3),s(11),w(3),g1(3),g1(11));
--bf15 : butterfly port map(s(4),s(12),w(4),g1(4),g1(12));
--bf16 : butterfly port map(s(5),s(13),w(5),g1(5),g1(13));
--bf17 : butterfly port map(s(6),s(14),w(6),g1(6),g1(14));
--bf18 : butterfly port map(s(7),s(15),w(7),g1(7),g1(15));
--
----second stage of butterfly's.
--bf21 : butterfly port map(g1(0),g1(4),w(0),g2(0),g2(4));
--bf22 : butterfly port map(g1(1),g1(5),w(2),g2(1),g2(5));
--bf23 : butterfly port map(g1(2),g1(6),w(4),g2(2),g2(6));
--bf24 : butterfly port map(g1(3),g1(7),w(6),g2(3),g2(7));
--bf25 : butterfly port map(g1(8),g1(12),w(0),g2(8),g2(12));
--bf26 : butterfly port map(g1(9),g1(13),w(2),g2(9),g2(13));
--bf27 : butterfly port map(g1(10),g1(14),w(4),g2(10),g2(14));
--bf28 : butterfly port map(g1(11),g1(15),w(6),g2(11),g2(15));
--
----third stage of butterfly's.
--bf31 : butterfly port map(g2(0),g2(2),w(0),g3(0),g3(2));
--bf32 : butterfly port map(g2(1),g2(3),w(4),g3(1),g3(3));
--bf33 : butterfly port map(g2(4),g2(6),w(0),g3(4),g3(6));
--bf34 : butterfly port map(g2(5),g2(7),w(4),g3(5),g3(7));
--bf35 : butterfly port map(g2(8),g2(10),w(0),g3(8),g3(10));
--bf36 : butterfly port map(g2(9),g2(11),w(4),g3(9),g3(11));
--bf37 : butterfly port map(g2(12),g2(14),w(0),g3(12),g3(14));
--bf38 : butterfly port map(g2(13),g2(15),w(4),g3(13),g3(15));
--
----fourth stage of butterfly's.
--bf41 : butterfly port map(g3(0),g3(1),w(0),y(0),y(8));
--bf42 : butterfly port map(g3(2),g3(3),w(0),y(4),y(12));
--bf43 : butterfly port map(g3(4),g3(5),w(0),y(2),y(10));
--bf44 : butterfly port map(g3(6),g3(7),w(0),y(6),y(14));
--bf45 : butterfly port map(g3(8),g3(9),w(0),y(1),y(9));
--bf46 : butterfly port map(g3(10),g3(11),w(0),y(5),y(13));
--bf47 : butterfly port map(g3(12),g3(13),w(0),y(3),y(11));
--bf48 : butterfly port map(g3(14),g3(15),w(0),y(7),y(15));


--first stage of butterfly's.
bf11 : butterfly port map(s(0),s(8),w(0),g1(0),g1(1));
bf12 : butterfly port map(s(4),s(12),w(0),g1(2),g1(3));
bf13 : butterfly port map(s(2),s(10),w(0),g1(4),g1(5));
bf14 : butterfly port map(s(6),s(14),w(0),g1(6),g1(7));
bf15 : butterfly port map(s(1),s(9),w(0),g1(8),g1(9));
bf16 : butterfly port map(s(5),s(13),w(0),g1(10),g1(11));
bf17 : butterfly port map(s(3),s(11),w(0),g1(12),g1(13));
bf18 : butterfly port map(s(7),s(15),w(0),g1(14),g1(15));

--second stage of butterfly's.
bf21 : butterfly port map(g1(0),g1(2),w(0),g2(0),g2(2));
bf22 : butterfly port map(g1(1),g1(3),w(2),g2(1),g2(3));
bf23 : butterfly port map(g1(4),g1(6),w(0),g2(4),g2(6));
bf24 : butterfly port map(g1(5),g1(7),w(2),g2(5),g2(7));
bf25 : butterfly port map(g1(8),g1(10),w(0),g2(8),g2(10));
bf26 : butterfly port map(g1(9),g1(11),w(2),g2(9),g2(11));
bf27 : butterfly port map(g1(12),g1(14),w(0),g2(12),g2(14));
bf28 : butterfly port map(g1(13),g1(15),w(2),g2(13),g2(15));

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

