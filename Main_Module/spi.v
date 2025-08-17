module spi (MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid);
parameter IDLE = 3'b000 ;
parameter CHK_CMD = 3'b001 ;
parameter WRITE = 3'b010 ;
parameter READ_ADD = 3'b011 ;
parameter READ_DATA = 3'b111 ;

input MOSI,SS_n,clk,rst_n,tx_valid ;
input [7:0] tx_data;
output reg [9:0] rx_data ;
output reg MISO,rx_valid;

reg [9:0] shift_in ;
reg read_addr_received ;  // law b 1 y3ni yroh ygeb l data law b zero yero7 ll address
reg [3:0] counter; //tracks how many bits we’ve received

(* fsm_encoding = "sequential"*)
reg [2:0] current_state,next_state ;


always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        current_state <= IDLE ;
    else
        current_state <= next_state ; 
end

//Next state logic always block
always @(*) begin
    case (current_state)
        IDLE: begin
            if (SS_n == 0 ) next_state = CHK_CMD;
            else next_state = IDLE;
        end
        CHK_CMD: begin
            if (SS_n == 0 && MOSI == 1) begin
                if (read_addr_received)
                    next_state = READ_DATA;
                else
                    next_state = READ_ADD;
            end else if (SS_n == 0 && MOSI == 0) begin
                next_state = WRITE;
            end 
            else if (SS_n) begin
                next_state =IDLE ;
            end
        end
        WRITE: begin
            if (SS_n == 1) 
            next_state = IDLE;
            else next_state = WRITE;
        end

        READ_ADD: begin
            if (SS_n==1 ) begin
            next_state = IDLE;
            end
            else 
            next_state = READ_ADD;  
        end
        READ_DATA: begin
            if (SS_n ==1) next_state = IDLE;
            else next_state = READ_DATA;
        end

        default: next_state = IDLE;
    endcase
end




//Output logic always block
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
    counter <= 0;
    read_addr_received <= 0;
    MISO <= 1'b0;
    rx_valid <=0 ;
end
else begin
    case (current_state)

        IDLE: rx_valid<=0;

        CHK_CMD : begin
             counter<=0;
             shift_in<=0;
             rx_valid<=0;
        end

        WRITE: begin  // convert from serial to parallel
        shift_in [9-counter]<=MOSI;
        counter<=counter+1;
        if(counter==10) begin
            counter<=0;
            rx_data<=shift_in;
            rx_valid<=1;   
            end 
            end

        READ_ADD: begin  // convert from serial to parallel
        shift_in [9-counter]<=MOSI;
        counter<=counter+1;
        if(counter==10) begin
            counter<=0;
            rx_data<=shift_in;
            rx_valid<=1;
            read_addr_received <= 1 ;   
            end 
            end

        READ_DATA: begin
                MISO <= tx_data [7 - counter] ;
                counter <= counter + 1 ;

            if (counter == 4'h7) begin
                    counter <= 0 ;
                    read_addr_received <= 1 ;                            
                end
            end
        default : begin
                counter <= 0;
                MISO <= 1'b0;
            end
endcase
end
end
endmodule 
