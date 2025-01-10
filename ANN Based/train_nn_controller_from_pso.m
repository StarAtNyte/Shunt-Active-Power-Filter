function [net, tr] = train_nn_controller_from_pso()
    warning('off','all');
    
    % Load PSO training data
    load('final_training_data.mat');
    
    % Extract training data
    Kp_values = training_data.Kp;
    Ki_values = training_data.Ki;
    fitness_values = training_data.fitness;
    
    % Get best performing examples (lowest fitness)
    [sorted_fitness, sort_idx] = sort(fitness_values);
    
    % Use top 70% of examples
    n_examples = floor(0.7 * length(sort_idx));
    best_idx = sort_idx(1:n_examples);
    
    % Run simulation with best parameters from PSO
    assignin('base', 'Kp', global_best_position(1)); % 0.8726
    assignin('base', 'Ki', global_best_position(2)); % 0.2854
    sim('ANN_based_PI_Controlled_SAPF_pq_theory');
    
    % Get error signal from simulation
    Vdc_ref = 120;
    error_signal = Vdc_ref - Vdc.Data;
    error_delta = diff(error_signal);
    error_delta = [0; error_delta];
    
    % Prepare training inputs
    inputs = [error_signal, error_delta]';
    
    % Calculate desired control outputs
    control_outputs = zeros(length(error_signal), 1);
    for i = 1:length(best_idx)
        idx = best_idx(i);
        Kp = Kp_values(idx);
        Ki = Ki_values(idx);
        control_outputs = control_outputs + ...
            (Kp * error_signal + Ki * cumsum(error_signal)) / length(best_idx);
    end
    
    % Normalize data
    [inputs_norm, input_ps] = mapminmax(inputs, -1, 1);
    [outputs_norm, output_ps] = mapminmax(control_outputs', -1, 1);
    
    % Create and configure network
    net = feedforwardnet([15]); % Single hidden layer with 15 neurons
    
    % Configure training function and performance metric
    net.trainFcn = 'trainbr';
    net.performFcn = 'mse';
    
    % Configure transfer functions
    net.layers{1}.transferFcn = 'tansig';  % Hidden layer
    net.layers{2}.transferFcn = 'purelin'; % Output layer
    
    % Training parameters
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 1e-6;
    net.trainParam.min_grad = 1e-7;
    
    % Train network
    [net, tr] = train(net, inputs_norm, outputs_norm);
    
    % Extract trained parameters
    W1 = net.IW{1};  % Input to hidden layer weights
    b1 = net.b{1};   % Hidden layer biases
    W2 = net.LW{2,1}; % Hidden to output layer weights
    b2 = net.b{2};    % Output layer bias
    
    % Save parameters
    save('trained_nn_controller_pso.mat', 'W1', 'b1', 'W2', 'b2', 'input_ps', 'output_ps');
    
    % Plot training performance
    figure;
    plotperform(tr);
    title('Neural Network Training Performance');
end