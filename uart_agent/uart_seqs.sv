/* source sequence for router 1x3 */

class uart_sbase_seq extends uvm_sequence #(uart_xtn);  
	
	`uvm_object_utils(uart_sbase_seq)  
	
	// METHODS
    extern function new(string name ="uart_sbase_seq");
	//extern task body();
endclass

function uart_sbase_seq::new(string name ="uart_sbase_seq");
	super.new(name);
endfunction

/*task uart_sbase_seq::body();

	req = uart_xtn::type_id::create("req");
		//start_item(req);
		//assert(req.randomize());
		`uvm_info(get_type_name(),$sformatf("printing from sequence %s",req.sprint()),UVM_LOW)
		//finish_item(req);

endtask*/



//////FULL DUPLEX SEQUENCES//////



class full_duplex1 extends uart_sbase_seq;
	`uvm_object_utils(full_duplex1)

	function new(string name="full_duplex1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd25;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
			end
	endtask
endclass				



class full_duplex2 extends uart_sbase_seq;
	`uvm_object_utils(full_duplex2)

	function new(string name="full_duplex2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd28;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end
			
		/*if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");*/
			//end
	endtask
endclass




//////HALF DUPLEX SEQUENCES//////



class half_duplex1 extends uart_sbase_seq;
	`uvm_object_utils(half_duplex1)

	function new(string name="half_duplex1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd17;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

/*
//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
			end*/
	endtask
endclass				



class half_duplex2 extends uart_sbase_seq;
	`uvm_object_utils(half_duplex2)

	function new(string name="half_duplex2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

/*
//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd28;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");
*/
//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end
			
		/*if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");*/
			//end
	endtask
endclass




//////LOOPBACK SEQUENCES//////



class loopback1 extends uart_sbase_seq;
	`uvm_object_utils(loopback1)

	function new(string name="loopback1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");
		
//step 6
		//LOOPBACK setup
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 4; we_i == 1; wb_data_i == 8'b0001_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7		
		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

//step 8
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd10;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");

//step 9
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
		get_response(req);

//step 10
		//read rb
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 10 \n\n\n\n");
			end
	endtask
endclass				



class loopback2 extends uart_sbase_seq;
	`uvm_object_utils(loopback2)

	function new(string name="loopback2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6
		//LOOPBACK setup
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 4; we_i == 1; wb_data_i == 8'b0001_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7		
		
		//IER - fifo register	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");
				
//step 8
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd20;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
			
//step 9
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
		get_response(req);

//step 10
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 10 \n\n\n\n");
			end
		/*if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");*/
			//end
	endtask
endclass




//////PARITY ERROR SEQUENCES//////



class par_err1 extends uart_sbase_seq;
	`uvm_object_utils(par_err1)

	function new(string name="par_err1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0001_1011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0100;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd25;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
			end

//step 10
			// check lsr 
		if(req.iir[3:1] == 3)	
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end
	endtask
endclass				



class par_err2 extends uart_sbase_seq;
	`uvm_object_utils(par_err2)

	function new(string name="par_err2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_1011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0100;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd28;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end
	
//step 10
			// check lsr 
		if(req.iir[3:1] == 3)	
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end
	endtask
endclass




//////FRAMING ERROR SEQUENCES//////



class framing1 extends uart_sbase_seq;
	`uvm_object_utils(framing1)

	function new(string name="framing1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 5-bits soo the lcr[1:0] == 00
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0100;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0100;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd64;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0; wb_data_i == 8'd0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

/*/step 9
				
		
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
			end*/
			
//step 10
			
		if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end
	endtask
endclass				



class framing2 extends uart_sbase_seq;
	`uvm_object_utils(framing2)

	function new(string name="framing2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0111;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd69;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0; wb_data_i == 8'd0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);

/*/step 9
			
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end*/

//step 10		
		
		
		if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end	
	endtask
endclass





//////OVERRUN ERROR SEQUENCES//////



class overrun1 extends uart_sbase_seq;
	`uvm_object_utils(overrun1)

	function new(string name="overrun1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 5-bits soo the lcr[1:0] == 00
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0111;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0100;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'b0000_0111;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

			
/*/step 10
			
		if(req.iir[3:1] == 2)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end*/

//step 9
				
		
		if(req.iir[3:1] == 3)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 10 \n\n\n\n");
			end
	endtask
endclass				



class overrun2 extends uart_sbase_seq;
	`uvm_object_utils(overrun2)

	function new(string name="overrun2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0111;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0101;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

//step 7
	repeat(18) begin
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");
		end

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);


//step 10		
		
		
		if(req.iir[3:1] == 2)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end	

//step 9
			
		if(req.iir[3:1] == 3)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end
	endtask
endclass




//////break interupt SEQUENCES//////



class brkint1 extends uart_sbase_seq;
	`uvm_object_utils(brkint1)

	function new(string name="brkint1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 5-bits soo the lcr[1:0] == 00
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0100_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0100;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd11;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		
		if(req.iir[3:1] == 3)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
			end
			
/*/step 10
			
		if(req.iir[3:1] == 2)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end*/
	endtask
endclass				



class brkint2 extends uart_sbase_seq;
	`uvm_object_utils(brkint2)

	function new(string name="framing2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0100_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0100;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd69;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);

/*/step 9
			
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end*/

//step 10		
		
		
		if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end	
	endtask
endclass



//////TIMEOUT SEQUENCES//////



class timeout2 extends uart_sbase_seq;
	`uvm_object_utils(timeout2)

	function new(string name="timeout2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd25;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 2)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
			end

//step 10
		// LSR	
		if(req.iir[3:1] == 3)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 10 \n\n\n\n");
			end
	endtask
endclass				



class timeout1 extends uart_sbase_seq;
	`uvm_object_utils(timeout1)

	function new(string name="timeout1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0001;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0100_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd28;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 6)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==0; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end

//step 10		
		if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");
			end
	endtask
endclass



//////THR EMPTY SEQUENCES//////



class thr_empty1 extends uart_sbase_seq;
	`uvm_object_utils(thr_empty1)

	function new(string name="thr_empty1");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb) divisor1 = 16'd54
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd54;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1	
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0010;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 6 \n\n\n\n");

/*/step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd25;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 7 \n\n\n\n");*/

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS FD1 STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 1)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS FD1 STEP 9 \n\n\n\n");
			end
	endtask
endclass				



class thr_empty2 extends uart_sbase_seq;
	`uvm_object_utils(thr_empty2)

	function new(string name="thr_empty2");
		super.new(name);
	endfunction

	task body();
		//super.body();

//step1
		//line control register
		req = uart_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b1000_0000;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 1 \n\n\n\n");

//step2
		//divisor latch register (msb)
		// divisor2 = 16'd27
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0000;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 2 \n\n\n\n");

//step3
		//divisor latch register (lsb)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd27;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 3 \n\n\n\n");

//step 4
		//enabling normal registers by making lcr[7] = 0 and no_of bits per each character is 8-bits soo the lcr[1:0] == 11
	start_item(req);
		assert(req.randomize() with {wb_addr_i == 3; we_i == 1; wb_data_i == 8'b0000_0011;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 4 \n\n\n\n");

//step 5		
		//IER - making ier[1] == 1
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 1; we_i == 1; wb_data_i == 8'b0000_0010;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 5 \n\n\n\n");

//step 6		
		//clearing fifo registers
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 1; wb_data_i == 8'b0000_0110;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 6 \n\n\n\n");

//step 7
		//thr (passing actual value)
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 0; we_i == 1; wb_data_i == 8'd28;});
		//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 7 \n\n\n\n");

//step 8
	//	reading iir (we can't say data is availabe in rb r not for that we are checking rb[3:1] is 2 
		start_item(req);
		assert(req.randomize() with {wb_addr_i == 2; we_i == 0;});
		finish_item(req);
		$display("\n\n\n\n THIS IS STEP 8 \n\n\n\n");
		get_response(req);

//step 9
				
		if(req.iir[3:1] == 1)	// means there is data available in receiver buffer(rb)
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				//`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 9 \n\n\n\n");
			end
			
		/*if(req.iir[3:1] == 3)	// 
			begin
				start_item(req);
				assert(req.randomize() with {wb_addr_i==5; we_i==0;});
				`uvm_info(get_type_name(),$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
				finish_item(req);
				$display("\n\n\n\n THIS IS STEP 10 \n\n\n\n");*/
			//end
	endtask
endclass