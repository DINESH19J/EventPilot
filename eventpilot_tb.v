`timescale 1ns/1ps

module eventpilot_tb;

    reg clk;
    reg rst_n;
    reg [3:0] event_req;
    reg ack;

    wire [1:0] event_code;
    wire event_valid;
    wire busy;

    integer pass_count;

    eventpilot dut (
        .clk(clk),
        .rst_n(rst_n),
        .event_req(event_req),
        .ack(ack),
        .event_code(event_code),
        .event_valid(event_valid),
        .busy(busy)
    );

    always #5 clk = ~clk;

    task check_event;
        input [3:0] requests;
        input [1:0] expected_code;
        begin
            // Start a request while the controller is idle.
            @(negedge clk);
            event_req = requests;
            ack = 1'b0;

            @(posedge clk);
            #1;

            if (event_valid !== 1'b1 ||
                event_code !== expected_code ||
                busy !== 1'b1) begin
                $display("FAIL: req=%b code=%b valid=%b busy=%b expected_code=%b",
                         requests, event_code, event_valid, busy, expected_code);
                $fatal(1, "Event selection check failed");
            end else begin
                $display("PASS: req=%b selected_code=%b valid=%b busy=%b",
                         requests, event_code, event_valid, busy);
                pass_count = pass_count + 1;
            end

            // Acknowledge the active event.
            @(negedge clk);
            ack = 1'b1;

            @(posedge clk);
            #1;

            if (event_valid !== 1'b0 || busy !== 1'b0) begin
                $display("FAIL: acknowledgement did not clear active status");
                $fatal(1, "Acknowledgement check failed");
            end else begin
                $display("PASS: acknowledgement returned controller to IDLE");
                pass_count = pass_count + 1;
            end

            @(negedge clk);
            ack = 1'b0;
            event_req = 4'b0000;
        end
    endtask

    initial begin
	$dumpfile("eventpilot.vcd");
        $dumpvars(0, eventpilot_tb);
        clk = 1'b0;
        rst_n = 1'b0;
        event_req = 4'b0000;
        ack = 1'b0;
        pass_count = 0;

        // Verify reset state.
        repeat (2) @(negedge clk);
        #1;
        if (event_valid !== 1'b0 || busy !== 1'b0 || event_code !== 2'b00) begin
            $display("FAIL: reset state incorrect");
            $fatal(1, "Reset check failed");
        end else begin
            $display("PASS: reset state");
            pass_count = pass_count + 1;
        end

        rst_n = 1'b1;

        check_event(4'b0001, 2'b00);
        check_event(4'b0010, 2'b01);
        check_event(4'b0100, 2'b10);
        check_event(4'b1000, 2'b11);

        // Multiple simultaneous requests: highest priority must win.
        check_event(4'b1011, 2'b11);
        check_event(4'b0111, 2'b10);
        check_event(4'b0011, 2'b01);
        check_event(4'b1111, 2'b11);

        $display("------------------------------------");
        $display("ALL TESTS PASSED. Checks completed: %0d", pass_count);
        $display("------------------------------------");
        $finish;
    end

endmodule
