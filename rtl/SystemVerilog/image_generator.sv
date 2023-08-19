`default_nettype none

/* verilator lint_off MULTITOP */
module image_generator
    (
        input  logic i_clk,
        input  logic i_active,
        output logic [2 : 0] o_r,
        output logic [2 : 0] o_g,
        output logic [1 : 0] o_b
    );

    typedef enum logic [2 : 0] {S[0:5]} state_t;
    state_t state;

    logic [2 : 0] r;
    logic [2 : 0] g;
    logic [1 : 0] b;

    assign o_r = r;
    assign o_g = g;
    assign o_b = b;

    always_ff @(posedge i_clk) begin : image_gen
        if(i_active) begin
            case (state)
                S0 :
                    if (g == (2**$size(g) - 1))
                        state <= S1;
                    else
                        g <= g + 1;
                S1 :
                    if (r == 0)
                        state <= S2;
                    else
                        r <= r - 1;
                S2 :
                    if (b == (2**$size(b) - 1))
                        state <= S3;
                    else
                        b <= b + 1;
                S3 :
                    if (g == 0)
                        state <= S4;
                    else
                        g <= g - 1;
                S4 :
                    if (r == (2**$size(r) - 1))
                        state <= S5;
                    else
                        r <= r + 1;
                S5 :
                    if (b == 0)
                        state <= S0;
                    else
                        b <= b - 1;
                default : begin
                    r <= '1;
                    g <= 0;
                    b <= 0;
                    state <= S0;
                end
            endcase
        end else begin
            r <= '1;
            g <= 0;
            b <= 0;
            state <= S0;
        end
    end

endmodule : image_generator/* verilator lint_on MULTITOP */
