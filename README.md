# A Novel Estimation Method for Dual Active Bridge Converter Based on Intelligent Algorithm
![MATLAB 2021b](https://img.shields.io/badge/MATLAB-2021b-blue.svg?style=plastic)
![PLECS 4.5.6](https://img.shields.io/badge/PLECS-4.5.6-green.svg?style=plastic)
[![Build status](https://ci.appveyor.com/api/projects/status/8msiklxfbhlnsmxp/branch/master?svg=true)](https://ci.appveyor.com/project/TadasBaltrusaitis/openface/branch/master)
![License CC BY-NC-SA](https://img.shields.io/badge/license-CC_BY--NC--SA--green.svg?style=plastic)

This is a GitHub repository for the project "[A Novel Estimation Method for Dual Active Bridge Converter Based on Intelligent Algorithm](https://)".

Parameter estimation with various nonidealities and uncertainties in a practical circuit is a key but challenging issue in the applications of dual active bridge (DAB) converters for health diagnosis and preventive maintenance. However, most of the existing parameter extraction and identification methods for DAB converters still require a large number of experimental data and expensive measurement costs, while the established estimation model usually lacks generalization. In addition, most of the DAB converter models in previous studies adopt ideal models and ignore circuit nonidealities, which will seriously affect the accuracy and reliability of the models.

Intelligent methods can effectively mine the rule of data without considering the complex mapping relationship between DAB models and estimated parameters. Consequently, these methods are expected to become the mainstream approach for parameter estimation. This paper proposes a light, flexible, and yet reliable multiparametric estimation algorithm for isolated DAB converters. This approach combines the back-propagation neural network (BPNN)  and the steady-state average model (AVM) to simultaneously predict the circuit and control parameters of a DAB converter. As a salient role of AI, BPNN possesses tremendous advantages due to its good performance in nonlinear regression, prediction, classification, and data structure exploration. To further optimize BPNN, a genetic algorithm (GA) is employed. The GA-BP-based model was trained and testified by the data from the mathematical model of DAB converter steady-state AVM, so it did not increase any computational. Furthermore, this parameter estimation method reduces the need to build experimental platforms and synchronize measurements. It should be emphasized that DAB modeling takes into account circuit nonidealities, including dead time in the bridges, magnetizing inductance, equivalent series resistances (ESR),  thereby enhancing the accuracy of the model. 

Illustrative results demonstrate that the combined BPNN+GA+AVM model outperforms other existing proposals and is capable of achieving accurate results for both the estimation and prediction of parasitic and control parameters.

## Requirements
- MATLAB == 2021b
- PLECS == 4.5.6
- Simulink
- 
## Reduced-order AVM with circuit nonidealities
For the DAB used as a DC transformer, the input and output voltages are nearly constant [5], so single-phase-shift (SPS) control is the most widely used one on account of its simplicity and fast dynamic response [6]. Therefore, SPS control is used in this article. The topology of the DAB converter is illustrated in Fig. 1.
![image](https://github.com/SQY2021/Estimation/assets/81226844/6570a070-9dac-4247-bfd7-11d027753922)
Fig. 1 Topology of the DAB converter and SPS control system.

## GA-BPNN



