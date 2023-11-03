function new_chrom=Mutation(mutation_pro,lenchrom,input_chrom,group_num,num,iter_num,limit)
% 本函数完成变异操作
% mutation_pro           变异概率
% lenchrom                 染色体长度
% input_chrom   输入交叉过后的染色体
% group_num              种群规模
% iter_num             最大迭代次数
% limit                  每个个体的上限和下限
% num                   当前迭代次数
% new_chrom           变异后的染色体
for i=1:group_num   %每一轮for循环中，可能会进行一次变异操作，染色体是随机选择的，变异位置也是随机选择的，
    %但该轮for循环中是否进行变异操作则由变异概率决定（continue控制）
    % 随机选择一个染色体进行变异
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*group_num);
    % 变异概率决定该轮循环是否进行变异
    pick=rand;
    if pick>mutation_pro
        continue;
    end
    flag=0;
    while flag==0
        % 变异位置
        pick=rand;
        while pick==0     
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));  %随机选择了染色体变异的位置，即选择了第pos个变量进行变异
        pick=rand; %变异开始    
        fg=(pick*(1-num/iter_num))^2;
        if pick>0.5
            input_chrom(index,pos)=input_chrom(index,pos)+(limit(pos,2)-input_chrom(index,pos))*fg;
        else
            input_chrom(index,pos)=input_chrom(index,pos)-(input_chrom(index,pos)-limit(pos,1))*fg;
        end   %变异结束
        
        limit1=mean(limit);
        f1=isempty(find(input_chrom(index,:)>limit1(2)));
        f2=isempty(find(input_chrom(index,:)<limit1(1)));
        if f1*f2==0
            flag=0;
        else
            flag=1;
        end
    end
end
new_chrom=input_chrom;