% 参数设置
dt = 0.01;
t = -5:dt:5;

% 第一张图：方位角和方位角速度
A = atan(0.5 * t);
dA = 0.5 ./ (1 + (0.5 * t).^2); % dA/dt = 0.5 / (1 + (0.5 * t)^2)
figure;
plot(t, A, 'b', t, dA, 'r', "LineWidth", 2);
lgd = legend({'$A(t)$', '$\frac{dA}{dt}$'},  'Interpreter', 'latex');
xlabel("$t/s$", "Interpreter", "latex");
xlim([-5, 5]);
ylabel("值", "Interpreter", "latex");
title("方位角及其速度图像");
grid on;

% 第二张图：脉冲响应
t1 = 0:dt:0.2;
pulseWidth = 0.01;
pulse = rectpuls(t1, pulseWidth);

num = [0.15, 1];
den = [0.15, 13.5, 500];
sys = tf(num, den);

y = lsim(sys, pulse, t1);
figure;
plot(t1, y, "Marker", ".", "MarkerEdgeColor", "r", "LineWidth", 2);
xlabel("$t/s$", "Interpreter", "latex");
ylabel("$w(k)$", "Interpreter", "latex");
title("脉冲响应输出");
grid on;

% 第三张图：卷积法求取的跟踪误差
y = y(1:16);
t2 = -5:dt:5+(length(y)-1)*dt;
e = conv(y, dA);
figure;
plot(t2, e, "LineWidth", 2);
xlabel("$t/s$", "Interpreter", "latex");
ylabel("$e(t)/rad$", "Interpreter", "latex");
title("卷积法求取的跟踪误差");
grid on;