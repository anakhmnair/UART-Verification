/* source driver for router 1x3 */

class uart_driver extends uvm_driver #(uart_xtn);

	`uvm_component_utils(uart_driver)
	

	
	uart_agent_config m_cfg;
	
	virtual uart_if.DRV_MP vif;
	
	//METHODS
	extern function new(string name ="uart_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(uart_xtn u_xtn);

endclass

function uart_driver::new(string name ="uart_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void uart_driver::build_phase(uvm_phase phase);
		super.build_phase(phase);
		//if(!uvm_config_db #(uart_agent_config)::get(this,"","uart_agent_config",m_cfg))
		//	`uvm_fatal("DRIVER","Can't get virtual interface")

	endfunction

function void uart_driver::connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
		$display(get_name());
		$display("\n\n\n\n ----------%p----------\n\n\n\n",m_cfg);
endfunction

task uart_driver::run_phase(uvm_phase phase);
		@(vif.drv_cb);
		vif.drv_cb.wb_rst_i <= 0; 
		@(vif.drv_cb);
		vif.drv_cb.wb_rst_i <= 1;	
		vif.drv_cb.wb_stb_i <= 0;
		vif.drv_cb.wb_cyc_i <= 0;
		@(vif.drv_cb);
		vif.drv_cb.wb_rst_i <= 0;
	forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
endtask

task uart_driver::send_to_dut(uart_xtn u_xtn);
		`uvm_info("S_DRV",$sformatf("printing from driver \n %s", u_xtn.sprint()),UVM_LOW)
		@(vif.drv_cb);
		vif.drv_cb.wb_sel_i <= 4'b0001;
		vif.drv_cb.wb_stb_i <= 1;
		vif.drv_cb.wb_cyc_i <= 1;
		vif.drv_cb.wb_we_i <= u_xtn.we_i;
		vif.drv_cb.wb_adr_i <= u_xtn.wb_addr_i;
		vif.drv_cb.wb_dat_i <= u_xtn.wb_data_i;
	wait(vif.drv_cb.wb_ack_o)
		vif.drv_cb.wb_stb_i <= 0;
		vif.drv_cb.wb_cyc_i <= 0;
		
	if(u_xtn.wb_addr_i == 2 && u_xtn.we_i == 0)
			begin
				wait(vif.drv_cb.int_o);
				//repeat(2)
					@(vif.drv_cb);
				u_xtn.iir = vif.drv_cb.wb_dat_o;
				seq_item_port.put_response(u_xtn);
				$display("DRIVER The value IIR received from dut is %b", vif.drv_cb.wb_dat_o);
			end
endtask