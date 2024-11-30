function convergence_rate = compute_and_export_convergence(UU_T, taus, mode, n, output_table)
% Function to calculate errors, convergence rates, and optionally output results as LaTeX table rows.
%
% Author: Pinzhong ZHENG
% Date: 2024-11-28
%
% Inputs:
%   - UU_T: Matrix where columns represent solutions at different timesteps.
%   - taus: Vector of timestep sizes corresponding to columns of UU_T.
%   - mode: Conversion mode for LaTeX table ('str' for direct strings, 'sci' for scientific notation).
%   - n: (Optional) Number of significant digits for scientific notation (default is 3).
%   - output_table: (Optional) Boolean to control whether to output LaTeX table (default is true).
%
% Outputs:
%   - convergence_rate: Matrix containing time, errors, and convergence rates.
%
% Example:
%   convergence_rate = compute_and_export_convergence(UU_T, taus, 'sci', 3, true);

if nargin < 4
    n = 3; % Default to 3 significant digits if not provided
end
if nargin < 5
    output_table = true; % Default to output LaTeX table
end

% Step 1: Compute errors and convergence rates
Err = UU_T(:, 2:end) - UU_T(:, 1:end-1); % Compute error between consecutive columns
norm_2_Err = vecnorm(Err, 2); % Compute 2-norm of errors
norm_inf_Err = vecnorm(Err, inf); % Compute infinity-norm of errors

% Calculate convergence rates
rate_2 = log2(norm_2_Err(1:end-1) ./ norm_2_Err(2:end)); % Rate using 2-norm
rate_inf = log2(norm_inf_Err(1:end-1) ./ norm_inf_Err(2:end)); % Rate using infinity-norm

% Combine results into a matrix
time = taus(1:end-1); % Time steps corresponding to errors
convergence_rate = [time; norm_2_Err; [0, rate_2]; norm_inf_Err; [0, rate_inf]]';

% Step 2: Optionally format and output results as LaTeX table rows
if output_table
    % Print table header
    header = {'Time Step', '2-norm Error', '2-norm Rate', 'Inf-norm Error', 'Inf-norm Rate'};
    fprintf('%s \\\\\\hline\n', strjoin(header, ' & '));

    % Print data rows
    [num_rows, ~] = size(convergence_rate); % Get the number of rows in the matrix
    for i = 1:num_rows
        % Extract row to print
        data_vec = convergence_rate(i, :);

        % Convert data to LaTeX-compatible strings
        if strcmp(mode, 'str')
            % Convert numbers to strings directly
            strs = arrayfun(@num2str, data_vec, 'UniformOutput', false);
        elseif strcmp(mode, 'sci')
            % Convert numbers to scientific notation with n significant digits
            formatStr = sprintf('%%.%de', n);
            strs = arrayfun(@(x) sprintf(formatStr, x), data_vec, 'UniformOutput', false);
        else
            error('Invalid conversion mode. Use ''str'' or ''sci''.');
        end

        % Join strings with '&' for LaTeX table format
        latexStr = strjoin(strs, ' & ');

        % Print the final LaTeX-compatible string
        % ' \\\\ \\hline \n' adds a new row and a horizontal line
        fprintf(['%s', ' \\\\ \\hline\n'], latexStr);
    end
end
end