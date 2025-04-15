

class uart_xtn extends uvm_sequence_item;
	`uvm_object_utils(uart_xtn)

	//properties
	bit wb_rst_i;
	rand bit[7:0]wb_addr_i;
	rand bit[7:0]wb_data_i;
	rand bit we_i;
	bit [7:0]wb_data_o;
	bit [3:0]wb_sel_i;
	bit wb_stb_i;
	bit wb_cyc_i;
	bit wb_ack_o;
	bit int_o;

	//registers
	bit [7:0]ier,iir,fcr,lcr,lsr,dll,dlm,msr,mcr;	
	bit [7:0] thr[$];
	bit [7:0] rb[$];

	function new(string name="uart_trans");
		super.new(name);
	endfunction

	function void do_print(uvm_printer printer);
  super.do_print(printer);

  // --> printing transaction data
    printer.print_field("wb_dat_i",   this.wb_data_i,   8, UVM_DEC);
    printer.print_field("wb_addr_i",  this.wb_addr_i,  3, UVM_DEC);
    printer.print_field("wb_we_i",    this.we_i,    1, UVM_DEC);

    foreach(thr[i])
      printer.print_field($sformatf("THR[%0d]",i),  this.thr[i],  8, UVM_DEC);

    foreach(rb[i])
      printer.print_field($sformatf("RB[%0d]",i),   this.rb[i],   8, UVM_DEC);

    printer.print_field("LCR",        this.lcr,        8, UVM_BIN);
    printer.print_field("MCR",        this.mcr,        8, UVM_BIN);
    printer.print_field("MSR",        this.msr,        8, UVM_BIN);
    printer.print_field("LSR",        this.lsr,        8, UVM_BIN);
    printer.print_field("FCR",        this.fcr,        8, UVM_BIN);
    printer.print_field("IIR",        this.iir,        8, UVM_BIN);
    printer.print_field("IER",        this.ier,        8, UVM_BIN);
    printer.print_field("DLL",        this.dll,        8, UVM_DEC);
    printer.print_field("DLM",        this.dlm,        8, UVM_DEC);
		
	endfunction


endclass
