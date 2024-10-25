# This code was stolen from Lucas Polidori. I will ask his permission at some point
PROGRAM_NAME=$1
echo "Building with ${PROGRAM_NAME}"

# Clean
rm *.json *.asc *.cf *.o
set -ex

# Simulate
ghdl -a --std=08 *.vhd

# Synthesize
yosys -m ghdl -p "ghdl --std=08 ${PROGRAM_NAME}; synth_ice40 -json ${PROGRAM_NAME}.json"

# Route, generate, and flash
nextpnr-ice40 --pcf-allow-unconstrained --ignore-loops --up5k --package sg48 --pcf "${PROGRAM_NAME}.pcf" --json "${PROGRAM_NAME}.json" --asc "${PROGRAM_NAME}.asc"
icepack "${PROGRAM_NAME}.asc" "${PROGRAM_NAME}.bin"
iceprog "${PROGRAM_NAME}.bin"
