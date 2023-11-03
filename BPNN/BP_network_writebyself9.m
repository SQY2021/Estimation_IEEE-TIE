%https://mp.weixin.qq.com/s/EbHgAZ-eU1qTvRnBZ1TSWA
clc;clear;close all;
load('abalone_data.mat')%鲍鱼数据
%% 导入数据
%设置训练数据和测试数据
[m,n]=size(data);
train_num=round(0.8*m); %自变量 
x_train=data(1:train_num,1:n-1);
y_train=data(1:train_num,n);
%测试数据
x_test=data(train_num+1:end,1:n-1);
y_test=data(train_num+1:end,n);

%% 初始化参数
train_num =round(0.8*m); %输入样本数量
test_num = m-round(0.8*m);%测试样本数量
Neurons_num = 6;%隐含层的个数
input_num = n-1;%输入变量数量
output_num = 1;%输出变量数量
[x_train_std,x_train_mu,x_train_sigma] = zscore(x_train);
[y_train_std,y_train_mu,y_train_sigma]= zscore(y_train);

%Z-score标准化，以训练集参数标准化测试集
x_test_std = (x_test-repmat(x_train_mu,test_num,1))./repmat(x_train_sigma,test_num,1);
x_train_std=x_train_std';
y_train_std=y_train_std';
x_test_std=x_test_std';

%网络参数

vij = 2*rand(Neurons_num, input_num)-1 ;%输入和隐藏层的权重
theta_u = 2*rand(Neurons_num, 1)-1 ;%输入与隐藏层之间的阈值
Wj =  2*rand(output_num, Neurons_num)-1 ;%%输出和隐藏层的权重
theta_y =2*rand(output_num, 1)-1 ;%输出与隐藏层之间的阈值

learn_rate = 0.0001;%学习率
Epochs_max = 50000;%最大迭代次数
error_rate = 0.1;%目标误差
Obj_save = zeros(1,Epochs_max);%损失函数
%% 训练网络
epoch_num=0;
while epoch_num <Epochs_max
    epoch_num=epoch_num+1;
  
    y_pre_std_u=vij * x_train_std + repmat(theta_u, 1, train_num);
    y_pre_std_u1 = activation(y_pre_std_u,1);
  
    y_pre_std_y = Wj * y_pre_std_u1 + repmat(theta_y, 1, train_num);
  
    y_pre_std_y1=activation(y_pre_std_y,3);
    
    obj =  y_pre_std_y1-y_train_std ;
    
    Ems = sumsqr(obj);
    Obj_save(epoch_num) = Ems;
 
    if Ems < error_rate
        break;
    end
 
    %梯度下降
    %输出采用sigomd函数，隐藏层采用sigomd激活函数
% %     c_wj= 2*(y_pre_std_y1-y_train_std).*d_activation(y_pre_std_y1,3)* y_pre_std_u1';
%     
   c_theta_y=2*(y_pre_std_y1-y_train_std).*d_activation(y_pre_std_y1,3) ;
   c_wj= c_theta_y* y_pre_std_u1';
    
   
   c_theta_u=Wj'*c_theta_y.*d_activation(y_pre_std_u1,1);
   %c_theta_u=Wj'*c_theta_y.*dlogsig(y_pre_std_y1,1);
   
    c_vij=c_theta_u* x_train_std';
    
    
    
    Wj=Wj-learn_rate*c_wj;
    
    theta_y=theta_y-learn_rate*c_theta_y* ones(train_num, 1);
    
    vij=vij- learn_rate*c_vij; 
    
    theta_u=theta_u-learn_rate*c_theta_u* ones(train_num, 1);
end

test_put = activation((vij * x_test_std + repmat(theta_u, 1, test_num)),1);
test_out_std =activation((Wj * test_put + repmat(theta_y, 1, test_num)),3);
%反归一化
test_pre_out=test_out_std*y_train_sigma+y_train_mu;
errors_nn=sum(abs((test_pre_out'-y_test)./y_test))/length(y_test);
%% 画图
figure(1)
plot(Obj_save,'b-','LineWidth',1.5);
figure(2)
color=[111,168,86;128,199,252;112,138,248;184,84,246]/255;
plot(y_test,'Color',color(2,:),'LineWidth',1)
hold on
plot(test_pre_out,'*','Color',color(1,:))
hold on
titlestr=['BP神经网络','   误差为：',num2str(errors_nn)];
title(titlestr)
%%
d_activation(y_pre_std_y1,3);
function y=activation(x,method) %,1为sigmod ,2为tanh ,3为purling
 %激活函数
  if method==1
        y=logsig(x);      
  elseif method==2
       y=tanh(x);   
  elseif method==3
          y=x;
  end
end

function y=d_activation(x,method) %,1为sigmod ,2为tanh ,3为purling
 %激活函数
 [m,n]=size(x);
  if method==1
        y=(x).*(1-x);      
  elseif method==2
       y=1-(x).^2;   
  elseif method==3
          y=ones(m,n);
  end
end