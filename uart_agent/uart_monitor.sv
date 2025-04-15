/* source monitor for router 1x3 */

class uart_monitor extends uvm_monitor;

	`uvm_component_utils(uart_monitor)
	
	virtual uart_if.MON_MP vif;
	
	uart_agent_config m_cfg;
	uart_xtn u_xtn;
	
	uvm_analysis_port #(uart_xtn) monitor_port;
	
	//METHODS
	
	extern function new(string name = "uart_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass

function uart_monitor::new(string name = "uart_monitor", uvm_component parent);
	super.new(name,parent);
 	monitor_port = new("monitor_port", this);
	u_xtn = uart_xtn::type_id::create("u_xtn");
endfunction

	function void uart_monitor::build_phase(uvm_phase phase);
		super.build_phase(phase);
		//if(!uvm_config_db #(uart_agent_config)::get(this,"","uart_agent_config",m_cfg))
		//	`uvm_fatal("MONITOR","Can't get virtual interface")
	endfunction

	function void uart_monitor::connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction
		
	task uart_monitor::run_phase(uvm_phase phase);
		forever
			begin
			@(vif.mon_cb);
				collect_data();
			end
	endtask

	task uart_monitor::collect_data();

		@(vif.mon_cb);
		wait(vif.mon_cb.wb_ack_o)

		u_xtn.we_i = vif.mon_cb.wb_we_i;
		u_xtn.wb_stb_i = vif.mon_cb.wb_stb_i;
		u_xtn.wb_cyc_i = vif.mon_cb.wb_cyc_i;
		u_xtn.wb_data_i = vif.mon_cb.wb_dat_i;
		u_xtn.wb_addr_i = vif.mon_cb.wb_adr_i;
		u_xtn.wb_sel_i = vif.mon_cb.wb_sel_i;

		//lcr register
		if(u_xtn.wb_addr_i == 3 && u_xtn.we_i == 1)
			u_xtn.lcr = vif.mon_cb.wb_dat_i;

		//dlr (msb)
		if(u_xtn.lcr[7] == 1 && u_xtn.wb_addr_i == 1 && u_xtn.we_i == 1)
			u_xtn.dlm = vif.mon_cb.wb_dat_i;

		//dlr (msb)
		if(u_xtn.lcr[7] == 1 && u_xtn.wb_addr_i == 0 && u_xtn.we_i == 1)
			u_xtn.dll = vif.mon_cb.wb_dat_i;

		//fcr register
		if(u_xtn.lcr[7] == 0 && u_xtn.wb_addr_i == 2 && u_xtn.we_i == 1)
			u_xtn.fcr = vif.mon_cb.wb_dat_i;

		//ier 
		if(u_xtn.lcr[7] == 0 && u_xtn.wb_addr_i == 1 && u_xtn.we_i == 1)
			u_xtn.ier = vif.mon_cb.wb_dat_i;
		
		//mcr
		if(u_xtn.lcr[7] == 0 && u_xtn.wb_addr_i == 4 && u_xtn.we_i == 1)
			u_xtn.mcr = vif.mon_cb.wb_dat_i;
		
		//lsr register
		if(u_xtn.wb_addr_i == 5 && u_xtn.we_i == 0)
			u_xtn.lsr = vif.mon_cb.wb_dat_i;


		//thr
		if(u_xtn.lcr[7] == 0 && u_xtn.wb_addr_i == 0 && u_xtn.we_i == 1)
			u_xtn.thr.push_back(vif.mon_cb.wb_dat_i);

		//rb
		if(u_xtn.lcr[7] == 0 && u_xtn.wb_addr_i == 0 && u_xtn.we_i == 0)
			u_xtn.rb.push_back(vif.mon_cb.wb_dat_o);

		//iir
		if(u_xtn.lcr[7] == 0 && u_xtn.wb_addr_i == 2 && u_xtn.we_i == 0)
			begin
				wait(vif.mon_cb.int_o)
				@(vif.mon_cb);
				u_xtn.iir = vif.mon_cb.wb_dat_o;
			end
		

		
		`uvm_info("mon", $sformatf("received data \n %s", u_xtn.sprint()), UVM_LOW)
		
		monitor_port.write(u_xtn); //sending to scoreboard
	endtask