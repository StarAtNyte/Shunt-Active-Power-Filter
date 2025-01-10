# Neural Network-Based Shunt Active Power Filter (SAPF)

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

## Setup Instructions
1. Set simulation parameters in the model.
2. Configure load parameters for testing.
3. Run the simulation.
4. Analyze results using the provided scripts.

## Key Parameters
- **Switching Frequency:** 10 kHz
- **DC Link Voltage:** 120 V
- **Filter Inductance:** 2 mH
- **System Frequency:** 60 Hz
- **Sampling Time:** 50 μs

## Performance Comparison

### Without SAPF
- **Description**: System operates without any active power filter.
- **THD**: ~25%  
- **Observations**: High harmonic distortion in the system.

### With SAPF (PI Controlled)
- **Description**: SAPF implemented with a conventional PI controller.
- **THD**: ~8%  
- **Observations**: Significant reduction in harmonics but limited adaptability to dynamic load changes.

### Optimization of PI Controller
- **Description**: Tuned PI controller to optimize performance.
- **THD**: ~6%  
- **Observations**: Improved performance with reduced distortion, but still limited by PI controller's inherent drawbacks.

### Replacement of PI Controller with ANN
- **Description**: SAPF implemented with an Artificial Neural Network (ANN) replacing the PI controller.
- **THD**: ~3%  
- **Observations**: Best performance observed with ANN, offering superior adaptability to dynamic loads and minimal distortion.

### With SAPF (ANN-Based)
- **Description**: Fully optimized system with ANN-based SAPF.
- **THD**: ~3%  
- **Observations**: Highly efficient harmonic compensation and robust response to load variations.

## Results Analysis
The system performance can be evaluated through:
- **THD Measurements**: Assess harmonic distortion levels under different scenarios.
- **DC Link Voltage Stability**: Verify voltage consistency under varying loads.
- **Dynamic Response to Load Changes**: Observe system adaptability.
- **Power Factor Improvement**: Analyze improvements in power factor.

---

This project demonstrates the potential of Neural Network-based control in enhancing power quality and mitigating harmonics in three-phase systems. Comparative results showcase the superiority of ANN over conventional PI controllers. Feel free to contribute or raise issues for further improvements.
