clear all;
clc;
n = 1/1;  % rate
Vin = 100;    % Input voltage
Vout =100;  %round(Vin * n + Vin * n * 0.2);
num_ite = 1;%round(Vin * n * 0.2)*2-1; 
all_merged_data = [];
    iteration = 1: num_ite % Assume there are multiple loops
    T = 1/20000/2; %frequency
    C1 = 1e-6;   %LC filter
    C3 = 1e-6;   %LC filter
    L1 = 1e-6; %LC filter
    L2 = 1e-6; %LC filter
    Rsw = 0.047;     % Switch resistance

    Vo = 0; %20  % Voltage source

    C2 = 180e-6;  %Input capacitance
    C4 = 100e-6;  %Output capacitance
    Lp = 78.65e-6 ; %the leakage inductances of the primary
    Ls = 1.56e-6; %the leakage inductances of the primary
    Leq = Lp + Ls/(n^2);  % Leq, equivalent leakage inductance
    Rp = 0.25;     % the resistances of the primary
    Rs = 0.063;     % the resistances of the secondary
    Req = Rp + 2*Rsw + (Rs + 2*Rsw)/(n^2)   % print equivalent resistance
    LM = 2600e-6;  %the magnetizing and demagnetizing of the inductor
    RM = 4600;       %the equivalent core loss resistance
    R1 = 0.143;   % Resistor at C2 terminal
    R2 = 0.094;   % Resistor at C4 terminal

    %Steady state value
    
    %Vout = Vout -1; % Output Terminal Voltage
    Fsw = 20000;


    fs = 1/T/2;
    ws = 2*pi*fs;
    Ro = 20; %0.5
    % control
    Tlpf = 1 / (2 * pi * Fsw/10);
    Tsw = 1 / Fsw;
    %running time
    Ts = 0.7;

   


%d = 0.07;
%D = 0.5;
% k1 = 1;
% k2 = 1;
%P = 0.15;
%I = 100;
%iref = 1;
% Ll = 56.604e-6;
%Ll = 58.3e-6;
% Ll = 37.7879e-6;
% LM = 943.311e-6;
% LM = 943.311e-6;
% Rl = 10;
% k1 = 0.91;
% k2 = 0.58;
% Rl = 0.4;
% Rl = 1.25;
% RM = 1500;
% Rl = (394.547+147)/1000;
% k1 = 0.98;
% k2 = 0.92;
% k1 = 1.065;
% k2 = 0.9;
% Ipeak = 0.6;
% Iref = 1;
% k1 = 1.008;
% k2 = 1.007;
%P = (Vin * Vo) / (2 * n * fs * Leq) * d * (1 - d);


%for testing
% d1 = 0.05;
% delta_d = 0.05;
% Ts = 1;
% step_time = 0.2;


