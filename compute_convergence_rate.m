% Script to compute convergence rates and output results as LaTeX table rows.
% Author: Pinzhong ZHENG
% Date: 2024-11-27
%
% Steps:
% 1. Calculate errors and convergence rates with `convergence_rate_func`.
% 2. Format and print each row in LaTeX format using `create_tex_table`.

[~,num_column] = size(convergence_rate);
convergence_rate = convergence_rate_func(vec_U_T, taus);
for i = 1:num_column-1
    create_tex_table(convergence_rate(i,:),'sci')
end


function output = convergence_rate_func(mat, taus)
    % 'mat' contains data, with each column representing a time step.
    % Smaller column index means a larger time step.
    Err = mat(:,2:end) - mat(:,1:end-1); % Compute the error between consecutive columns.
    norm_2_Err = vecnorm(Err, 2); % Compute the 2-norm of each column.
    norm_inf_Err = vecnorm(Err, inf); % Compute the infinity-norm of each column.
    
    % Estimate convergence rate:
    % ratio = error at tau / error at tau/2
    % rate = log2(ratio)
    rate_2 = log2(norm_2_Err(1:end-1) ./ norm_2_Err(2:end)); % Rate using 2-norm.
    rate_inf = log2(norm_inf_Err(1:end-1) ./ norm_inf_Err(2:end)); % Rate using infinity-norm.
    
    time = taus(1:end-1); % Time steps corresponding to the errors.
    output = [time; norm_2_Err; [0 rate_2]; norm_inf_Err; [0 rate_inf]]'; % Combine results into output.
end

function create_tex_table(data_vec, a, n)
    % data_vec: the input data vector
    % a: the conversion mode, either 'str' or 'sci'
    %     'str': convert numbers directly to strings
    %     'sci': use scientific notation
    % n: (optional) number of significant digits for scientific notation
    
    if nargin < 3
        n = 3; % Default to 3 significant digits if not provided
    end
    
    if strcmp(a, 'str')
        % Convert numbers to strings directly
        strs = arrayfun(@num2str, data_vec, 'UniformOutput', false);
    elseif strcmp(a, 'sci')
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
    fprintf(['%s', ' \\\\ \\hline \n'], latexStr);
end





