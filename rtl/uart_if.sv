/* interface for router 1x3 verification */

interface uart_if(input bit clock);
	
	logic           wb_rst_i;       // Asynchronous Reset
    logic [2:0]    	wb_adr_i;      // Used for register selection
    logic [3:0]     wb_sel_i;       // Select signal
    logic [7:0]     wb_dat_i;       // Data input
    logic [7:0]     wb_dat_o;       // Data output
    logic           wb_we_i;        // Write or read cycle clection
    logic           wb_stb_i;       // Specifies transfer cycle
    logic           wb_cyc_i;       // A bus cycle is in progress
    logic           wb_ack_o;       // Acknowledge of a transfer
	logic           int_o;          // Interrupt output
    logic           baud_o;         // baud rate output signal
	
	logic           stx_pad_o;      // The serial output signal
    logic           srx_pad_i;      // The serial input signal
    logic           rts_pad_o;      // Request to Send
    logic           dtr_pad_o;      // Data Terminal Ready
    logic           cts_pad_i;      // Clear To Send
    logic           dsr_pad_i;      // Data To Ready
    logic           ri_pad_i;       // Ring Indicator
    logic           dcd_pad_i;      // Data Carrier Detect
	
	clocking drv_cb @(posedge clock);
	default input #1 output #1;
		output wb_rst_i;
		output wb_adr_i;
		output wb_dat_i;
		output wb_sel_i;
		output wb_stb_i;
		output wb_cyc_i;
		output wb_we_i;
		input wb_dat_o;
		input wb_ack_o;
		input int_o;
		input baud_o;
	endclocking
	
	clocking mon_cb @(posedge clock);
	default input #1 output #0;
		input wb_rst_i;
		input wb_adr_i;
		input wb_dat_i;
		input wb_sel_i;
		input wb_stb_i;
		input wb_cyc_i;
		input wb_we_i;
		input wb_dat_o;
		input wb_ack_o;
		input int_o;
		input baud_o;
	endclocking

	modport MON_MP (clocking mon_cb);
	
	modport DRV_MP (clocking drv_cb);
	

endinterface
