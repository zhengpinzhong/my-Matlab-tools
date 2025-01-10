function createCustomFigure()
    % createCustomFigure - Creates a figure with specific size, position, and style.

    % Create a new figure
    figure;
    
    % Define the figure size and position [left, bottom, width, height]
    figure_size = [100, 100, 340, 280];
    set(gcf, 'Position', figure_size); % Set the size and position of the current figure

    % Adjust the paper size to match the figure size
    paper_position = get(gcf, 'PaperPosition'); % Get the current PaperPosition of the figure
    set(gcf, 'PaperSize', [paper_position(3) + 0.0001, paper_position(4) + 0.0001]);

    % Set axis properties
    box on; % Turn on the box around the axes
    set(gca, 'LineWidth', 0.5); % Set the line width of the axes
end