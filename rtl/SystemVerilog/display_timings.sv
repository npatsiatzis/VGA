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
        input  logic i_rst,
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
    localparam int HorizontalSyncStart = HorizontalEnd + G_H_FP;
    localparam int HorizontalSyncEnd = HorizontalSyncStart + G_H_SYNC;
    localparam int Line = HorizontalSyncEnd + G_H_BP;

    // vertical timings (for VGA 640x480 @60Hz)
    localparam int VerticalEnd = G_V_RES - 1;
    localparam int VerticalSyncStart = VerticalEnd + G_V_FP;
    localparam int VerticalSyncEnd = VerticalSyncStart + G_V_SYNC;
    localparam int Frame = VerticalSyncEnd + G_V_BP;

    assign o_active = ($size(HorizontalEnd)'(r_x) <= HorizontalEnd &&
        $size(VerticalEnd)'(r_y) <= VerticalEnd) ? 1'b1 : 1'b0;

    assign o_h_sync = ($size(HorizontalSyncStart)'(r_x) > HorizontalSyncStart &&
     $size(HorizontalSyncEnd)'(r_x) <= HorizontalSyncEnd) ? 1'b0 : 1'b1;

    assign o_v_sync = ($size(VerticalSyncStart)'(r_y) > VerticalSyncStart &&
     $size(VerticalSyncEnd)'(r_y) <= VerticalSyncEnd) ? 1'b0 : 1'b1;

    always_ff @(posedge i_clk) begin : manage_x_y
        if(i_rst) begin
            r_x <= 0;
            r_y <= 0;
        end
        else begin 
            if ($size(Line)'(r_x)  == Line) begin
                r_x <= 0;
                if ($size(Frame)'(r_y) == Frame)
                    r_y <= 0;
                else
                    r_y <= r_y + 1;
            end else
                r_x <= r_x + 1;
        end
     end

    assign o_x = r_x;
    assign o_y = r_y;

                        /*          ######################      */
                        /*          Assertions && Coverage      */
                        /*          ######################      */
    assert_h_sync_0 : assert property (@(posedge i_clk) ($size(HorizontalSyncStart)'(r_x) > HorizontalSyncStart &&
     $size(HorizontalSyncEnd)'(r_x) <= HorizontalSyncEnd) |-> o_h_sync == 1'b0);
    assert_h_sync_1 : assert property (@(posedge i_clk) !($size(HorizontalSyncStart)'(r_x) > HorizontalSyncStart &&
     $size(HorizontalSyncEnd)'(r_x) <= HorizontalSyncEnd) |-> o_h_sync == 1'b1);

    assert_v_sync_0 : assert property (@(posedge  i_clk) ($size(VerticalSyncStart)'(r_y) > VerticalSyncStart &&
     $size(VerticalSyncEnd)'(r_y) <= VerticalSyncEnd) |-> o_v_sync == 1'b0);
    assert_v_sync_1 : assert property (@(posedge  i_clk) !($size(VerticalSyncStart)'(r_y) > VerticalSyncStart &&
     $size(VerticalSyncEnd)'(r_y) <= VerticalSyncEnd) |-> o_v_sync == 1'b1);


    assert_x_range : assert property(@(posedge i_clk) $size(Line)'(r_x) <= Line);
    assert_y_range : assert property(@(posedge i_clk) $size(Frame)'(r_y) <= Frame);
    assert_x_wrap : assert property (@(posedge i_clk) $size(Line)'(r_x) == Line |=> $size(Line)'(r_x) == 0);
    assert_y_wrap : assert property (@(posedge i_clk) $size(Frame)'(r_y) == Frame && $size(Line)'(r_x) == Line  |=> $size(Frame)'(r_y) == 0);
    cover_x_wrap : cover property (@(posedge i_clk) $size(Line)'(r_x) == 0 && $past($size(Line)'(r_x)) == Line);
    cover_y_wrap : cover property (@(posedge i_clk) $size(Frame)'(r_y) == 0 && $size(Line)'(r_x) == 0  && $past($size(Frame)'(r_y)) == Frame);
    

endmodule : display_timings
