% 参数设置
alpha = pi / 4; % 角度 alpha，单位为弧度
s = linspace(-10, 10, 1000); % s 的范围，从 -10 到 10

% 计算 sin(alpha + i*s)
z = alpha + 1i * s; % 复数输入 z = alpha + i*s
sin_z = sin(z); % 计算复正弦

% 分解实部和虚部
real_part = real(sin_z); % 实部
imag_part = imag(sin_z); % 虚部
magnitude = abs(sin_z); % 模长

% 绘制轨迹图
figure;
plot(real_part, imag_part, 'b', 'LineWidth', 1.5); % 实部 vs 虚部
hold on;
scatter(real_part(1), imag_part(1), 50, 'r', 'filled'); % 起点
scatter(real_part(end), imag_part(end), 50, 'g', 'filled'); % 终点
grid on;
xlabel('Real Part (实部)');
ylabel('Imaginary Part (虚部)');
title(['Trajectory of sin(\alpha + i s) in Complex Plane (\alpha = ', num2str(alpha), ')']);
legend('Trajectory', 'Start Point', 'End Point');
axis equal;

% 绘制模长随 s 的变化
figure;
plot(s, magnitude, 'm', 'LineWidth', 1.5);
grid on;
xlabel('s');
ylabel('|sin(\alpha + i s)|');
title(['Magnitude of sin(\alpha + i s) (\alpha = ', num2str(alpha), ')']);
legend('Magnitude');