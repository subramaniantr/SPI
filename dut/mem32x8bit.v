module mem32x8bit(
  input clk,
  input [4:0] addr,
  input [7:0] data,
  input write_enable,
  input rstb, 
  output wire [7:0] read_data
);

 reg [7:0] reg_array [0:31];// 32 8-bit registers 

  always @(posedge clk or negedge rstb) begin
  if(!rstb)
    for (integer i = 0; i < 32; i = i + 1) begin //for
      reg_array[i] <= 8'h00;
    end //for
   else 
    if (write_enable)
      reg_array[addr] <= data;
  end

assign read_data = reg_array[addr];

endmodule




































