<a name="top"></a>
# Parameter Estimation of DAB Converter Using Intelligent Algorithms and Steady-State Modeling Considering Nonidealities
![MATLAB 2021b](https://img.shields.io/badge/MATLAB-2021b-blue.svg?style=plastic)
![PLECS 4.5.6](https://img.shields.io/badge/PLECS-4.5.6-green.svg?style=plastic)
[![Build status](https://ci.appveyor.com/api/projects/status/8msiklxfbhlnsmxp/branch/master?svg=true)](https://ci.appveyor.com/project/TadasBaltrusaitis/openface/branch/master)
![License CC BY-NC-SA](https://img.shields.io/badge/license-CC_BY--NC--SA--green.svg?style=plastic)

This is a GitHub repository for the project "[Parameter Estimation of DAB Converter Using Intelligent Algorithms and Steady-State Modeling Considering Nonidealities]([https://doi.org/10.1109/TIE.2024.3390731])". [DOI: 10.1109/TIE.2024.3390731](https://doi.org/10.1109/TIE.2024.3390731).Published in: **[IEEE Transactions on Industrial Electronics (IEEE TIE)]([https://](https://ieeexplore.ieee.org/xpl/RecentIssue.jsp?punumber=19))**. 

Parameter estimation with various nonidealities and uncertainties in a practical circuit is a key but challenging issue in the applications of dual active bridge (DAB) converters for health diagnosis and preventive maintenance. However, most of the existing parameter extraction and identification methods for DAB converters still require a large number of experimental data and expensive measurement costs, while the established estimation model usually lacks generalization. In addition, most of the DAB converter models in previous studies adopt ideal models and ignore circuit nonidealities, which will seriously affect the accuracy and reliability of the models.

[Intelligent methods](https://ieeexplore.ieee.org/abstract/document/9584587) can effectively mine the rule of data without considering the complex mapping relationship between DAB models and estimated parameters. Consequently, these methods are expected to become the mainstream approach for parameter estimation. ***`The primary motivation of this work is to develop a novel parameter estimation method that will enable customers to better understand, optimize, predict, and monitor the operating condition and performance of the target converter. This method is a light, time-saving and low-cost parameter estimation method. The training data comes from an accurate mathematical model without modifying and intruding on the control and the converter to be monitored`*** . This approach combines the [back-propagation neural network (BPNN)](https://github.com/SQY2021/Estimation/tree/main/BPNN) and the steady-state [averaged-value model (AVM)](https://github.com/SQY2021/Estimation/tree/main/The%20proposed%20AVM/MATLAB-model-simulink%20and%20PLECS-model-simulink) to simultaneously predict the circuit and control parameters of a DAB converter. As a salient role of AI, BPNN possesses tremendous advantages due to its good performance in nonlinear regression, prediction, classification, and data structure exploration. To further optimize BPNN, a genetic algorithm (GA) is employed. The [GA-BP](https://github.com/SQY2021/Estimation/tree/main/GA-BPNN)-based model was trained and testified by the data from the mathematical model of DAB converter steady-state AVM, so it did not increase any computational. Furthermore, this parameter estimation method reduces the need to build experimental platforms and synchronize measurements. It should be emphasized that **DAB modeling ([AVM](https://github.com/SQY2021/Estimation/tree/main/The%20proposed%20AVM/MATLAB-model-simulink%20and%20PLECS-model-simulink)) takes into account circuit nonidealities, including dead time in the bridges, magnetizing inductance, equivalent series resistances (ESR),  thereby enhancing the accuracy of the model**. 

Illustrative results demonstrate that the combined **[AVM+BPNN+GA](https://github.com/SQY2021/Estimation/tree/main)** model outperforms other existing proposals and is capable of achieving accurate results for both the estimation and prediction of parasitic and control parameters.

[^back to top](#top)

## Requirements
- MATLAB == 2021b
- PLECS == 4.5.6
- Simulink

## Reduced-order AVM with circuit nonidealities

Ignoring nonideal factors will lead to the misjudgment of the ZVS range, increasing the switching loss, and affecting the electromagnetic compatibility performance. DAB high-frequency voltage also produces distortion due to the influence of nonideal factors, which affects the power transmission characteristics. Due to the influence of nonideal factors, DAB will lose the ZVS operation at light load, and the loss at the light load will be more than half of that at rated power, which decreases the efficiency in light load greatly.

### Topology of a general DAB converter
For the DAB used as a DC transformer, the input and output voltages are nearly constant, so single-phase-shift (SPS) control is the most widely used one on account of its simplicity and fast dynamic response. Therefore, SPS control is used in this article. The topology of the DAB converter is illustrated in Fig. 1.

![image](https://github.com/SQY2021/Estimation/assets/81226844/063467cc-05fa-4efc-b614-55eb5c56ffc7)

Fig. 1 Topology of the DAB converter and SPS control system.

The amount of power transferred from the leading bridge to the lagging bridge is given as follow :

![image](https://github.com/SQY2021/Estimation/assets/81226844/22f055fd-d51b-4f38-81a0-0cd3e9273f91)


![image](https://github.com/SQY2021/Estimation/assets/81226844/f8958f3c-3b88-4905-91b6-36a53a9cd644)


[^back to top](#top)

### Proposed AVM
The formulation of conventional modeling (both time and frequency domain) is based on the following assumptions—the circuit does not possess nonidealities and parasitics, such as magnetizing inductance, equivalent series resistances (ESR), and dead times. Compared with traditional modeling of the DAB converter, this paper proposes a reduced-order averaged-value model (AVM) that considers parasitic parameters and the effects of dead-time periods.
- **(1) Effects of dead-time periods**
  
The influence of dead time on the leakage inductance current is ignored in traditional analysis, and the leakage inductance current can be affected by the dead time, especially when the duty ratio is close to 0.5 and the phase shift angle is small. 

[[1]](https://ieeexplore.ieee.org/abstract/document/6548099) presents a comprehensive theoretical analysis of dead-time effect in the DAB converter. In [1], there are three sub-states of the dead-time effect (boost state, buck state and matching state), and each state has multiple modes. Taking the buck state of the DAB converter as an example, there are 6 modes in total (Fig. 2). We selected the two most typical modes as examples for modeling, and considered parasitism during the modeling process.
![image](https://github.com/SQY2021/Estimation/assets/81226844/4749d6ef-6345-4c9f-b730-b91f512bba37)

Fig. 2 Operation waveforms of the IBDC with dead-time effect in buck state. (a) Mode 1. (b) Mode 2. (c) Mode 3. (d) Mode 4. (e) Mode 5. (f) Mode 6.


[^back to top](#top)

- **(2) Effects of Magnetizing Inductance and Core Losses**

While considering the impact of dead-time, we further consider parasitics, e.g., magnetizing inductance and core losses. Fig. 3 depicts a general equivalent detailed model of DAB
converter considered in this paper.
      ![image](https://github.com/SQY2021/Estimation/assets/81226844/7622f839-e70c-4ff4-a2fc-068dfdd518e1)

Fig. 3  Detailed steady-state equivalent circuit of the DAB.

- **(3) Implementation of the proposed AVM based on MATLAB**



    ![image](https://github.com/SQY2021/Estimation/assets/81226844/e529edb3-463d-4e00-a209-b88b6ea9aad3)

    Fig. 4 Simulation example of partial equations of the mathematical model of the proposed AVM

[^back to top](#top)

- **(4) Procedure to run this code**

    - Click on code and download zip

    - Click on ([**The proposed AVM**](https://github.com/SQY2021/Estimation/tree/main/The%20proposed%20AVM/MATLAB-model-simulink%20and%20PLECS-model-simulink))
 
    - Click on ([**MATLAB-model-simulink**](https://github.com/SQY2021/Estimation/tree/main/The%20proposed%20AVM/MATLAB-model-simulink%20and%20PLECS-model-simulink/MATLAB-model-simulink))

    - [MATLAB implementation of AVM considering high-frequency transformer parameters and parasitics](https://github.com/SQY2021/Estimation/tree/main/The%20proposed%20AVM/MATLAB-model-simulink%20and%20PLECS-model-simulink/MATLAB-model-simulink)
      
     ```bash
        1 RUN TF.m; Parameter_preparation.m
        2 RUN RAVM.slx
     ```
 
     - **Automatic PI tuner**
       
        ![image](https://github.com/SQY2021/Estimation/assets/81226844/a13205aa-f825-4f5b-abc2-3ac44ffb3342)

        Fig. 5 PI tuner

        ![GIF 2023-9-17 23-40-05](https://github.com/SQY2021/Estimation/assets/81226844/a49b9168-51cb-4fda-acf3-d4e1740af321)

        Fig. 6 The process of automatically tuning PID parameters

     - [PLECS implementation of AVM considering circuit nonidealities](https://github.com/SQY2021/Estimation/tree/main/The%20proposed%20AVM/MATLAB-model-simulink%20and%20PLECS-model-simulink/PLECS-model-simulink);

       ![image](https://github.com/SQY2021/Estimation/assets/81226844/b34dd63d-0bac-4393-b714-8bf8d0dde3fc)

       Fig. 7 Detailed steady-state equivalent circuit of the DAB.

 
     - [Numerical methods for solving steady state solutions](https://github.com/SQY2021/Estimation/tree/main/The%20proposed%20AVM/MATLAB-model-simulink%20and%20PLECS-model-simulink/PLECS-model-simulink)；

[^back to top](#top)

## Parameter estimation based on intelligent algorithms

Nowadays, [artificial intelligence (AI)](https://) powers many aspects of industrial applications. It has been successfully applied for power electronic systems for specific targets, such as designing time reduction, weighting factors design, performance prediction, and so on. In terms of data prediction, [BP neural network](https://) has the advantages of high speed, good effect, and high precision. It has been widely used for structure optimization and result prediction. 

Although BP neural networks have strong nonlinear mapping capacity and limited fault tolerance, the BP neural network algorithm has obvious limitations in practical engineering applications. Because the global error of the BP neural
network is a multidimensional nonlinear function with an Stype function as the argument, there are multiple local minima on the error surface. Thus, the BP algorithm can easily fall into the local optimum.

[Genetic algorithm (GA)](https://) is a highly parallel adaptive detection algorithm that mimics the theory of biological evolution in nature [27]. It is optimized to distinguish information about individual genetic changes, retaining genetic traits that are well adapted to the environment, and eliminating those that are poorly adapted. Therefore, the current problem is solved by using GA to optimize the weights and thresholds of the BP network. The combined network has an extremely strong ability to solve practical problems. 

GA optimized [BPNNs](https://) have been developed based on biological intelligence techniques. Owing to their advantages of learning, generalization, fast computation, and easy implementation, [GA-BP neural networks](https://) have been widely used for monitoring, control, parameter estimation.

A non-invasive method based on intelligent algorithms for estimating circuit and control parameters of a DAB converter has been proposed in this paper. The proposed parameter estimation method is shown in Fig. 6.

![image](https://github.com/SQY2021/Estimation/assets/81226844/8dfa5b9f-7411-41db-839c-58a50f607e5e)

Fig. 8 Overall diagram of the proposed parameter estimation method.

[^back to top](#top)

- **[(1) BPNN](https://github.com/SQY2021/Estimation/tree/main/BPNN)**

```bash
       RUN main.mlx        
```  

- **[(2) GA-BPNN](https://github.com/SQY2021/Estimation/tree/main/GA-BPNN)**

```bash
       RUN main.mlx        
```  

<img src="https://github.com/SQY2021/Estimation/assets/81226844/4fdbe8c4-7d01-426e-ac43-9ff800670e69" width="600" height="480">

Fig. 9 Training process of GA-BPNN

[^back to top](#top)

# Baselines

In this article, the following models are also utilized for comparison.

- [x] [GA-BPNN](https://github.com/SQY2021/Estimation/tree/main/GA-BPNN)
- [x] [BPNN](https://github.com/SQY2021/Estimation/tree/main/BPNN)
- [x] [FFRLS](https://ieeexplore.ieee.org/abstract/document/9656564)

[^back to top](#top)

# References
We appreciate the following github repositories/[IEEE DataPort(TM)](https://) a lot for their valuable code base or datasets:

- [Plecs Simulation Files Dab Control Methods](https://doi.org/10.21227/gz8v-2s83)

- [https://ieeexplore.ieee.org/abstract/document/7456330](https://ieeexplore.ieee.org/abstract/document/7456330)

- [GA-BPNN](https://mp.weixin.qq.com/s/RLSxJaPI-AzbTCgryhd6mQ)

# Contact
If you have any questions, feel free to contact Qianyi Shang<img src="https://github.com/SQY2021/Estimation/assets/81226844/128cb8d0-db61-46a0-9488-e6f16fa0816c" width="18" height="18">(https://orcid.org/0000-0002-4568-8895) through Email ([21000504@nue.eud.cn](21000504@nue.eud.cn)) or Github issues. Pull requests are highly welcomed!


[^back to top](#top)







