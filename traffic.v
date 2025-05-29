module traffic(
input clk,                     // ʱ���ź�
    input reset,                   // �����ź�
    input [4:0] east_vehicles,     // ��·�γ�����
    input [4:0] west_vehicles,     // ��·�γ�����
    input [4:0] north_vehicles,    // ��·�γ�����
    input [4:0] south_vehicles,    // ��·�γ�����

    
    output reg NS_status           // �ϱ�����ͨ��״̬
);
    reg direction_east_west; // ˮƽ������ƣ���������
    reg direction_north_south; // ��ֱ������ƣ��ϱ�����
    reg [4:0] timer_east_west; // ����������̵Ƽ�ʱ��
    reg [4:0] timer_north_south; // �ϱ�������̵Ƽ�ʱ��
// ״̬����
reg EW_status;           // ��������ͨ��״̬
parameter CLEAR = 5'd15;        // ��ͨʱ��ʱ�䣨15�룩
parameter MODERATE = 5'd20;     // ӵ��ʱ��ʱ�䣨20�룩
parameter SEVERE = 5'd30;       // ����ӵ��ʱ��ʱ�䣨30�룩
parameter MAX_VEHICLES = 20;    // ���������������ӵ��״̬��

// �ڲ��źţ���¼��ӵ�µ�·�γ�����
wire [4:0] max_vehicles;
reg [4:0] prev_max_vehicles = 0;  // ��¼��һ�����ڵ��������
reg [4:0] prev_timer_east_west = 0; // ��¼��һ�����ڵĶ���������̵�ʱ��
reg [4:0] prev_timer_north_south = 0; // ��¼��һ�����ڵ��ϱ�������̵�ʱ��
reg [31:0] cnt;
reg clk_1;
// �����ĸ�·���е��������
assign max_vehicles = (east_vehicles > west_vehicles) ? (east_vehicles > north_vehicles ? (east_vehicles > south_vehicles ? east_vehicles : south_vehicles) : (north_vehicles > south_vehicles ? north_vehicles : south_vehicles)) :
                      (west_vehicles > north_vehicles ? (west_vehicles > south_vehicles ? west_vehicles : south_vehicles) : (north_vehicles > south_vehicles ? north_vehicles : south_vehicles));

// ��̬�������̵�ʱ��
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // ��ʼ��״̬
        direction_east_west <= 0;
        direction_north_south <= 1;
        timer_east_west <= CLEAR;
        timer_north_south <= CLEAR;
        prev_max_vehicles <= 0;
        prev_timer_east_west <= CLEAR;
        prev_timer_north_south <= CLEAR;
        EW_status <= 0;
        NS_status <= 1;
        cnt<=0;
    end
    else begin
        // �ж��Ƿ���Ҫ��̬�������̵�ʱ��
        cnt<=cnt+1;
        if (max_vehicles > MAX_VEHICLES) begin
            // ����ӵ�£����Ӻ��̵�ʱ��
            if (prev_max_vehicles != max_vehicles) begin
                timer_east_west <= SEVERE;
                timer_north_south <= SEVERE;
            end
        end
        else if (max_vehicles > MAX_VEHICLES / 2) begin
            // ӵ�£�����Ϊ���еĺ��̵�ʱ��
            if (prev_max_vehicles != max_vehicles) begin
                timer_east_west <= MODERATE;
                timer_north_south <= MODERATE;
            end
        end
        else begin
            // ��ͨ���ָ�Ϊ��ͺ��̵�ʱ��
            if (prev_max_vehicles != max_vehicles) begin
                timer_east_west <= CLEAR;
                timer_north_south <= CLEAR;
            end
        end

        // ���ݳ������仯��̬�������̵�ʱ��
        if (direction_east_west == 1 && timer_east_west > prev_timer_east_west) begin
            // ����������̵�ʱ���ӳ�
            if (east_vehicles > prev_max_vehicles && east_vehicles <= MAX_VEHICLES) begin
                timer_east_west <= timer_east_west + 5;
            end
            else if (east_vehicles > MAX_VEHICLES) begin
                timer_east_west <= timer_east_west + 10;
            end
        end
        else if (direction_north_south == 1 && timer_north_south > prev_timer_north_south) begin
            // �ϱ�������̵�ʱ���ӳ�
            if (north_vehicles > prev_max_vehicles && north_vehicles <= MAX_VEHICLES) begin
                timer_north_south <= timer_north_south + 5;
            end
            else if (north_vehicles > MAX_VEHICLES) begin
                timer_north_south <= timer_north_south + 10;
            end
        end

        // ����״̬
        prev_max_vehicles <= max_vehicles;
        prev_timer_east_west <= timer_east_west;
        prev_timer_north_south <= timer_north_south;
        if (cnt<100_000_000) begin 
           cnt <= cnt+1'b1;
           clk_1<=0;
        end else begin
           clk_1 <= 1;
           cnt <= 0;
       end
        // ÿ����ټ�ʱ��
        if ((timer_east_west > 0) && (clk_1)) begin
            timer_east_west <= timer_east_west - 1;
        end
        if ((timer_north_south > 0)&& (clk_1)) begin
            timer_north_south <= timer_north_south - 1;
        end

        // ÿ�����ڽ������л�����
        if (timer_east_west == 0 && timer_north_south == 0) begin
            direction_east_west <= ~direction_east_west;
            direction_north_south <= ~direction_north_south;
        end

        // ���¶���������ϱ������ͨ��״̬
        EW_status <= (direction_east_west == 1) ? 1 : 0;
        NS_status <= (direction_north_south == 1) ? 1 : 0;
    end
end

endmodule
