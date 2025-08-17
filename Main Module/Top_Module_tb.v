module TOP_Module_tb();

parameter IDLE = 3'b000 ;
parameter CHK_CMD = 3'b001 ;
parameter WRITE = 3'b010 ;
parameter READ_ADD = 3'b011 ;
parameter READ_DATA = 3'b111 ;
parameter MEM_DEPTH =256 ;
parameter ADDR_SIZE =8 ;
    
reg MOSI_tb,clk_tb,rst_n_tb,SS_n_tb ;
wire MISO_tb ;

TOP_Module tb (MOSI_tb,MISO_tb,SS_n_tb,clk_tb,rst_n_tb);

initial begin
    clk_tb = 0 ;
    forever begin
        #1 clk_tb = ~clk_tb ;
    end
end


initial begin
    $readmemh("mem.txt",tb.RAM_INST.mem) ;

    rst_n_tb = 0 ;
    SS_n_tb =1   ;
    MOSI_tb =0 ;
    @(negedge clk_tb) ;

    if (MISO_tb != 0) begin
        $display ("error in reset process") ;
        $stop ;
    end
    rst_n_tb = 1 ;
    @(negedge clk_tb) ;

// testing write addr 
    SS_n_tb = 0 ;
    MOSI_tb = 0 ; @(negedge clk_tb); @(negedge clk_tb);  //determine the write function

    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);   //must be zero
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);   //addr:11101010 & hexa:EA

      rst_n_tb=1; MOSI_tb=1; SS_n_tb=1;
@(negedge clk_tb);

//testing write data
    SS_n_tb = 0 ;
    MOSI_tb = 0 ; @(negedge clk_tb); @(negedge clk_tb);  //determine the write function

    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);   //must be one
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);   //data:01101011 & hexa:6B

      rst_n_tb=1; MOSI_tb=1; SS_n_tb=1;
@(negedge clk_tb); @(negedge clk_tb);

//testing read addr
    SS_n_tb = 0 ;
    MOSI_tb = 1 ; @(negedge clk_tb); @(negedge clk_tb);  //determine the write function


    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);   //must be zero
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);

      rst_n_tb=1; MOSI_tb=1; SS_n_tb=1;
@(negedge clk_tb); @(negedge clk_tb);

//testing write data
    SS_n_tb = 0 ;
    MOSI_tb = 0 ; @(negedge clk_tb); @(negedge clk_tb);  //determine the write function

    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);   //must be one
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 0 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);

      rst_n_tb=1; MOSI_tb=1; SS_n_tb=1;
@(negedge clk_tb); @(negedge clk_tb);

//testing read data
    SS_n_tb = 0 ;
    MOSI_tb = 1 ; @(negedge clk_tb);   //determine the write function

    MOSI_tb = 1 ; @(negedge clk_tb);
    MOSI_tb = 1 ; @(negedge clk_tb);   //must be one

      rst_n_tb=1; MOSI_tb=1; SS_n_tb=0;
@(negedge clk_tb); @(negedge clk_tb);
repeat (8) @(negedge clk_tb);

rst_n_tb=1; MOSI_tb=0; SS_n_tb=1;
@(negedge clk_tb);

$stop ; 
end



endmodule