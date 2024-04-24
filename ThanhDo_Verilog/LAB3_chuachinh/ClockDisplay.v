module ClockDisplay(
    input clk,    // Clock input from the FPGA, e.g., 50MHz
    input reset,  // Reset input
	 input reset_day,
	 input reset_month,
	 input button, // chuyển đổi trạng thái các state 
	 input SW0, // SWitch0
    output [6:0] Hex_0, // Output to 7-segment LED for the units digit
    output [6:0] Hex_1,  // Output to 7-segment LED for the tens digit
	 output [6:0] Hex_2, 
    output [6:0] Hex_3,
	 output [6:0] Hex_4, 
    output [6:0] Hex_5 
);

localparam JAN = 1, FEB = 2;
// Declare wire to connect modules
wire [5:0] seconds; 
wire [5:0] minutes; 
wire [4:0] hours; 
wire [4:0] days;
wire [3:0] months;
wire [6:0] years;
// Khai báo wire one_hz để nhận clock 1Hz
wire one_hz_signal;
// Khai báo wire one_min để nhận clock 1 phút
wire one_min;
// Khai báo wire one_hour để nhận clock 1 giờ
wire one_hour;
// Khai báo wire one_day để nhận clock 1 ngày
wire one_day;
// Khai báo wire one_mouth để nhận clock 1 tháng
wire one_month;
// Khai báo wire one_year để nhận clock 1 1 nam
wire one_year;
// Khai báo wire leap_year để nhận năm nhuận
wire leap_year;
// Instance của one_hz_clock
localparam SHOW_TIME = 1'b0,
           SHOW_DATE = 1'b1;
reg state = SHOW_TIME; // Biến lưu trạng thái hiện tại của FSM

// Calculate the digits
wire [3:0] tens_seconds;
wire [3:0] ones_seconds;

wire [3:0] tens_minutes;
wire [3:0] ones_minutes;

wire [3:0] tens_hours;
wire [3:0] ones_hours;

wire [3:0] tens_days;
wire [3:0] ones_days;

wire [3:0] tens_months;
wire [3:0] ones_months;

wire [3:0] tens_years;
wire [3:0] ones_years;



one_hz_clock OHC(
    .clk(clk),
    .reset(reset),
    .one_hz(one_hz_signal)
);


// Instance of SecondCounter
SecondCounter sc(
    .clk(one_hz_signal),
    .reset(reset),
    .second(seconds),
	 .one_min(one_min)
);
BinaryToBCD BCDsecond(
    .binary(seconds),
    .tens(tens_seconds),
	.ones(ones_seconds)
);


MinuteCounter mc(
	.clk(one_min),
	.reset(reset),
	.minute(minutes),
	.one_hour(one_hour)
);
BinaryToBCD BCDminute(
    .binary(minutes),
    .tens(tens_minutes),
	 .ones(ones_minutes)
);


HourCounter hc(
	.clk(one_hour),
	.reset(reset),
	.hour(hours),
	.one_day(one_day)
);
BinaryToBCD BCDhour(
    .binary(hours),
    .tens(tens_hours),
	 .ones(ones_hours)
);

DayCounter dc(
	.clk(one_day),
	.reset(reset),
	.leap_year(leap_year),
	.day(days),
	.one_month(one_month)
);
BinaryToBCD BCDdays(
    .binary(days),
    .tens(tens_days),
	 .ones(ones_days)
);

MonthCounter monthc(
	.clk(one_month),
	.reset(reset),
	.month(months),
	.one_year(one_year)
);
BinaryToBCD BCDmonths(
    .binary(months),
    .tens(tens_months),
	 .ones(ones_months)
);

YearCounter yc(
	.clk(one_year),
	.reset(reset),
	.year(years),
	.leap_year(leap_year)
);
BinaryToBCD BCDyears(
    .binary(years),
    .tens(tens_years),
	 .ones(ones_years)
);

// Calculate the digits
reg [3:0] units_digit_1;
reg [3:0] tens_digit_1;

reg [3:0] units_digit_2;
reg [3:0] tens_digit_2;

reg [3:0] units_digit_3;
reg [3:0] tens_digit_3;

				// Instance of LEDDisplay for seconds
LEDDisplay hex_0(
	 .value(units_digit_1), 
	 .seg(Hex_0) 
);

LEDDisplay hex_1(
	 .value(tens_digit_1), 
	 .seg(Hex_1) 
);
// Instance of LEDDisplay for minutes

LEDDisplay hex_2(
	 .value(units_digit_2), 
	 .seg(Hex_2)
);
LEDDisplay hex_3(
	 .value(tens_digit_2), 
	 .seg(Hex_3) 
);


// Instance of LEDDisplay for hours

LEDDisplay hex_4(
	 .value(units_digit_3), 
	 .seg(Hex_4)
);
LEDDisplay hex_5(
	 .value(tens_digit_3), 
	 .seg(Hex_5) 
);




// FSM update logic
always @(posedge clk or negedge reset or negedge button  ) begin
    if (~reset) begin
        state <= SHOW_TIME;
    end
    else if (~button) begin // Assuming button_pressed is debounced signal of button
	 if (state==SHOW_TIME) state <= SHOW_DATE;
	 else state <= SHOW_TIME;
        case (state)
            SHOW_TIME: state <= SHOW_DATE;
            SHOW_DATE: state <= SHOW_TIME;
            default: state <= SHOW_TIME;
        endcase
    end
end

// Based on the state, control the segment outputs
always @(state) begin
    case (state)
        SHOW_TIME: begin
            // Code to set Hex_0, Hex_1, Hex_2, Hex_3 for showing time
				units_digit_1 <= ones_seconds;
				tens_digit_1 <= tens_seconds; 

				units_digit_2 <= ones_minutes;
				tens_digit_2 <= tens_minutes;

				units_digit_3 <= ones_hours;
				tens_digit_3 <= tens_hours;

        end
        SHOW_DATE: begin
            // Code to set segments for showing date
            // You will need to modify or add more segment outputs if you want to show the date
				units_digit_3 <= ones_years;
				tens_digit_3 <= tens_years;
				
				units_digit_2 <= ones_months;
				tens_digit_2 <= tens_months;
				
				units_digit_1 <= ones_days; 
				tens_digit_1 <= tens_days;


        end
    endcase
end


endmodule
