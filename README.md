## build.sh
Alex Lea

Requires oss-cad-suite.

I have made some very minor modifications to the build script made by Lucas Polidori.

Here are the requirements for one to use this script:

1. The top module should have the same name as its containing file, and of the program itself.
2. The program name should be consistent across the .vhd and .pcf file.
3. This script uses '.vhd' for vhdl files, not '.vhdl'. This is meant to mirror Lattice Radiant.
4. To improve long-term QoL, set a udev rule to allow access to the UPduino.

To verify ids, use usb-devices. For me, this is the rule as follows:
```bash
$ cat /etc/udev/rules.d/53-lattice-ftdi.rules 
ACTION=="add", ATTR{idVendor}=="0403", ATTR{idProduct}=="6014", MODE:="666"
```

Note: For people coming from Lattice Radiant, note that HSOSC is replaced with SB\_HFOSC for
the 48MHz internal clock. Other adjustments might also require conversion.
