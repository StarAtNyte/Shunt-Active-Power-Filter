% Fitness function to calculate IAE based on the last 1000 values of Vdc
function fitness = calculate_fitness(Vdc, Vdc_ref)
    time_weights = linspace(1, 2, length(Vdc)); % Increasing weights
    
    % Calculate the absolute error
    error_signal = abs(Vdc - Vdc_ref);
    diff_signal = diff(Vdc);
    oscillation_penalty = sum(abs(diff_signal)) * 0.1;


    % Calculate the Integral of Absolute Error (IAE)
    fitness = trapz(error_signal .* time_weights') + oscillation_penalty;
end
