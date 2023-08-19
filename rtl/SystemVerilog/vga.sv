`default_nettype none

module vga
    #
    (
        parameter int G_H_RES = 640,
        parameter int G_V_RES = 480,
        parameter int G_H_FP = 16,
        parameter int G_H_SYNC = 96,
        parameter int G_H_BP = 48,
        parameter int G_V_FP = 10,
        parameter int G_V_SYNC = 2,
        parameter int G_V_BP = 33
    )

    (
        input logic i_clk,
        output logic o_h_sync,
        output logic o_v_sync,
        output logic [2 : 0] o_r,
        output logic [2 : 0] o_g,
        output logic [1 : 0] o_b,
        output logic o_active
    );

    logic [9 : 0] w_x;
    logic [9 : 0] w_y;
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
    timings (.*,.o_active(w_active),.o_x(w_x),.o_y(w_y));

    image_generator image (.*,.i_active(w_active));

    assign o_active = w_active;
endmodule : vga
