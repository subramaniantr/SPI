Purpose : The SPI is intended to create a communication protocol from microcontroller to the chip under design. In order to do this, we need to define qualitatively as to what the SPI looks like in
paper.Defining the steps that the SPI goes about doing will help us to define the SPI architecture :
  1. We divide the registers between SPI slaves that can handle. Let's assume that we have 32 register address per slave OR 5 bit addressible slaves
  2. The SPI register selects the slave first using the CS following which the first 8 bits sent will be a command byte. This command byte will contain the first bit as Read(1) or Write(0). The 0 is 
  chosen fo write as it's more common to write. LSB 5 bits will represent the address.
  3. We need to incorporate also additional features auto increment the address for write and read. This could probably be added in the command itself in the bits that are unused. [PENDING]

Implementation :

1. A register collection of 5-bit addressible 32 set of registers can be created.
2. A state machine should be functioning as follow :
    2.1 It starts from S0 before the chip select is asserted. The machine should return to S0 after the deassetion of chip select. Thus entry to this state is asynchronous as no other clock is available.
    The state S0 doesn't do anything to the register writes or reads. 
    2.2 We need some counters that count the number of clocks in each of the read/write/address states. Let's call them counter_address, counter_read_data and counter_write_data. These can be 8-bit 
    counters that get reset to 0 at the stat of S0.
    2.2 The first clock after CS goes low will take the machine to the state S1. The address counter would start counting the up till the three LSBs are 3'b000 again after 8 counts.
    2.3 Based on the first bit and the counter value bing 111, the next state is already determined to be a SR or SW. When the state is SR the counter_read_data starts up counting till the value 
    comes back to 3'b000.
