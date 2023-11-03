function new_chrom=Cross(cross_pro,lenchrom,input_chrom,group_num,limit)
%随机选择两个染色体位置交叉
% cross_pro                   交叉概率
% lenchrom                   染色体的长度，即所有参数的数量
% input_chrom              染色体群,经过选择遗传下来的表现比较好的
% group_num                种群规模
% new_chrom                交叉后的染色体
 for i=1:group_num  %每一轮for循环中，可能会进行一次交叉操作，染色体是随机选择的，交叉位置也是随机选择的，
                  %但该轮for循环中是否进行交叉操作则由交叉概率决定（continue控制）        
    pick=rand(1,2);   % 随机选择两个染色体进行交叉
     while prod(pick)==0       %连乘
         pick=rand(1,2);
     end
    index=ceil(pick.*group_num);  % 交叉概率决定是否进行交叉
    pick=rand;
     while pick==0
         pick=rand;
     end
     if pick>cross_pro
         continue;   % 如果随机生成的概率值大于交叉概率，跳过本次交叉操作
     end
         % 随机选择交叉位
         pick=rand;
         while pick==0
             pick=rand;
         end
         flag=0;
       while flag==0
         pos=ceil(pick*length(lenchrom)); %随机选择进行交叉的位置，即选择第几个变量进行交叉，注意：两个染色体交叉的位置相同
         pick=rand; %交叉开始
         v1=input_chrom(index(1),pos);
         v2=input_chrom(index(2),pos);
         input_chrom(index(1),pos)=pick*v2+(1-pick)*v1;
         input_chrom(index(2),pos)=pick*v1+(1-pick)*v2; %交叉结束
       
       %判断交叉后的两条染色体可不可行  
        limit1=mean(limit);
        f11=isempty(find(input_chrom(index(1),:)>limit1(2)));
        f12=isempty(find(input_chrom(index(1),:)<limit1(1)));
        if f11*f12==0
            flag1=0;
        else
            flag1=1;
        end
        
        f21=isempty(find(input_chrom(index(2),:)>limit1(2)));
        f22=isempty(find(input_chrom(index(2),:)<limit1(1)));
        if f21*f22==0
            flag2=0;
        else
            flag2=1;
        end
         
         if   flag1*flag2==0
             flag=0;
         else
             flag=1;
         end    %如果两个染色体不是都可行，则重新交叉
        end    
 end
 new_chrom=input_chrom;
end