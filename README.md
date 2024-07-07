# SPI_Serial_Peripheral_Interface_Verilog_Modules
Implementation of a Serial Peripheral Interface(SPI) using Verilog and testing various modes of the SPI Device

<strong>Simulated & Verified using ModelSim

This project report provides a detailed account of the design and implementation of the SPI (Serial Peripheral Interface) Master Core in Verilog. The objective of this project was to gain hands-on experience in designing and implementing digital circuits using Verilog, as well as to gain a deeper understanding of the SPI protocol and its applications. 


<strong>SPI MASTER CORE ARCHITECTURE & DESING BLOCKS OF SPI MASTER CORE ARCHITECTURE</strong>
![image](https://github.com/daringpatil3134/SPI_Serial_Peripheral_Interface_Verilog_Modules/assets/83998270/f46a1888-ce12-4d1b-a7f6-89d9c95a936b)

<p align="center">
  <img src="https://github.com/daringpatil3134/SPI_Serial_Peripheral_Interface_Verilog_Modules/assets/83998270/4c61bc2e-0dfb-4eda-ba55-3ffa864a98e8">
</p>

Features of SPI Master Core Include Full duplex synchronous serial data, Variable length of transfer word up to 128 bits, MSB or LSB first data transfer, Rx and Tx on both rising or falling edge of serial clock independently, Up to 32 slave select lines, Auto Slave Select, Interrupt Enable & Clock Divider.

To meet specific system requirements and size constraints on behalf of the functionality, the SPI Master core can be configured by setting the appropriate define directives in the “spi_defines.v” source file.

<strong>CLOCK GENERATOR WAVEFORM</strong>
![image](https://github.com/daringpatil3134/SPI_Serial_Peripheral_Interface_Verilog_Modules/assets/83998270/eb52d3fd-50cc-4678-98b8-019117840e7b)

<strong>SHIFT REGISTER BLOCK WAVEFORM<strong>
![image](https://github.com/daringpatil3134/SPI_Serial_Peripheral_Interface_Verilog_Modules/assets/83998270/b19e3c3e-586c-48db-a2d9-34cc6711b7ae)

<strong>MASTER TEST BENCH OUTPUTS
SET 1: TX_NEG = 1, RX_NEG = 0, LSB = 1, CHAR_LEN = 4</strong>
![image](https://github.com/daringpatil3134/SPI_Serial_Peripheral_Interface_Verilog_Modules/assets/83998270/1668c63c-b995-4d89-b303-be1033795590)

<strong>SET 2: TX_NEG = 1, RX_NEG = 0, LSB = 0, CHAR_LEN = 4</strong>
![image](https://github.com/daringpatil3134/SPI_Serial_Peripheral_Interface_Verilog_Modules/assets/83998270/8047805f-b798-4441-9710-a182c0c8cdfa)

<strong>SET 3: TX_NEG = 0, RX_NEG = 1, LSB = 1, CHAR_LEN = 4</strong>
![image](https://github.com/daringpatil3134/SPI_Serial_Peripheral_Interface_Verilog_Modules/assets/83998270/b1e5b156-44bc-4709-b452-178254348cdb)

## License
This project is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. You are free to:

* Share — copy and redistribute the material in any medium or format
* Adapt — remix, transform, and build upon the material

Under the following terms:

* Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
* NonCommercial — You may not use the material for commercial purposes.
* ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

For more details, refer to the license.

For More Details Please Refer The Project Report :- [SPI Design Project Report](https://drive.google.com/file/d/1IAZNETm_P4-l9MCdvRWQpI7wAFOC6SgX/view?usp=share_link)
