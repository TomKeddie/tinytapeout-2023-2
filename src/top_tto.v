`default_nettype none

module tt_um_tomkeddie_a
  #(parameter CLOCK_RATE=1000)
  (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
   );

  wire          rst;
  wire [1:0]    red; 
  wire [1:0]    blue;
  wire [1:0]    green; 
  wire          blank;
  wire          sclk;
  wire          latch;
  wire [2:0]    rowmax;
  wire          a;
  wire          b;
  wire          uart_data;
  wire          mode;

  assign uo_out[0] = red[0];
  assign uo_out[1] = blue[0];
  assign uo_out[2] = b;
  assign uo_out[3] = blank;
  assign uo_out[4] = green[0];
  assign uo_out[5] = a;
  assign uo_out[6] = sclk;
  assign uo_out[7] = latch;
  assign uio_out[0] = red[1];
  assign uio_out[1] = blue[1];
  assign uio_out[2] = green[1];
  assign uio_out[7:3] = 8'b00000000;
  assign uio_oe       = 8'b00000111;

  assign rst       = !rst_n;
  assign uart_data = ui_in[0];
  assign mode      = ui_in[1];


  // instantiate the component
  led_panel_single top(.clk(clk),
                       .reset(rst),
                       .uart_data(uart_data),
                       .mode(mode),
                       .red_out(red),     
                       .blue_out(blue),    
                       .blank_out(blank),   
                       .green_out(green),  
                       .a_out(a),
                       .b_out(b),
                       .sclk_out(sclk),    
                       .latch_out(latch)
                       );              
  
endmodule
