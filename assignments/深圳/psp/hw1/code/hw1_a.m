syms Z0 X0 v t
E = atan(Z0 / sqrt(X0^2 + v^2 * t^2));
dE_dt = simplify(diff(E, t));
d2E_dt2 = simplify(diff(dE_dt, t));

disp('E:');
disp(latex(E));
disp('First derivative (dE/dt):');
disp(latex(dE_dt));
disp('Second derivative (d^2E/dt^2):');
disp(latex(d2E_dt2));

% 定义符号变量顺序
vars = [Z0, X0, v, t];

% 转换为函数句柄
E_func = matlabFunction(E, 'Vars', vars);
dE_dt_func = matlabFunction(dE_dt, 'Vars', vars);
d2E_dt2_func = matlabFunction(d2E_dt2, 'Vars', vars);

% 绘制 E(t), dE/dt, d2E/dt2 的时域图像
figure;
plot(t_vals, E_vals, 'r',t_vals, dE_dt_vals, 'g', t_vals, d2E_dt2_vals, 'b', 'LineWidth', 2);
xlabel('Time (s)');
xlim([-0.05, 4]);
ylabel('Value');
legend('E(t)', "E'(t)", "E''(t)");
title('E(t), E''(t), and E''''(t)的时域图像');
grid on;

% 参数值
Z0_val = 1;
X0_val = 1;
v_val = 2;

% 时间向量
t_vals = linspace(0, 10, 1000);

% 计算 E(t), dE/dt, d2E/dt2 的数值
E_vals = E_func(Z0_val, X0_val, v_val, t_vals);
dE_dt_vals = dE_dt_func(Z0_val, X0_val, v_val, t_vals);
d2E_dt2_vals = d2E_dt2_func(Z0_val, X0_val, v_val, t_vals);


N = length(t_vals);
Fs = 1 / (t_vals(2) - t_vals(1)); % 采样频率
f = Fs * (0:(N/2))/N; % 频率轴

% 计算 FFT 并取绝对值
E_fft = abs(fft(E_vals));
dE_dt_fft = abs(fft(dE_dt_vals));
d2E_dt2_fft = abs(fft(d2E_dt2_vals));

% 只保留正频率部分
E_fft = E_fft(1:N/2+1);
dE_dt_fft = dE_dt_fft(1:N/2+1);
d2E_dt2_fft = d2E_dt2_fft(1:N/2+1);


figure;
plot(f, E_fft, 'r', f, dE_dt_fft, 'g', f, d2E_dt2_fft, 'b', 'LineWidth', 2);
xlabel('Frequency (Hz)');
xlim([-0.1, 2]);
ylabel('Magnitude');
legend('E(t)', 'dE/dt', 'd^2E/dt^2');
title('角度、角速度、角加速度的频谱分析结果');
grid on;