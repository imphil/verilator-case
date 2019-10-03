module verilator_case(input logic clk_i);

  logic [2:0] counter;

  function void with_case();
    string      mystr;
    case (counter)
      3'b000: mystr = "case-0";
      3'b001: mystr = "case-1";
      3'b010: mystr = "case-2";
      3'b100: mystr = "case-4";
      3'b101: mystr = "case-5";
`ifdef WITH_DEFAULT
      default: mystr = "case-default";
`endif
    endcase

    $display("with_case: %d = %s", counter, mystr);
    return;
  endfunction

  function void with_if();
    string      mystr;
    if (counter == 3'b000) begin
      mystr = "if-0";
    end else if (counter == 3'b001) begin
      mystr = "if-1";
    end else if (counter == 3'b010) begin
      mystr = "if-2";
    end else if (counter == 3'b100) begin
      mystr = "if-4";
    end else if (counter == 3'b101) begin
      mystr = "if-5";
    end
`ifdef WITH_DEFAULT
    else begin
      mystr = "if-default";
    end
`endif

    $display("with_if: %d = %s", counter, mystr);
  endfunction

  always_ff @(posedge clk_i) begin
    counter <= counter + 1;

    if (counter == 3'b111) begin
      $finish;
    end
  end

  always_comb begin
    with_case();
    with_if();
  end
endmodule
