# AXI4-Master-Interconnect-Slave
AMBA AXI4 Master-Interconnect-Slave RTL design with BRAM, read/write transactions, handshaking and arbitration.

# Introduction

This project is an RTL implementation and study of an **AMBA AXI4-based system** consisting of multiple AXI4 masters, an **AXI4 interconnect**, and a **BRAM-based slave**.

The design demonstrates key AXI4 concepts including **VALID/READY handshaking, read and write transactions, address and data channels, response handling, burst transfers, transaction IDs, and interconnect-based master arbitration**.

The project is implemented in **Verilog** and verified through simulation using **Icarus Verilog** and **GTKWave**. The primary objective is to understand how AXI4 components communicate and how an interconnect manages transactions between multiple masters and a memory-mapped slave.

<img width="1638" height="924" alt="image" src="https://github.com/user-attachments/assets/0d65f90b-21e1-41f0-8b3f-564c739d81bd" />
Interconnect granting 20 turns to the two Masters each to access the BRAM Slave one by one

**Here are some features of this implementaion:**

* Master can initiate and perform read and write transactions at the same time.

* The data transation doesn't proceed unless the handshake is successful in the address channel(s).

* In both read and write channels, the requested data is available with a maximum delay of 2 clock cycles after the ARVALID/AWVALID signal has been asserted by the master.

* Each channel has its own IDs to keep track of both address and data transactions.

* Data can be resumed without losing it if the receiving side suddenly drops their RREADY/WREADY signals.

* All the burst modes such as FIXED, INCREMENT, and WRAP addressing modes are supported.

* The design also contains an active low global reset signal as per specs.

* The interconnect provides a simple scheduling to deal with multiple masters interfacing with a single slave and the algorithm can be easily scaled in case of more masters.

* As suggessted by the AXI4 specification, the VALID signal in any of the channels doesn't wait for the respective READY signal to be asserted HIGH. READY signals are asserted HIGH by defautlt to prevent wasting any clock cycles.
 
**Link to the original AXI4 specifications document:**

- [Arm AMBA AXI3 and AXI4 Protocol Specification](https://developer.arm.com/documentation/ihi0022/e/AMBA-AXI3-and-AXI4-Protocol-Specification)

## Example of using this AXI4 Interface

Here is the result of two AXI4 Masters and one AXI4 Slave with BRAM connected via an AXI4 Intercconect. The first master "AXI4_Write_BRAM" performs a write transaction of INCREMENT type with data "2, 5, 4, 3" into the slave "AXI4_BRAM_Controller". After successful transaction, the first master signals the interconnect to release the access to the slave. The interconnect then grants the slave access to the second master "AXI4_Poly_Add". This second master performs a read transaction to get the data written by the first master and then performs some mathematical operation on each byte of the data (in this case, '2' is added to each byte). Then, the second master does a write transaction to transfer the modified data back to the slave so it can be stored in the BRAM.



<img width="1665" height="944" alt="image" src="https://github.com/user-attachments/assets/b3d5fcb8-2e4c-4383-a10b-561cf6996892" />


<img width="1672" height="940" alt="image" src="https://github.com/user-attachments/assets/8f586d6a-de69-4e5d-be4a-bd1a90c51bde" />



## Interconnect Block Diagram



<img width="1730" height="909" alt="image" src="https://github.com/user-attachments/assets/d8f1945e-7f0a-4e09-8648-b18d98a1fcdf" />


**AXI4 Interconnect Arbitration**

The AXI4 Interconnect uses a **circular arbitration scheme** to control access to the shared slave among multiple AXI4 masters.

The arbiter grants access to one master at a time using **Set** and **Release** signals.

## Master Block Diagram

<img width="1105" height="1423" alt="image" src="https://github.com/user-attachments/assets/f383ee32-3edb-4e6a-bedf-ac2cf11b04b7" />

## Slave Block Diagram


<img width="1658" height="949" alt="image" src="https://github.com/user-attachments/assets/91a47771-1981-491d-9be4-921dcaf46648" />


## Data Resumibility


<img width="832" height="500" alt="image" src="https://github.com/user-attachments/assets/1cee4a1f-5081-44f9-86ea-c7d463bf4c10" />

## Verbose Simulation Waveforms (Single Master and Single BRAM Slave via Interconnect)


<img width="1644" height="940" alt="image" src="https://github.com/user-attachments/assets/72d5942f-fecc-4a45-88ef-c7dec33ef77b" />



<img width="1648" height="928" alt="image" src="https://github.com/user-attachments/assets/5b0708b0-5bf8-4845-9b92-6830f1cfd8c4" />

## Acknowledgements

This project was developed as a learning and study exercise based on the
publicly available **AXI4 Master–Interconnect–Slave** reference implementation.

The project was used to study **AMBA AXI4 protocol operation, master/slave
communication, interconnect arbitration, burst transactions, and RTL
implementation**.

### References

- [Arm AMBA AXI3 and AXI4 Protocol Specification](https://developer.arm.com/documentation/ihi0022/e/AMBA-AXI3-and-AXI4-Protocol-Specification)


---

## Author

**Anuj Sharma**

M.Sc. Engineering Physics (Electronics)  
NIT Warangal

---

© 2026 Anuj Sharma. All rights reserved.
