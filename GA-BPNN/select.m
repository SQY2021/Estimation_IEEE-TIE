function [new_chrom,new_fitness]=select(input_chrom,fitness_group,group_num)
% 用轮盘赌在原来的函数里选择
% fitness_group    种群信息
% group_num     种群规模
% newgroup        选择后的新种群
%求适应度值倒数，取适应度值最小，即概率最大，所以求反  
fitness1=10./fitness_group; %individuals.fitness为个体适应度值
%个体选择概率
sumfitness=sum(fitness1);
sumf=fitness1./sumfitness;  %个体被选中的概率
%采用轮盘赌法选择新个体
index=[];
for i=1:group_num   %group_num为种群数，%转sizepop次轮盘
    pick=rand;      % 随机生成一个介于 0 和 1 之间的随机数。
    while pick==0   
        pick=rand;       
    end
   for j=1:group_num   %转轮子
        pick=pick-sumf(j);       
        if pick<0       
            index=[index j];           
            break; 
        end
   end
   if length(index) == group_num
        break;
  end
end

%新种群
new_chrom=input_chrom(index,:);   
new_fitness=fitness_group(index);
end