
module TOP_Module(MOSI,MISO,SS_n,clk,rst_n);

input MOSI,SS_n,clk,rst_n;
output MISO;

wire [9:0] rx_data;
wire rx_valid;
wire [7:0] tx_data;
wire tx_valid;

spi SPI_SLAVE (
    .MOSI(MOSI),
    .MISO(MISO),
    .SS_n(SS_n),
    .clk(clk),
    .rst_n(rst_n),
    .rx_data(rx_data),
    .rx_valid(rx_valid),
    .tx_data(tx_data),
    .tx_valid(tx_valid)
);

Ram RAM_INST (
    .clk(clk),
    .rstn(rst_n),
    .din(rx_data),
    .rx_valid(rx_valid),
    .dout(tx_data),
    .tx_valid(tx_valid)
);

endmodule