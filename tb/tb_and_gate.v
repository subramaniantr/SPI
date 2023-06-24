module tb_and_gate();

reg l,m;
wire n;

and_gate myAnd (.a (l),
                .b (m),
	        .c (n));
 
initial begin
// Reference : https://www.referencedesigner.com/tutorials/verilog/verilog_62.php
// The changes are recorded in a file called VCD file that stands for value change dump. A VCD (value change dump) stores all the information about value changes. We can not have more than one 
// $dumpfile statements in verilog simulation. But what exactly are we going to dump in this file ? Thhis is specified by $dumpvars that we will cover next. One more thing, the declaration of 
// $dumpfile must come before the $dumpvars or any other system tasks that specifies dump.
$dumpfile("dump.vcd");

// dumpvars decides what are the variables to be dumped. The dumpvars has a syntax as : $dumpvars(<levels> , <module OR variable>) 0 stands for all, 1 stands only tb level and so on.More modules or 
// variables can be comma separated.

$dumpvars();

// automatically displays the below string whenever any variable changes. $display can be used instead if we need to only display once or a few times.
$monitor ("%t | a = %d| b = %d| c = %d", $time, l, m, n);

#10    l = 0 ; m = 0;
#10    l = 0 ; m = 1;
#10    l = 1 ; m = 0;
#10    l = 1 ; m = 1;
#10    l = 1 ; m = 1;

$finish;
end


endmodule
