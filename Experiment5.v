//Experiment 5

module HalfAdder
(
    input A, B, 
    output Sum, Carry
);
    and(Carry,A,B);
    xor(Sum,A,B);
endmodule

module FullAdder
(
    input a,b,cIn, 
    output sum,cOut
);
    wire xor1,and1,and2;

    xor(xor1,a,b);
    xor(sum,xor1,cIn);
    and(and2,a,b);
    and(and1,xor1,cIn);
    or(cOut,and1,and2);
endmodule

module HalfSubtractor
(
    input A,B, 
    output hsub,hbOut
);
    wire not1;

    xor(hsub,A,B);
    not(not1,A);
    and(hbOut,B,not1);
endmodule

module FullSubtractor
(
    input a,b,bIn,
    output fsub,fbOut
);
    wire not1,xor1,and1,not2,and2;

    not(not1,a);
    xor(xor1,a,b);
    and(and1,not1,b);
    not(not2,xor1);
    and(and2,not2,bIn);
    xor(fsub,xor1,bIn);
    or(fbOut,and2,and1);
endmodule

module LabExp5TestBench;
    reg a,b,cIn,bIn;
    wire sum,carry,
         fullsum,cOut,
         hsub,hbOut,
         fsub,fbOut
    ;

    HalfAdder HFADD(a,b,sum,carry);
    FullAdder FLADD(a,b,cIn,fullsum,cOut);
    HalfSubtractor HFSUB(a,b,hsub,hbOut);
    FullSubtractor FFSUB(a,b,bIn,fsub,fbOut);

    initial
        begin
            $dumpfile("LabExp5.vcd");
	        $dumpvars(-1, HFADD,FLADD,HFSUB,FFSUB);
	        $display (" ");
        end

    initial begin
       
        #1 $display("Simulating Half Adder");
	 #1 a=0; b=0;
           $monitor("A=%b, B=%b, Sum=%b, Carry=%b", a,b,sum,carry);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        #1 $display (" ");
        
        #1 $display("Simulating Full Adder");
	#1 a=0; b=0; cIn=0;
           $monitor("A=%b, B=%b, cIn=%b, Sum=%b, Carry=%b",a,b,cIn,fullsum,cOut);
        #1 a=0; b=0; cIn=1;
        #1 a=0; b=1; cIn=0;
        #1 a=0; b=1; cIn=1;
        #1 a=1; b=0; cIn=0;
        #1 a=1; b=0; cIn=1;
        #1 a=1; b=1; cIn=0;
        #1 a=1; b=1; cIn=1;
	#1 $display (" ");

        
        #1 $display("Simulating Half Subtractor");
	#1 a=0; b=0; 
           $monitor("A=%b, B=%b, Diff=%b, Borrow=%b",a,b,hsub,hbOut);
        #1 a=0; b=1; 
        #1 a=1; b=0; 
        #1 a=1; b=1; 
	#1 $display (" ");

        
        #1 $display("Simulating Full Subtractor");
	#1 a=0; b=0; bIn=0;
           $monitor("A=%b, B=%b, bIn=%b, Diff=%b, Borrow=%b", a,b,bIn,fsub,fbOut);
        #1 a=0; b=0; bIn=1;
        #1 a=0; b=1; bIn=0;
        #1 a=0; b=1; bIn=1;
        #1 a=1; b=0; bIn=0;
        #1 a=1; b=0; bIn=1;
        #1 a=1; b=1; bIn=0;
        #1 a=1; b=1; bIn=1;

        #1 $finish;  
    end
endmodule