% =========================================================================
% 第5题：卷积法求取小功率随动系统跟踪误差
% =========================================================================
clc; clear; close all;

% 1. 定义系统参数
K = 500;
T = 0.025;
alpha_T = 0.15; 
a = 0.5;

% 2. 建立传递函数模型
s = tf('s');
Gk = (K * (T*s + 1)) / (s * (alpha_T*s + 1));
% 误差 E(s) 对输入速度 sR(s) 的传递函数
G_v2e = 1 / (s * (1 + Gk));

%% --- 替换部分开始 ---
% 直接生成输入角速度信号 (目标方位角速度)
dt = 0.001; 
t = -5:dt:5;          
A_dot = a ./ (1 + (a * t).^2); 

% 使用 lsim 直接计算响应，底层完美积分，彻底消灭手动卷积误差
e_t = lsim(G_v2e, A_dot, t);
%% --- 替换部分结束 ---

% 6. 绘图展示
figure('Name', '第5题：卷积法求取的系统跟踪误差', 'Color', 'w');
plot(t, e_t, 'b-', 'LineWidth', 2);
grid on;
set(gca, 'FontSize', 12);
xlabel('时间 t (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('跟踪误差 e(t) (rad)', 'FontSize', 14, 'FontWeight', 'bold');
title('卷积法求取的小功率随动系统跟踪误差', 'FontSize', 16, 'FontWeight', 'bold');

% 标注最大误差值 (此时应回归理论值 ~0.001)
max_error = max(e_t);
text(0, max_error*0.9, sprintf('最大误差: %.4f rad', max_error), 'FontSize', 12, 'Color', 'r');