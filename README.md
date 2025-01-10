![PI_Controlled_SAPF_pq_theory_page-0005](https://github.com/user-attachments/assets/c727a43f-cb93-4eff-91dc-007dbfe23400)![PI_Controlled_SAPF_pq_theory_page-0001](https://github.com/user-attachments/assets/d35c3e27-caed-490c-9452-61cf78d02ea2)# Neural Network-Based Shunt Active Power Filter (SAPF)

## Overview
This project implements a **Shunt Active Power Filter (SAPF)** using Neural Networks as a replacement for the conventional PI controller. The system is designed to mitigate harmonics in three-phase power systems by leveraging instantaneous power theory (p-q theory) combined with intelligent control.

## Features
- Neural Network controller replacing traditional PI controller
- Real-time harmonic compensation
- Dynamic load testing capability
- Total Harmonic Distortion (THD) measurement and analysis
- Based on instantaneous p-q theory
- Three-phase system implementation

## System Components

### Power Circuit
- Three-phase source
- Voltage and current measurement blocks
- VSI (Universal Bridge)
- DC-link capacitor
- Coupling inductor
- Non-linear load

### Control System
- Neural Network Controller
- PQ Theory Implementation
- Reference Current Generation
- PWM Generator
- DC Voltage Control

## Requirements
- **MATLAB/Simulink** (R2020b or newer)
- **Simulink Power Systems** toolbox
- **Deep Learning Toolbox**
- **Simscape Electrical**

![Uploading PI_Controlled_SAPF_pq_theory_page-0001.jpg…]()
![PI_Controlled_SAPF_pq_theory_page-0002](https://github.com/user-attachments/assets/f8879c41-de1f-4024-83cf-4572e7dfb0f5)
![PI_Controlled_SAPF_pq_theory_page-0003](https://github.com/user-attachments/assets/2da66e53-f586-4428-8071-ac46b0d41fda)
![PI_Controlled_SAPF_pq_theory_page-0004](https://github.com/user-attachments/assets/3ced4b80-35aa-4a1b-8de3-d329fd944fb4)
![PI_Controlled_SAPF_pq_theory_page-0005](https://github.com/user-attachments/assets/2c756f65-161a-43a7-a518-afef7ce8207b)
![PI_Controlled_SAPF_pq_theory_page-0006](https://github.com/user-attachments/assets/693051d5-7a54-4233-a34a-0cedab7acecf)
![PI_Controlled_SAPF_pq_theory_page-0012](https://github.com/user-attachments/assets/21259b82-a23e-48db-aa6b-515751e0c9a0)

## Performance Comparison

### Without SAPF
- **Description**: System operates without any active power filter.
- **Observations**: High harmonic distortion in the system.

### With SAPF (PI Controlled)
- **Description**: SAPF implemented with a conventional PI controller.
![start0 2cycle100](https://github.com/user-attachments/assets/8451e129-4a92-4eff-86f8-00f5045c7e43)
- **Observations**: Significant reduction in harmonics but limited adaptability to dynamic load changes.

### Optimization of PI Controller
- **Description**: Tuned PI controller to optimize performance.
![0 3100cycles](https://github.com/user-attachments/assets/05d40d03-0514-498a-8cac-a4194d376900)
- **Observations**: Improved performance with reduced distortion, but still limited by PI controller's inherent drawbacks.

### Replacement of PI Controller with ANN
- **Description**: SAPF implemented with an Artificial Neural Network (ANN) replacing the PI controller.
![0 3100cycle](https://github.com/user-attachments/assets/6fa53f48-21bc-4e82-92e4-b485cefb7220)

- **Observations**: Best performance observed with ANN, offering superior adaptability to dynamic loads and minimal distortion.

### PI Controller in cascade with ANN
![0 3_100cycles](https://github.com/user-attachments/assets/f4605d37-a0a6-40a9-91eb-28c33a3ded0a)


## Results Analysis
The system performance can be evaluated through:
- **THD Measurements**: Assess harmonic distortion levels under different scenarios.
- **DC Link Voltage Stability**: Verify voltage consistency under varying loads.
- **Dynamic Response to Load Changes**: Observe system adaptability.
- **Power Factor Improvement**: Analyze improvements in power factor.

---

This project demonstrates the potential of Neural Network-based control in enhancing power quality and mitigating harmonics in three-phase systems. Comparative results showcase the superiority of ANN over conventional PI controllers. Feel free to contribute or raise issues for further improvements.
