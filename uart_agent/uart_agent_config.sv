/* this is the agent configuration for source */

class uart_agent_config extends uvm_object;

	`uvm_object_utils(uart_agent_config)
	
	
	// MEMBERS
	virtual uart_if vif;
	
	uvm_active_passive_enum is_active = UVM_ACTIVE;
	
	static int mon_rcvd_xtn_cnt = 0;
	
	static int drv_data_sent_cnt = 0;
	
	static int no_of_uart = 2;
	
	static int has_scoreboard = 1;
	
	static int has_v_seqr = 1;
		
	
	//METHODS

	extern function new(string name = "uart_agent_config");
endclass

function uart_agent_config::new(string name = "uart_agent_config");
	super.new(name);
endfunction