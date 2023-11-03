%n = 1/2;
n = 1;
T = 1/20000/2;
C1 = 1e-6;%44e-6;
C2 = 180e-6;
C3 = 1e-6;%94e-6;
C4 = 100e-6;
L1 = 1e-6;%15e-6;
L2 = 1e-6;%22e-6;
Ll = 80.3e-6;
R1 = 0.68;
R2 = 0.68;
vc1 = 100;
vc3 = 95;
vc3prm = vc3/n;
d = 0.1;

Vin = 100;
Vo = 0;
k1 = 1;
k2 = 1;

Rl = 1.27;
RM = 2000;
% Req = 1.25;
% RM = 1500;
Rs = 0.0147;
Req = Rl + 10*Rs;
Ro = 0.5;

p = 2*vc3prm/Req + 2/(Req*(1+exp(-Req/Ll*T)))*(-2*exp(-Req/Ll*(1-d)*T))*vc3prm;
q = (T/Req + Ll/Req*2*(exp(-Req/Ll*T)-1)/(Req*(1+exp(-Req/Ll*T))))/T;
r = (((2*d-1)*T/Req + Ll/Req*2*(exp(-Req/Ll*T)-2*exp(-Req/Ll*(1-d)*T)+1)/(Req*(1+exp(-Req/Ll*T))))/n)/T;

x = (-2*T*vc1/Req + 2*T/(Req*(1+exp(-Req/Ll*T)))*(2*exp(-Req/Ll*d*T))*vc1)/T;
y = ((1-2*d)*T/Req + Ll/Req*2*(exp(-Req/Ll*T)-2*exp(-Req/Ll*d*T)+1)/(Req*(1+exp(-Req/Ll*T))))/T;
z = ((-T/Req + Ll/Req*2*(1-exp(-Req/Ll*T))/(Req*(1+exp(-Req/Ll*T))))/n)/T;

% p = -112.2;
% q = 0.144;
% x = 112.2;
% y = 0.133;

num1 = conv([x*R2*C4, x], [L1*C2*R1*C1, L1*(C2*R1*q+C1)+C2*L1, L1*q+C2*R1, 1]);
num2 = L1*p*y*conv([C2*R1, 1], [R2*C4, 1]);
num = num1 - [0, num2, 0];

den1 = conv(conv([n*C3*L2, n*C3*Ro - (z-1/(n*RM))*L2, n - (z-1/(n*RM))*Ro], [R2*C4, 1]), [L1*C2*R1*C1, L1*(C2*R1*q+C1)+C2*L1, L1*q+C2*R1, 1]);
% den2 = [y*r*L2*R2*C4, y*r*L2];
den2 = conv([y*r*L2, y*r*Ro], [R2*C4, 1]);
% den3 = n*L2*C4*[L1*C2*R1*C1, L1*(C2*R1*q+C1)+C2*L1, L1*q+C2*R1, 1];
den3 = conv(n*[L2*C4, Ro*C4], [L1*C2*R1*C1, L1*(C2*R1*q+C1)+C2*L1, L1*q+C2*R1, 1]);
den = den1 + [0,0,0,0,den2] + [0,den3,0];
ans1 = num/den(1);
ans2 = den/den(1);

figure(1);
sys = tf(num, den);
%step(num, den);
bode(num, den);
hold on;
bode(linsys1);
hold off;

