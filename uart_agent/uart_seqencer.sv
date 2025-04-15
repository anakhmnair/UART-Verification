/* source sequencer for router 1x3 */

class uart_seqencer extends uvm_sequencer #(uart_xtn);

	`uvm_component_utils(uart_seqencer)
	
	extern function new(string name = "uart_seqencer",uvm_component parent);
endclass

function uart_seqencer::new(string name="uart_seqencer",uvm_component parent);
	super.new(name,parent);
endfunction