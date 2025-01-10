Neural Network-Based Shunt Active Power Filter (SAPF)
Overview
This project implements a Shunt Active Power Filter (SAPF) using Neural Networks as a replacement for the conventional PI controller. The system is designed to mitigate harmonics in three-phase power systems by using instantaneous power theory (p-q theory) combined with intelligent control.
Features

Neural Network controller replacing traditional PI controller
Real-time harmonic compensation
Dynamic load testing capability
THD measurement and analysis
Based on instantaneous p-q theory
Three-phase system implementation

System Components

Power Circuit

Three-phase source
Voltage and current measurement blocks
VSI (Universal Bridge)
DC-link capacitor
Coupling inductor
Non-linear load


Control System

Neural Network Controller
PQ Theory Implementation
Reference Current Generation
PWM Generator
DC Voltage Control



Requirements

MATLAB/Simulink (R2020b or newer)
Simulink Power Systems toolbox
Deep Learning Toolbox
Simscape Electrical

Setup Instructions




Set simulation parameters in the model
Configure load parameters for testing
Run simulation
Analyze results using provided scripts

Key Parameters

Switching Frequency: 10kHz
DC Link Voltage: 120V
Filter Inductance: 2mH
System Frequency: 60Hz
Sampling Time: 50μs

Results Analysis
The system performance can be evaluated through:

THD measurements
DC link voltage stability
Dynamic response to load changes
Power factor improvement
