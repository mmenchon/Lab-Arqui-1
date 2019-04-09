@echo off
set xv_path=D:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xsim Mux_TB_behav -key {Behavioral:sim_1:Functional:Mux_TB} -tclbatch Mux_TB.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
