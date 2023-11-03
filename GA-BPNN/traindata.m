function createfigure(X1, YMatrix1, X2, Y1, X3, Y2, X4, Y3)
%CREATEFIGURE(X1, YMatrix1, X2, Y1, X3, Y2, X4, Y3)
%  X1:  x 数据的向量
%  YMATRIX1:  y 数据的矩阵
%  X2:  x 数据的向量
%  Y1:  y 数据的向量
%  X3:  x 数据的向量
%  Y2:  y 数据的向量
%  X4:  x 数据的向量
%  Y3:  y 数据的向量

%  由 MATLAB 于 12-Sep-2023 08:41:12 自动生成

% 创建 figure
figure1 = figure('Tag','TRAINING_PLOTPERFORM','NumberTitle','off',...
    'Name','神经网络训练 性能 (plotperform)，轮: 114 , Training finished: Met validation criterion');

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 semilogy 的矩阵输入创建多行
semilogy1 = semilogy(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
set(semilogy1(1),'DisplayName','训练','Color',[0 0 1]);
set(semilogy1(2),'DisplayName','验证','Color',[0 0.8 0]);
set(semilogy1(3),'DisplayName','测试','Color',[1 0 0]);

% 创建 semilogy
semilogy(X2,Y1,'DisplayName','最佳','LineStyle',':','Color',[0 0.48 0]);

% 创建 semilogy
semilogy(X3,Y2,'MarkerSize',16,'Marker','o','LineWidth',1.5,...
    'LineStyle','none',...
    'Color',[0 0.48 0]);

% 创建 semilogy
semilogy(X4,Y3,'DisplayName','目标','LineStyle',':','Color',[0 0 0]);

% 创建 ylabel
ylabel('均方误差 (mse)','FontWeight','bold','FontSize',12);

% 创建 xlabel
xlabel('114 轮','FontWeight','bold','FontSize',12);

% 创建 title
title('最佳 验证 性能是第 108 轮的 0.00011212','FontWeight','bold','FontSize',12);

% 取消以下行的注释以保留坐标区的 X 范围
% xlim(axes1,[0 114]);
% 取消以下行的注释以保留坐标区的 Y 范围
% ylim(axes1,[9e-07 11]);
hold(axes1,'off');
% 设置其余坐标区属性
set(axes1,'YMinorTick','on','YScale','log');
% 创建 legend
legend(axes1,'show');

% uicontrol 当前不支持代码生成，请输入正确输入语法对应的 'doc uicontrol'
% 可以使用 GUIDE 来为 uicontrol 生成代码。有关详细信息，请输入 'doc guide'
% uicontrol(...);

