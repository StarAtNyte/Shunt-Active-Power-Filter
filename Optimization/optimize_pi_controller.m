function [optimized_Kp, optimized_Ki] = optimize_pi_controller()
    n_particles = 35;  % Number of particles
    max_iter = 30;     % Number of iterations
    w = 0.7;          % Inertia weight
    c1 = 1.2;         % Cognitive weight
    c2 = 1.7;         % Social weight

    % Define bounds for Kp and Ki
    Kp_min = 0; Kp_max = 5;
    Ki_min = 0; Ki_max = 3;

    % Initialize arrays
    positions = zeros(n_particles, 2);
    velocities = zeros(n_particles, 2);
    personal_best_positions = zeros(n_particles, 2);
    personal_best_fitness = inf(n_particles, 1);

    % Random initialization
    positions(:, 1) = Kp_min + (Kp_max - Kp_min) * rand(n_particles, 1);
    positions(:, 2) = Ki_min + (Ki_max - Ki_min) * rand(n_particles, 1);
    velocities(:, 1) = -0.5 + rand(n_particles, 1);
    velocities(:, 2) = -0.5 + rand(n_particles, 1);

    global_best_position = positions(1, :);
    global_best_fitness = inf;

    % Preallocate training data structure
    total_iterations = n_particles * max_iter;
    training_data = struct();
    training_data.Kp = zeros(total_iterations, 1);
    training_data.Ki = zeros(total_iterations, 1);
    training_data.fitness = zeros(total_iterations, 1);
    training_data.iteration = zeros(total_iterations, 1);
    training_data.particle = zeros(total_iterations, 1);

    % Main PSO loop
    data_index = 1;
    for iter = 1:max_iter
        for i = 1:n_particles
            % Update controller parameters
            Kp_opt = positions(i, 1);
            Ki_opt = positions(i, 2);
            assignin('base', 'Kp', Kp_opt);
            assignin('base', 'Ki', Ki_opt);

            % Run simulation
            sim('PSO_tuned_PI_Controlled_SAPF_pq_theory');

            % Extract Vdc data
            Vdc = Vdc.Data;
            Vdc_ref = 120;

            % Take last 1.5 million points if available
            %if length(Vdc) > 1500000
            %    Vdc = Vdc(end-1499999:end);
            %end

            % Calculate fitness
            fitness = calculate_fitness(Vdc, Vdc_ref);

            % Store training data
            training_data.Kp(data_index) = Kp_opt;
            training_data.Ki(data_index) = Ki_opt;
            training_data.fitness(data_index) = fitness;
            training_data.iteration(data_index) = iter;
            training_data.particle(data_index) = i;
            
            % Update personal best
            if fitness < personal_best_fitness(i)
                personal_best_positions(i, :) = positions(i, :);
                personal_best_fitness(i) = fitness;

                % Update global best
                if fitness < global_best_fitness
                    global_best_fitness = fitness;
                    global_best_position = positions(i, :);
                end
            end
            
            data_index = data_index + 1;
        end

        % Update velocities and positions
        for i = 1:n_particles
            r1 = rand();
            r2 = rand();
            velocities(i, :) = w * velocities(i, :) + ...
                               c1 * r1 * (personal_best_positions(i, :) - positions(i, :)) + ...
                               c2 * r2 * (global_best_position - positions(i, :));

            % Clamp velocity
            v_max = 0.2 * [Kp_max - Kp_min, Ki_max - Ki_min];
            velocities(i, :) = max(min(velocities(i, :), v_max), -v_max);

            % Update position with bounds
            positions(i, :) = positions(i, :) + velocities(i, :);
            positions(i, 1) = max(min(positions(i, 1), Kp_max), Kp_min);
            positions(i, 2) = max(min(positions(i, 2), Ki_max), Ki_min);
        end

        % Display progress
        fprintf('Iteration %d: Kp = %.4f, Ki = %.4f, Fitness = %.4f\n', ...
                iter, global_best_position(1), global_best_position(2), global_best_fitness);
        
        % Save intermediate results every 5 iterations
        if mod(iter, 5) == 0
            save(sprintf('training_data_iter_%d.mat', iter), 'training_data', ...
                 'global_best_position', 'global_best_fitness');
        end
    end

    % Save final results
    save('final_training_data.mat', 'training_data', 'global_best_position', ...
         'global_best_fitness', 'positions', 'velocities', 'personal_best_positions');

    optimized_Kp = global_best_position(1);
    optimized_Ki = global_best_position(2);
end