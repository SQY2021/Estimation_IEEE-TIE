load('gene_avg_RMLM.mat'); % 加载数据文件
exp = gene_avg_RMLM.exp; % 从数据文件中提取 exp 变量
figure(1)
set(gcf, 'position', [100, 100, 350, 600]);
subplot(3, 1, 1);
subplot('position', [0.12, 0.675, 0.84, 0.3]);
plot(d, exp(:, 2), 'ro');
hold on;
plot(d, ori_detail(:, 2), 'kx');
hold on;
plot(d, equ_detail(:, 2), 'k+');
hold on;
plot(d, average(:, 2), 'b^');
hold on; 
plot(d, ori_detail_withoutRM(:, 2), 'kv');
hold on;
plot(d, gene_avg(:, 2), 'g*');
hold on;
plot(d, gene_avg_RMLM(:, 2), 'm*');
hold off;
xlim([0, 0.5]);
set(gca,'xticklabel',[])
%grid on;
ylabel('Output current/A', 'FontWeight', 'bold', 'Fontname', 'times new Roman', 'Fontsize', 8, 'position', [-0.049, 4.5]);
set(gca, 'Fontname', 'times new Roman', 'Fontsize', 8);
subplot(3, 1, 2);
subplot('position', [0.12, 0.36, 0.84, 0.3]);
plot(d, exp(:, 4), 'ro');
hold on;
plot(d, ori_detail(:, 4), 'kx')
hold on;
plot(d, equ_detail(:, 4), 'k+');
hold on;
plot(d, average(:, 4), 'b^');
hold on; 
plot(d, ori_detail_withoutRM(:, 4), 'kv');
hold on;
plot(d, gene_avg(:, 4), 'g*');
hold on;
plot(d, gene_avg_RMLM(:, 4), 'm*');
hold off;
xlim([0, 0.5]);
set(gca,'xticklabel',[])
%grid on;
ylabel('Power losses/W', 'FontWeight', 'bold', 'Fontname', 'times new Roman', 'Fontsize', 8, 'position', [-0.049, 30]);
set(gca, 'Fontname', 'times new Roman', 'Fontsize', 8);
subplot(3, 1, 3);
subplot('position', [0.12, 0.05, 0.84, 0.3]);
plot(d, exp(:, 5), 'ro');
hold on;
plot(d, ori_detail(:, 5), 'kx');
hold on;
plot(d, equ_detail(:, 5), 'k+');
hold on;
plot(d, average(:, 5), 'b^');
hold on; 
plot(d, ori_detail_withoutRM(:, 5), 'kv');
hold on;
plot(d, gene_avg(:, 5), 'g*');
hold on;
plot(d, gene_avg_RMLM(:, 5), 'm*');
hold off;
xlim([0, 0.5]);
ylim([0.7, 0.97]);
%grid on;
ylabel('Efficiency', 'FontWeight', 'bold', 'Fontname', 'times new Roman', 'Fontsize', 8, 'position', [-0.049, 0.825]);
set(gca, 'Fontname', 'times new Roman', 'Fontsize', 8);
xlabel('Phase shift d', 'FontWeight', 'bold', 'Fontname', 'times new Roman', 'Fontsize', 8);
temp = legend('Exp.', 'Det.', 'Equ. Det.', 'RAVM with \it{P_loss}', 'Det. without \it{R_M}', 'FGAM', 'FGAM with RMLM', 3);

% hc = get(temp, 'children');
% text_pos1 = get(hc(3), 'position');
% text_pos2 = get(hc(6), 'position');
% text_pos3 = get(hc(9), 'position');
% text_pos4 = get(hc(12), 'position');
% set(hc(3), 'position', [0.3, 0.5, 0]);

% lines = findobj(temp, 'type', 'line');
% a = get(lines(1), 'XData');
% b = get(lines(2), 'XData');
% set(lines(1), 'XData', 0);

% set(temp, 'Fontname', 'times new Roman', 'Fontsize', 8, 'position', [0.16, 0.073, 0.49, 0.1]);
set(temp, 'Fontname', 'times new Roman', 'Fontsize', 8, 'box', 'off', 'position', [0.05, 0.09, 0.49, 0.1]);
