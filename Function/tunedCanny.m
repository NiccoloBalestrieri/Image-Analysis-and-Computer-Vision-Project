% Perform Canny edge detection with automatic/adaptive thresholds and fine-tuning.

function edgeImage = tunedCanny(adapt_histeq)
    % Canny edge detection with automatic thresholds
    [~, threshOut] = edge(adapt_histeq, 'Canny');
    initialThresholdMultiplier = 1.0;

    % Lists of fine-tuning values to explore
    fineTuningValues1 = [0.5, 0.9, 1.5];%best: 0.9
    fineTuningValues2 = [1.8, 2.6, 3.3];%best: 3.3

    % Iterate through fine-tuning values
    %for i = 1:length(fineTuningValues1)
    %    for j = 1:length(fineTuningValues2)
    %        % Calculate thresholdMultiplier based on current fine-tuning values
    %        thresholdMultiplier1 = initialThresholdMultiplier * fineTuningValues1(i);
    %        thresholdMultiplier2 = initialThresholdMultiplier * fineTuningValues2(j);

            % Adjust thresholds based on automatic results and fine-tuning
     %       lowThreshold = threshOut(1) * thresholdMultiplier1;
     %       highThreshold = threshOut(2) * thresholdMultiplier2;

     %       % Apply Canny edge detection with adjusted thresholds
     %       edgeImage = edge(adapt_histeq, 'Canny', [lowThreshold, highThreshold], 4.5);

            % Display the current result in a new figure
      %      figure;
       %     imshow(edgeImage);
       %     title(['Tuning 1 = ' num2str(fineTuningValues1(i)) ', Tuning 2 = ' num2str(fineTuningValues2(j))]);
       % end
    %end

    % Select desired multipliers after fine-tuning
    selectedMultiplier1 = 0.9;
    selectedMultiplier2 = 3.3;

    % Calculate thresholds based on selected multipliers
    lowThreshold = threshOut(1) * selectedMultiplier1;
    highThreshold = threshOut(2) * selectedMultiplier2;

    % Apply Canny edge detection with adjusted thresholds
    edgeImage = edge(adapt_histeq, 'Canny', [lowThreshold, highThreshold], 4.5);

    % Display the resulting image in a new figure
    figure;
    imshow(edgeImage);
    title(['Tuning 1 = ' num2str(selectedMultiplier1) ', Tuning 2 = ' num2str(selectedMultiplier2)]);
end
