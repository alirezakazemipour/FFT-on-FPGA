----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:03:22 06/29/2019 
-- Design Name: 
-- Module Name:    butterfly - Behavioral 
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
use work.fft_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity butterfly is

port ( 
		c1,c2 : in complex ;--inputs
		w : in complex; -- phase factor
		g1,g2 : out complex --outputs
		);

end butterfly;

architecture Behavioral of butterfly is

signal q1 : complex;

begin

--butterfly equations.

q1	<= mult(c2,w);
g1 <= add(c1,q1);
g2  <= sub(c1,q1);

--g1 <= add(c1,c2);
--q1<= sub(c1,c2);
--g2 <= mult(q1,w);

end Behavioral;

