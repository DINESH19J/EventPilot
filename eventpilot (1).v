// EventPilot: Priority-Aware Event-Driven Sequential Control IC
// Initial prototype: 4 request inputs, fixed priority, acknowledgement-based handling.
// Priority: event_req[3] > event_req[2] > event_req[1] > event_req[0]

module eventpilot (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] event_req,
    input  wire       ack,
    output reg  [1:0] event_code,
    output reg        event_valid,
    output wire       busy
);

    localparam IDLE   = 1'b0;
    localparam ACTIVE = 1'b1;

    reg state;

    assign busy = (state == ACTIVE);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= IDLE;
            event_code  <= 2'b00;
            event_valid <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    event_valid <= 1'b0;

                    if (event_req[3]) begin
                        event_code  <= 2'b11;
                        event_valid <= 1'b1;
                        state       <= ACTIVE;
                    end else if (event_req[2]) begin
                        event_code  <= 2'b10;
                        event_valid <= 1'b1;
                        state       <= ACTIVE;
                    end else if (event_req[1]) begin
                        event_code  <= 2'b01;
                        event_valid <= 1'b1;
                        state       <= ACTIVE;
                    end else if (event_req[0]) begin
                        event_code  <= 2'b00;
                        event_valid <= 1'b1;
                        state       <= ACTIVE;
                    end
                end

                ACTIVE: begin
                    if (ack) begin
                        event_valid <= 1'b0;
                        state       <= IDLE;
                    end
                end

                default: begin
                    state       <= IDLE;
                    event_valid <= 1'b0;
                    event_code  <= 2'b00;
                end
            endcase
        end
    end

endmodule
