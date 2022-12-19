module DeMorgan
(
    input a,b,
    output NAND1,negativeOR1,NOR1,negativeAND1
);
    wire notA,notB;

    not(notA,a);
    not(notB,b);

    nand(NAND1,a,b);             // ~((a)(b))
    or(negativeOR1,notA,notB);   // (~a)+(~b)

    nor(NOR1,a,b);               // ~(a+b)
    and(negativeAND1,notA,notB); // (~a)(~b)
endmodule

module oneA  //OR Gate
(
    input a, b,
    output x
);

    wire notA, notB, notAAndnotB;
    
    not(notA,a);
    not(notB,b);
    and(notAAndnotB, notA, notB);
    not(x, notAAndnotB);
endmodule



module oneB 			 //AND Gate
( 
    input a,b,
    output x
);
    wire notA,notB,notAOrnotB;

    not(notA,a);
    not(notB,b);
    or(notAOrnotB,notA,notB);
    not(x,notAOrnotB);
endmodule

module twoA( //AND Gate
    input a,b,
    output x
);
    wire nor1,nor2;

    nor(nor1,a,a);
    nor(nor2,b,b);
    nor(x,nor1,nor2);
endmodule

module twoB( //OR Gate
    input a,b,
    output x
);
    wire nand1,nand2;

    nand(nand1,a,a);
    nand(nand2,b,b);
    nand(x,nand1,nand2);
endmodule

module Experiment2;
    reg a,b;
    wire
        NAND1,negativeOR1,NOR1,negativeAND1,
        oneAresult,
        oneBresult,
        twoAresult,
        twoBresult
        ;
    DeMorgan A1(a,b,NAND1,negativeOR1,NOR1,negativeAND1);
    oneA A11(a,b,oneAresult);
    oneB B1(a,b,oneBresult);
    twoA A2(a,b,twoAresult);
    twoB B2(a,b,twoBresult);

    initial
        begin
            $dumpfile("LabExp2.vcd");
	        $dumpvars(-1,A11,B1,A2,B2);
		$display(" ");
	      
        end

    initial begin
        #1 $display("DE MORGAN'S THEOREM");
	#1 $display(" ");
        #1 $display("~((a)(b))");
        #1 a=0; b=0;
           $monitor("a=%b, b=%b, output=%b",a,b,NAND1);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
	#1 $display(" ");
       
        #1 $display("(~a)+(~b)");
        #1 a=0; b=0;
           $monitor("a=%b, b=%b, output=%b",a,b,negativeOR1);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        #1 if (NAND1==negativeOR1) begin
            $display("Therefore, ~((a)(b)) == (~a)+(~b)\n");
        end else begin
            $display("Therefore, ~((a)(b)) != (~a)+(~b)\n");
        end

        #1 $display("~(a+b)");
        #1 a=0; b=0;
           $monitor("a=%b, b=%b, output=%b",a,b,NOR1);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
	#1 $display(" ");

        #1 $display("(~a)(~b)");
        #1 a=0; b=0;
           $monitor("a=%b, b=%b, output=%b",a,b,negativeAND1);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        #1 if (NOR1==negativeAND1) begin
            $display("Therefore, ~(a+b) == (~a)(~b)\n");
        end else begin
            $display("Therefore, ~(a+b) != (~a)(~b)\n");
        end

	 #1 $display("Part 1A: Verifying the OR Circuit");
	#1 a=0; b=0;
           $monitor("a=%b, b=%b, output=%b",a,b,oneAresult);
	#1 a=0; b=1;
        #1 a=1; b=0;
       	#1 a=1; b=1;
	#1 $display(" ");

        #1 $display("Part 1B: Verifying the AND Circuit");
	#1 a=0; b=0;
           $monitor("a=%b, b=%b, output=%b",a,b,oneBresult);
	#1 a=0; b=1;
        #1 a=1; b=0;
       	#1 a=1; b=1;
	#1 $display(" ");

        #1 $display("Part 2A: The NOR Circuit");
           $monitor("a=%b, b=%b, output=%b",a,b,twoAresult);
        #1 a=1; b=0;
        #1 a=0; b=1;
        #1 a=0; b=0;
	#1 $display(" ");
        #1 $display("Part 2B: The NAND Circuit");
           $monitor("a=%b, b=%b, output=%b",a,b,twoBresult);
        #1 a=0; b=1;
        #1 a=1; b=0;
        #1 a=1; b=1;
        #1 $finish;
    end
endmodule