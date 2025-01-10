%% Script Overview
% This script loads data, creates a customized plot, and exports the plot as a PDF.
% Author: Pinzhong ZHENG
% Date: 2024-11-27

clc; clear;

%% Input data
% Load test data from a .mat file. Ensure 'data4test1.mat' exists in the current directory.
load('data4test1.mat');

%% Plot configuration
% Set the line width for the plot box
line_width = 1;

% Create a figure and hold the plot for multiple elements
figure;
hold on;

% Add a box around the plot and configure its line width
box on;
set(gca, 'LineWidth', 0.5); % Line width of the box

% Example data
x = 0:0.1:10;              % X-axis data
y = sin(x);                % Y-axis data

% Plot the data using all possible Name-Value pair arguments for customization
plot(x, y, ...
    'Color', [0.2, 0.6, 0.8], ...           % Line color (RGB triplet: light blue)
    'LineStyle', '--', ...                  % Dashed line style
    'LineWidth', 2, ...                     % Line width in points
    'Marker', 'o', ...                      % Circle markers for data points
    'MarkerSize', 8, ...                    % Marker size
    'MarkerEdgeColor', 'r', ...             % Red color for marker edges
    'MarkerFaceColor', 'y', ...             % Yellow fill color for markers
    'DisplayName', 'Sine Wave');            % Legend name for the plot

% Release the hold to stop adding to the current figure
hold off;

% Add a legend to the plot
legend show;

% Configure font properties for the axes
set(gca, 'FontName', 'Arial', 'FontSize', 8); % Set font to Arial and size to 8

% Add title and axis labels
title('Example of plot with all parameters'); % Plot title
xlabel('X-axis');                             % Label for the X-axis
ylabel('Y-axis');                             % Label for the Y-axis

%% Export plot as PDF

file_name = ['test1_' num2str(order) '.pdf'];
save_figure_as_pdf(file_name)


function [] = save_figure_as_pdf(file_name)
    % Function to save the current figure as a PDF file with specified settings.
    % 
    % Parameters:
    %   file_name (string): Name of the output PDF file (including the file extension).
    
    % Define the figure size and position (units are in pixels)
    figure_size = [100, 100, 340, 280]; % [left, bottom, width, height]
    set(gcf, 'Position', figure_size); % Set the size and position of the current figure

    % Adjust the paper size to match the figure size
    paper_position = get(gcf, 'PaperPosition'); % Get the current PaperPosition of the figure
    set(gcf, 'PaperSize', [paper_position(3) + 0.0001, paper_position(4) + 0.0001]);
    % The small offset (0.0001) is added to ensure compatibility with some PDF viewers.
    % The offset can technically be omitted without affecting the result.

    % Save the figure as a PDF file
    print('-dpdf', file_name); % '-dpdf' specifies the output format as PDF
end
