function output = nn_controller_pso(error, delta_error)
    % Use coder configuration for code generation
    coder.inline('always');
    
    % Define network architecture parameters
    persistent W1 b1 W2 b2 input_ps output_ps
    
    % Load weights and parameters only once
    if isempty(W1)
        params = load('trained_nn_controller_pso.mat', 'W1', 'b1', 'W2', 'b2', 'input_ps', 'output_ps');
        W1 = params.W1;
        b1 = params.b1;
        W2 = params.W2;
        b2 = params.b2;
        input_ps = params.input_ps;
        output_ps = params.output_ps;
    end
    
    % Prepare input
    input = [error; delta_error];
    
    % Manual normalization (replacing mapminmax)
    input_norm = 2 * (input - input_ps.xmin) ./ (input_ps.xmax - input_ps.xmin) - 1;
    
    % Forward propagation
    h1 = tanh(W1 * input_norm + b1);
    output_norm = tanh(W2 * h1 + b2);
    
    % Manual denormalization (replacing mapminmax reverse)
    output = 0.5 * (output_norm + 1) .* (output_ps.ymax - output_ps.ymin) + output_ps.ymin;
    
    % Apply safety limits
    output = min(max(output, -10), 10);
end