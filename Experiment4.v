//Experiment 4

module Circuit1
(
    input a,b,
    output f
);
    assign f = (~a & b)|(a & ~b);
endmodule

module Circuit2
(
    input a,b,c,
    output g
);
    assign g = (a & c) | (b & ~c) | (a & b);

endmodule

module Circuit3
(
    input a,b,c,d,
    output h
);
    assign h = ~((a & b & c) | ~(c | d)) | (b & ~(c|d));

endmodule

module LabExp4TestBench;
    reg a,b,c,d;
    wire f,g,h;

    Circuit1 C1(a,b,f);
    Circuit2 C2(a,b,c,g);
    Circuit3 C3(a,b,c,d,h);

    initial
        begin
            $dumpfile("LabExp4.vcd");
	        $dumpvars(-1, C1,C2,C3);
	        $display (" ");
        end

    initial begin
        #1 a=0; b=0;
        #1 $display("Circuit 1: A!B + !AB");
           $monitor("a=%b, b=%b : F=%b",a,b,f);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
	#1 $display (" ");

	#1 $display("Circuit 2: AC + B!C + AB");
	#1 a=0; b=0; c=0;
           $monitor("a=%b, b=%b, c=%b : F=%b",a,b,c,g);
        #1 a=0; b=0; c=1;
        #1 a=0; b=1; c=0;
        #1 a=0; b=1; c=1;
        #1 a=1; b=0; c=0;
        #1 a=1; b=0; c=1;
        #1 a=1; b=1; c=0;
        #1 a=1; b=1; c=1;
	#1 $display (" ");

        #1 $display("Circuit 3: !((ABC) + !(C+D)) + (B!(C+D))");
	#1 a=0; b=0; c=0; d=0;
           $monitor("a=%b, b=%b, c=%b, d=%b : F=%b",a,b,c,d,h);
        #1 a=0; b=0; c=0; d=1;
        #1 a=0; b=0; c=1; d=0;
        #1 a=0; b=0; c=1; d=1;
        #1 a=0; b=1; c=0; d=0;
        #1 a=0; b=1; c=0; d=1;
        #1 a=0; b=1; c=1; d=0;
        #1 a=0; b=1; c=1; d=1;
        #1 a=1; b=0; c=0; d=0;
        #1 a=1; b=0; c=0; d=1;
        #1 a=1; b=0; c=1; d=0;
        #1 a=1; b=0; c=1; d=1;
        #1 a=1; b=1; c=0; d=0;
        #1 a=1; b=1; c=0; d=1;
        #1 a=1; b=1; c=1; d=0;
        #1 a=1; b=1; c=1; d=1;


    end
endmodule