UART-🧠 UART Communication Module

📘 Project Overview
This project implements a UART (Universal Asynchronous Receiver/Transmitter) system in Verilog, enabling asynchronous serial communication between devices.
It features parameterized baud rate control and uses 16× oversampling for accurate timing.

The design consists of:

UART Transmitter (uart_tx)
UART Receiver (uart_rx)
Baud Rate Generator (baudgen)
Top-level UART module integrating all components

📚 Concept

UART Signal Timing
UART transmits data serially using start bits, data bits, and stop bits:
Start Bit: Logic 0 signals start of data frame.
Data Bits: 8 bits transmitted least significant bit (LSB) first.
Stop Bit: Logic 1 signals end of frame.
Baud Rate: Data bits are timed using a baud rate generator, with 16× oversampling to reduce sampling errors.

Full-Duplex UART Communication

The UART module uses separate TX and RX lines, enabling simultaneous transmission and reception of data.
This supports full-duplex communication, allowing devices to send and receive data independently and concurrently.

Why Full Duplex?

Essential for real-world applications where devices need to send commands and receive responses simultaneously.
Improves communication efficiency and responsiveness.
How It Works in This Design
uart_tx drives the tx line independently.
uart_rx listens on the rx line independently.
Both modules operate concurrently, controlled by FSMs and synchronized with the baud rate generator.
In the testbench, the rx line is connected to the tx line (assign rx = tx;) to simulate loopback testing. In real systems, these lines connect to different devices or separate pins.

⚙️ Implementation Details

UART Receiver (uart_rx)

Implements a 4-state FSM (idle, start, data, stop).
Samples incoming bits at 16× the baud rate (baud_tick) for reliable detection.
Outputs the received byte and asserts rx_done when a full byte is received.
UART Transmitter (uart_tx)

Waits for start_tx signal to begin sending data.
Sends start bit, 8 data bits, and stop bit serially, timed by baud_tick.
Asserts tx_done when transmission finishes.
Baud Rate Generator (baudgen)
Generates a baud_tick pulse at 16× the desired baud rate.
Parameters allow configuring clock frequency and baud rate.
Top-Level UART Module (uart)
Integrates transmitter, receiver, and baud generator.
Handles serial input/output and provides control/status signals for easy integration.


📁 Project Files

File	Description
uart_rx.v	UART Receiver module
uart_tx.v	UART Transmitter module
baudgen.v	Baud rate generator
uart.v	Top-level UART module
uart_tb.v	Testbench for UART communication

🛠️ Tools Used

ModelSim: RTL simulation and waveform visualization
GTKWave: Optional waveform analysis
Vivado: FPGA synthesis and implementation (if targeting FPGA)

📐 Parameter Configuration

Parameter	Description	Default
BAUD_RATE	UART baud rate	9600
CLOCK_FREQ	System clock frequency (Hz)	50,000,000

✅ Conclusion
This project provides a fully functional UART design suitable for FPGA or ASIC integration.
It demonstrates serial communication with configurable baud rates, oversampling for reliability, and FSM-based transmitter and receiver design.

🚀 Future Work

Implement UART with FIFO pipeline design for buffered communication.
Add parity bit and configurable data/stop bits.
Implement flow control (RTS/CTS).
Add error detection (framing and parity errors).
