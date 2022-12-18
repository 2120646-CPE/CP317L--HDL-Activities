module SevenSegment
(
    input inputA,inputB,inputC,inputD,
    output a,b,c,d,e,f,g //these are the pins on the seven segment display
);
    wire notB,notC,notD,BD,notBnotD,notCnotD,CD,
        CnotD,BnotCD,notBC,BnotC,BnotD;

    not(notB,inputB);
    not(notC,inputC);
    not(notD,inputD);

    and(BD,inputB,inputD);
    and(notBnotD,notB,notD); 
    or(a,inputA,inputC,BD,notBnotD); //SegmentA

    and(notCnotD,notC,notD);
    and(CD,inputC,inputD);
    or(b,notB,notCnotD,CD); //SegmentB

    or(c,inputB,notC,inputD); //SegmentC

    and(CnotD,inputC,notD);
    and(BnotCD,inputB,notC,inputD);
    and(notBC,notB,inputC);
    or(d,notBnotD,CnotD,BnotCD,notBC,inputA); //SegmentD

    or(e,notBnotD,CnotD); //SegmentE

    and(BnotC,inputB,notC);
    and(BnotD,inputB,notD);
    or(f,inputA,notCnotD,BnotC,BnotD); //SegmentF

    or(g,inputA,BnotC,notBC,CnotD); //SegmentG
endmodule

module svnsegTestBench;
    reg w,x,y,z; 
    wire a,b,c,d,e,f,g;

    SevenSegment svnseg(w,x,y,z,a,b,c,d,e,f,g);
    
    integer number = 0;

    initial
        begin
            $dumpfile("7Segment.vcd");
	        $dumpvars(-1, svnseg);
	        $monitor("%b", a,b,c,d,e,f,g);
        end

    initial 
        begin
            w=0; x=0; y=0; z=0;
            
            $display("\n7 Segments Display");
            $monitor("A=%b, B=%b, C=%b, D=%b, E=%b, F=%b, G=%b,",a,b,c,d,e,f,g);
            #10 w=0; x=0; y=0; z=1;
            #10 w=0; x=0; y=1; z=0;
            #10 w=0; x=0; y=1; z=1;
            #10 w=0; x=1; y=0; z=0;
            #10 w=0; x=1; y=0; z=1;
            #10 w=0; x=1; y=1; z=0;
            #10 w=0; x=1; y=1; z=1;
            #10 w=1; x=0; y=0; z=0;
            #10 w=1; x=0; y=0; z=1;
            #10 $finish;
        end
endmodule