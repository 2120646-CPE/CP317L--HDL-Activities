//Experiment 3
module Part1Minterm
(
    input a,b,c,
    output i
);
    // simplified POS !A!B + !BC + B!C
    wire notA,notB,notC,BnotC,notBC,notAnotB;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    and(BnotC,b,notC);
    and(notBC,notB,c);
    and(notAnotB,notA,notB);

    or(i,notAnotB,notBC,BnotC);
endmodule

module Part1Maxterm
(
    input a,b,c,
    output i
);
    // simplified SOP (!A+B+C)(!B+!C)
    wire notA,notB,notC,notABC,notBnotC;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    or(notABC,notA,b,c);
    or(notBnotC,notB,notC);

    and(i,notABC,notBnotC);
endmodule

module Part2Minterm
(
    input a,b,c,d,
    output i
);
    // Simplified POS !A!C!B+!ADB+!AD!C+A!BCD+AB!C
    wire notA,notB,notC,
        notAnotCnotB,notADB,
        notADnotC,notABCD,ABnotC;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    and(notAnotCnotB,notA,notC,notB);
    and(notADB,notA,d,b);
    and(notADnotC,notA,d,notC);
    and(AnotBCD,a,notB,c,d);
    and(ABnotC,a,b,notC);

    or(i,notAnotCnotB,notADB,notADnotC,AnotBCD,ABnotC);
endmodule

module Part2Maxterm
(
    input a,b,c,d,
    output i
);
    // Simplified SOP (!A+!B+!C)(!A+B+C)(A+!B+D)(A+B+!C)(!C+D)
    wire notA,notB,notC,
        notAnotBnotC,notABC,AnotBD,
        ABnotC,notCD;

    not(notA,a);
    not(notB,b);
    not(notC,c);

    or(notAnotBnotC,notA,notB,notC);
    or(notABC,notA,b,c);
    or(AnotBD,a,notB,d);
    or(ABnotC,a,b,notC);
    or(notCD,notC,d);

    and(i,notAnotBnotC,notABC,AnotBD,ABnotC,notCD);
endmodule

module LabExp3TestBench;
    reg a,b,c,d;
    wire oneMinterm,oneMaxterm,twoMinterm,twoMaxterm;

    Part1Minterm P1Min(a,b,c,oneMinterm);
    Part1Maxterm P1Max(a,b,c,oneMaxterm);
    Part2Minterm P2Min(a,b,c,d,twoMinterm);
    Part2Maxterm P2Max(a,b,c,d,twoMaxterm);

    initial
        begin
            $dumpfile("LabExp3.vcd");
	        $dumpvars(-1, P1Min,P1Max,P2Min,P2Max);
	        $display(" ");
        end
    initial begin
        #1 a=0;b=0;c=0;
        $display("Part1 Minterm: !A!B + !BC + B!C");
        $monitor("a=%b, b=%b, c=%b : out=%b",a,b,c,oneMinterm);
        #1 a=0;b=0;c=1;
        #1 a=0;b=1;c=0;
        #1 a=0;b=1;c=1;
        #1 a=1;b=0;c=0;
        #1 a=1;b=0;c=1;
        #1 a=1;b=1;c=0;
        #1 a=1;b=1;c=1;

        #1 a=0;b=0;c=0;
	$display(" ");
        $display("Part1 Maxterm: (!A+B+C)(!B+!C)");
        $monitor("a=%b, b=%b, c=%b : out=%b",a,b,c,oneMaxterm);
        #1 a=0;b=0;c=1;
        #1 a=0;b=1;c=0;
        #1 a=0;b=1;c=1;
        #1 a=1;b=0;c=0;
        #1 a=1;b=0;c=1;
        #1 a=1;b=1;c=0;
        #1 a=1;b=1;c=1;

        #1 a=0;b=0;c=0;d=0;
	$display(" ");
        $display("Part2 Minterm: !A!C!B+!ADB+!AD!C+A!BCD+AB!C");
        $monitor("a=%b, b=%b, c=%b, d=%b : out=%b",a,b,c,d,twoMinterm);
        #1 a=0;b=0;c=0;d=1;
        #1 a=0;b=0;c=1;d=0;
        #1 a=0;b=0;c=1;d=1;
        #1 a=0;b=1;c=0;d=0;
        #1 a=0;b=1;c=0;d=1;
        #1 a=0;b=1;c=1;d=0;
        #1 a=0;b=1;c=1;d=1;
        #1 a=1;b=0;c=0;d=0;
        #1 a=1;b=0;c=0;d=1;
        #1 a=1;b=0;c=1;d=0;
        #1 a=1;b=0;c=1;d=1;
        #1 a=1;b=1;c=0;d=0;
        #1 a=1;b=1;c=0;d=1;
        #1 a=1;b=1;c=1;d=0;
        #1 a=1;b=1;c=1;d=1;

        #1 a=0;b=0;c=0;d=0;
	$display(" ");
        $display("Part2 Maxterm: (!A+!B+!C)(!A+B+C)(A+!B+D)(A+B+!C)(!C+D)");
        $monitor("a=%b, b=%b, c=%b, d=%b : out=%b",a,b,c,d,twoMaxterm);
        #1 a=0;b=0;c=0;d=1;
        #1 a=0;b=0;c=1;d=0;
        #1 a=0;b=0;c=1;d=1;
        #1 a=0;b=1;c=0;d=0;
        #1 a=0;b=1;c=0;d=1;
        #1 a=0;b=1;c=1;d=0;
        #1 a=0;b=1;c=1;d=1;
        #1 a=1;b=0;c=0;d=0;
        #1 a=1;b=0;c=0;d=1;
        #1 a=1;b=0;c=1;d=0;
        #1 a=1;b=0;c=1;d=1;
        #1 a=1;b=1;c=0;d=0;
        #1 a=1;b=1;c=0;d=1;
        #1 a=1;b=1;c=1;d=0;
        #1 a=1;b=1;c=1;d=1;
    end
endmodule