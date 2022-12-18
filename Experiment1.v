module Experiment1;
    reg i1,i2; 
    wire not1,not2,and1,or1; 
    not(not1,i1);
    not(not2,i2);
    and(and1,i1,i2);
    or(or1,i1,i2);

    initial
        begin
            $dumpfile("LabExp1.vcd");
	        $dumpvars(-1, i1,i2,not1,not2,and1,or1);
	    	#1 $display(" "); 
        end
    initial begin
        #1 i1=0;
        #1 $display("Part 1: NOT Gate");
        #1 $monitor("Input = %b, Output = %b",i1,not1);
        #1 i1=1;
        #1 i1=0; i2=0;
	#1 $display(" "); 

        #1 $display("Part 2: AND Gate");
        #1 $monitor("Input1 = %b, Input2 = %b, Output = %b",i1,i2,and1);
        #1 i1=0; i2=1;
        #1 i1=1; i2=0;
        #1 i1=1; i2=1;
        #1 i1=0; i2=0;
	#1 $display(" "); 

        #1 $display("Part 3: OR Gate");
        #1 $monitor("Input1 = %b, Input2 = %b, Output = %b",i1,i2,or1);
        #1 i1=0; i2=1;
        #1 i1=1; i2=0;
        #1 i1=1; i2=1;
    end
endmodule