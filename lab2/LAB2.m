U = 12;
Ra = 0.35;
La = 0.00035;
psi = 0.28648;
J1 = 0.00035;
J2 = 0.00234;
J= J1;
%T_L = 0;


T_L = 0.68755;
%U = 0;


% Define time limits
start_time = 0;
stop_time = 0.3;
% Define time step
time_step = 0.001;
% Define the array of times
t = start_time:time_step:stop_time;



% Define system parameters

zeta1 = Ra/2*sqrt(J1/(La*psi^2)); % Damping ratio
w_n1 = sqrt(psi^2/(J1*La)); % Natural frequency
w_d1 = w_n1 * sqrt(1 - zeta1^2); % Damped natural frequency

zeta2 = Ra/2*sqrt(J2/(La*psi^2)); 
w_n2 = sqrt(psi^2/(J2*La)); 
w_d2 = w_n2 * sqrt(1 - zeta2^2); 

% Define the function omega(t)
y_t1 = (U/psi) * (1 - exp(-zeta1 * w_n1 * t) .* (cos(w_d1 * t) + (zeta1 / sqrt(1 - zeta1^2)) * sin(w_d1 * t)));
y_t2 = (U/psi) * (1 - exp(-zeta2 * w_n2 * t) .* (cos(w_d2 * t) + (zeta2 / sqrt(1 - zeta2^2)) * sin(w_d2 * t)));



% Draw the graph of omega(t)
figure;
plot(t, y_t1)
grid on
xlabel('Time (t)')
ylabel('y(t)')
title('Transient Response of y(t1)')

figure;
plot(t, y_t2)
grid on
xlabel('Time (t)')
ylabel('y(t)')
title('Transient Response of y(t2)')


K1 = 1/psi;
ksi1 = zeta1;
W1 = tf(K1 * w_n1^2, [1, 2 * zeta1 * w_n1, w_n1^2]);

K2 = 1/psi;
ksi2 = zeta2;
W2 = tf(K2 * w_n2^2, [1, 2 * zeta2 * w_n2, w_n2^2]);


% Plot Bode diagram
figure;
bode(W1);
grid on;



















