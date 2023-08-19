`default_nettype none

module display_timings
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
        input  logic i_clk,
        output logic o_h_sync,
        output logic o_v_sync,
        output logic [9 : 0] o_x,
        output logic [9 : 0] o_y,
        output logic o_active
    );

    logic [9 : 0] r_x;
    logic [9 : 0] r_y;

    // horizontal timings (for VGA 640x480 @60Hz)
    localparam int HorizontalEnd = G_H_RES - 1;
    localparam int HorizontalStart = HorizontalEnd + G_H_FP;
    localparam int HorizontalSyncStart = HorizontalStart + G_H_SYNC;
    localparam int Line = HorizontalSyncStart + G_H_BP;

    // vertical timings (for VGA 640x480 @60Hz)
    localparam int VerticalEnd = G_V_RES - 1;
    localparam int VerticalSyncStart = VerticalEnd + G_V_FP;
    localparam int VerticalSyncEnd = VerticalSyncStart + G_V_SYNC;
    localparam int Frame = VerticalSyncEnd + G_V_BP;

    assign o_active = ($size(HorizontalSyncStart)'(r_x) <= HorizontalEnd &&
        $size(VerticalEnd)'(r_x) <= VerticalEnd) ? 1'b1 : 1'b0;
    assign o_h_sync = ($size(HorizontalStart)'(r_x) > HorizontalStart &&
     $size(HorizontalSyncStart)'(r_x) <= HorizontalSyncStart) ? 1'b0 : 1'b1;
    assign o_v_sync = ($size(VerticalSyncStart)'(r_y) > VerticalSyncStart &&
     $size(VerticalSyncEnd)'(r_y) <= VerticalSyncEnd) ? 1'b0 : 1'b1;

    always_ff @(posedge i_clk) begin : manage_x_y
        if ($size(Line)'(r_x)  == Line) begin
            r_x <= 0;
            if ($size(Frame)'(r_y) == Frame)
                r_y <= 0;
            else
                r_y <= r_y + 1;
        end else
            r_x <= r_x + 1;
     end

    assign o_x = r_x;
    assign o_y = r_y;

endmodule : display_timings
