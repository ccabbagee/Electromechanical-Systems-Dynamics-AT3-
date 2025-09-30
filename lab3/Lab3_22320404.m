U = 12;
psi = 0.28648;
Ra = 0.35;
La = 0.00035;
J_M = 0.00234;
J_L = 0.00703;
b = 0.06;
k = 350;


s = tf('s');
% W1
num1 = [psi*J_L, psi*b, psi*k];
den1 = [La*J_M*J_L, (La*b*(J_M+J_L)+Ra*J_M*J_L), (La*(J_M+J_L)*k+Ra*(J_M+J_L)*b+psi^2*J_L), (psi^2*b+Ra*((J_M+J_L)*k)), psi^2*k];
W1 = tf(num1, den1);

% W2
num2 = [psi*b, psi*k];
den2 = den1;
W2 = tf(num2, den2);

% Plot Bode diagram
% 绘制 W1 的独立Bode图
figure;
bode(W1);
grid on;
title('Bode plots of transfer functions W1');

% 绘制 W2 的独立Bode图
figure;
bode(W2);
grid on;
title('Bode plots of transfer functions W2');

% 绘制 W1 和 W2 的对比Bode图（同图显示）
figure;
bode(W1, W2);  % 直接传入多个系统，自动区分颜色
grid on;
title('Bode plots of transfer functions W1 & W2');
legend('W1', 'W2');  % 可选：添加图例明确标识

%% Task 3
u = out.INPUT(:, 1);
y = out.OUTPUT(:, 1);
Ts = 1e-3;
[txy, f] = tfestimate(u,y,[],[],[],(1 / Ts));
om = 2 * pi * f;
L = 20 * log10(abs(txy));
figure();
plot(om, L, '-k');
xlim([0.1, 5000]);
xlabel('\omega_M , rad/s')
ylabel('L, dB')
ax = gca;
set(ax,'XScale','log')
grid on
hold all 

%Define number of poles and number of zeros
pole_num = 4;
zero_num = 2;
sys_fr = idfrd(txy,om,Ts);
id_freq_tf = tfest(sys_fr, pole_num, zero_num);
w_ident_1 = tf(id_freq_tf.num, id_freq_tf.den);
bodemag(w_ident_1, '--r');
grid on;


figure();
plot(om, L, '-k');
hold all 
bode(W1);
hold on;
bode(W2);
bodemag(w_ident_1, '--r');
grid on;
title('comparison')