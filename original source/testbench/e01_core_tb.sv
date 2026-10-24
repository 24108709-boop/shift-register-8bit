module e01_core_tb;
    logic clk,rst_n,en,serial_in;
    logic [1:0] mode;
    logic [7:0] parallel_in,q,q_ref;
    logic serial_out;
    integer i;

    e01_core dut(clk,rst_n,en,mode,parallel_in,serial_in,q,serial_out);
    e01_reference ref_i(clk,rst_n,en,mode,parallel_in,serial_in,q_ref);

    always #5 clk=~clk;

    task tick;
        begin @(posedge clk); #1;
            assert(q===q_ref)
                else $fatal(1,"q mismatch q=%h ref=%h",q,q_ref);
        end
    endtask

    task load(input logic [7:0] x);
        begin parallel_in=x; mode=2'b01; tick(); end
    endtask

    initial begin
        clk=0; rst_n=0; en=1; mode=0; parallel_in=0; serial_in=0;
        repeat(2) tick();
        rst_n=1;

        load(8'hA5);
        assert(q==8'hA5);

        // Hold
        mode=2'b00; serial_in=1; tick();
        assert(q==8'hA5);

        // Left shift
        mode=2'b10; serial_in=0; tick();
        assert(q==8'h4A);

        mode=2'b10; serial_in=1; tick();
        assert(q==8'h95);

        // Right shift
        mode=2'b11; serial_in=0; tick();
        assert(q==8'h4A);

        mode=2'b11; serial_in=1; tick();
        assert(q==8'hA5);

        // Enable hold
        en=0; mode=2'b01; parallel_in=8'h3C; tick();
        assert(q==8'hA5);
        en=1;

        // Pattern exercise
        load(8'h96);
        for(i=0;i<8;i=i+1) begin
            mode=2'b10; serial_in=i[0]; tick();
        end

        $display("E01 TB PASS");
        $finish;
    end
endmodule
