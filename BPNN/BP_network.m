clc;clear;close all;
load('abalone_data.mat')
%%
[m,n]=size(data);
train_num=round(0.8*m); %自变量 
x_train_data=data(1:train_num,1:n-1);
y_train_data=data(1:train_num,n);
x_test_data=data(train_num+1:end,1:n-1);
y_test_data=data(train_num+1:end,n);
x_train_data=x_train_data';
y_train_data=y_train_data';
x_test_data=x_test_data';
[x_train_regular,x_train_maxmin] = mapminmax(x_train_data);
[y_train_regular,y_train_maxmin] = mapminmax(y_train_data);
%创建网络
%%调用形式
net=newff(x_train_regular,y_train_regular,[6,4],{'logsig','tansig','purelin'});
% net=newff(x_train_regular,y_train_regular,[6,3,3],{'logsig','tansig','logsig','purelin'});
%  net=newff(x_train_regular,y_train_regular,6,{'logsig','logsig'});
% net=newff(x_train_regular,y_train_regular,6,{'logsig','purelin'});
% net=newff(x_train_regular,y_train_regular,6,{'logsig','tansig'});
% %设置训练次数
% net.trainParam.epochs = 50000;
% %设置收敛误差
% net.trainParam.goal=0.000001;
% newff(P,T,S,TF,BTF,BLF,PF,IPF,OPF,DDF) takes optional inputs,
%      TF- Transfer function of ith layer. Default is 'tansig' for
%              hidden layers, and 'purelin' for output layer.
%%激活函数的设置
%     compet - Competitive transfer function.
%     elliotsig - Elliot sigmoid transfer function.
%     hardlim - Positive hard limit transfer function.
%     hardlims - Symmetric hard limit transfer function.
%     logsig - Logarithmic sigmoid transfer function.
%     netinv - Inverse transfer function.
%     poslin - Positive linear transfer function.
%     purelin - Linear transfer function.
%     radbas - Radial basis transfer function.
%     radbasn - Radial basis normalized transfer function.
%     satlin - Positive saturating linear transfer function.
%     satlins - Symmetric saturating linear transfer function.
%     softmax - Soft max transfer function.
%     tansig - Symmetric sigmoid transfer function.
%     tribas - Triangular basis transfer function.
%训练网络
[net,~]=train(net,x_train_regular,y_train_regular);
%将输入数据归一化
x_test_regular = mapminmax('apply',x_test_data,x_train_maxmin);
%放入到网络输出数据
y_test_regular=sim(net,x_test_regular);
%将得到的数据反归一化得到预测数据
BP_predict=mapminmax('reverse',y_test_regular,y_train_maxmin);
% RBF_predict(find(RBF_predict<0))=-0.244;
%%%
BP_predict=BP_predict';
errors_nn=sum(abs(BP_predict-y_test_data)./(y_test_data))/length(y_test_data);
figure(1)
color=[111,168,86;128,199,252;112,138,248;184,84,246]/255;
plot(y_test_data,'Color',color(2,:),'LineWidth',1)
hold on
plot(BP_predict,'*','Color',color(1,:))
hold on
titlestr=['MATLAB自带BP神经网络','   误差为：',num2str(errors_nn)];
title(titlestr)
