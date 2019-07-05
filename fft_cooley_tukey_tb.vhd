--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:54:22 06/29/2019
-- Design Name:   
-- Module Name:   D:/VHDL_PRACTICES/FPGA_final_proj/test4/fft_cooley_tukey_tb.vhd
-- Project Name:  test4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Parallel_FFT
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
use work.fft_package.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY fft_cooley_tukey_tb IS
END fft_cooley_tukey_tb;
 
ARCHITECTURE behavior OF fft_cooley_tukey_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Parallel_FFT
    PORT(
         x : IN  signed_vector;
		 debug1 : out comp_array;
		 debug2 : out comp_array;
		 debug3 : out comp_array;
		 debug4 : out comp_array;
		 debug5 : out comp_array;
         y : OUT  comp_array
        );
    END COMPONENT;
    

   --Inputs
   signal x : signed_vector := (others => 0.0);

 	--Outputs
   signal    y : comp_array;
	signal	 debug1 :  comp_array;
	signal	 debug2 :  comp_array;
	signal	 debug3 :  comp_array;
	signal	 debug4 :  comp_array;
	signal	 debug5 :  comp_array;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Parallel_FFT PORT MAP (
          x => x,
			 debug1 => debug1,
			 debug2 => debug2,
			 debug3 => debug3,
			 debug4 => debug4,
			 debug5 => debug5,
          y => y
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


      -- insert stimulus here 
		
--		x<=(X"05",
--		X"0A",
--		X"0F",
--		X"14",
--		X"19",
--		X"1E",
--		X"23",
--		X"28",
--		X"2D",
--		X"32",
--		X"37",
--		X"3C",
--		X"41",
--		X"46",
--		X"4B",
--		X"50"
--		);

		x<=(1.0,
		2.0,
		3.0,
		4.0,
		5.0,
		6.0,
		7.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0,
		0.0
		);
--
      wait;
   end process;

END;
