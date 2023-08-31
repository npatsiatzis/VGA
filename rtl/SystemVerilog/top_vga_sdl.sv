`default_nettype none

module top_vga_sdl
    #
    (
        parameter int CORDW /*verilator public*/=10,
        parameter int G_H_RES /*verilator public*/ = 640,
        parameter int G_V_RES /*verilator public*/ = 480,
        parameter int G_H_FP /*verilator public*/ = 16,
        parameter int G_H_SYNC /*verilator public*/ = 96,
        parameter int G_H_BP /*verilator public*/ = 48,
        parameter int G_V_FP /*verilator public*/ = 10,
        parameter int G_V_SYNC /*verilator public*/ = 2,
        parameter int G_V_BP /*verilator public*/ = 33
    )

    (
        input  logic i_clk,
        input  logic i_rst,
        output logic [CORDW-1:0] sdl_sx,
        output logic [CORDW-1:0] sdl_sy,
        output logic sdl_de,
        output logic [7:0] sdl_r,
        output logic [7:0] sdl_g,
        output logic [7:0] sdl_b,
        output logic o_h_sync,
        output logic o_v_sync
    );

    // display sync signals and coordinates
    logic [CORDW-1:0] sx, sy;
    logic w_active;

    display_timings #(
        .G_H_RES,
        .G_V_RES,
        .G_H_FP,
        .G_H_SYNC,
        .G_H_BP,
        .G_V_FP,
        .G_V_SYNC,
        .G_V_BP
        )
    timings (.*,.o_active(w_active),.o_x(sx),.o_y(sy));

    // define a square with screen coordinates
    logic square;
    assign square = (sx > 220 && sx < 420) && (sy > 140 && sy < 340);
    // always_comb begin
    //     square = (sx > 220 && sx < 420) && (sy > 140 && sy < 340);
    // end

    logic [3:0] paint_r, paint_g, paint_b;
    assign paint_r = (square) ? 4'hF : 4'h1;
    assign paint_g = (square) ? 4'hF : 4'h3;
    assign paint_b = (square) ? 4'hF : 4'h7;
    // paint colours: white inside square, blue outside
    // logic [3:0] paint_r, paint_g, paint_b;
    // always_comb begin
    //     paint_r = (square) ? 4'hF : 4'h1;
    //     paint_g = (square) ? 4'hF : 4'h3;
    //     paint_b = (square) ? 4'hF : 4'h7;
    // end

    // SDL output (8 bits per colour channel)
    always_ff @(posedge i_clk) begin
        sdl_sx <= sx;
        sdl_sy <= sy;
        sdl_de <= w_active;
        sdl_r <= {2{paint_r}};  // double signal width from 4 to 8 bits
        sdl_g <= {2{paint_g}};
        sdl_b <= {2{paint_b}};
    end
endmodule
