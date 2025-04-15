/* source agent for router 1x3 */

class uart_agent extends uvm_agent;
	
	`uvm_component_utils(uart_agent)
	
	//MEMBERS
	uart_agent_config m_cfg;
	uart_monitor monh;
	uart_seqencer seqrh;
	uart_driver drvh;
	
	//METHODS
	extern function new(string name = "uart_agent", uvm_component parent = null);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

function uart_agent::new(string name = "uart_agent", 
                               uvm_component parent = null);
    super.new(name, parent);
endfunction

function void uart_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(uart_agent_config)::get(this,"",get_name(),m_cfg))
	`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?") 
		//$display(get_name());
		//$display("----------%p----------",m_cfg);
    monh=uart_monitor::type_id::create("monh",this);	
	if(m_cfg.is_active==UVM_ACTIVE)
		begin
		drvh=uart_driver::type_id::create("drvh",this);
		seqrh=uart_seqencer::type_id::create("seqrh",this);
		end
	monh.m_cfg = m_cfg;
	drvh.m_cfg = m_cfg;
endfunction

function void uart_agent::connect_phase(uvm_phase phase);

	if(m_cfg.is_active==UVM_ACTIVE)
	begin
	drvh.seq_item_port.connect(seqrh.seq_item_export);
	end
endfunction