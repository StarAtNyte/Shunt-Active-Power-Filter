warning('off','all');
[optimized_Kp, optimized_Ki] = optimize_pi_controller();

% Display the optimized parameters
fprintf('Optimized Kp: %.4f\n', optimized_Kp);
fprintf('Optimized Ki: %.4f\n', optimized_Ki);