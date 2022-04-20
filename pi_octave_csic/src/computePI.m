%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% computePI.m
%
% Given a motion capture file and anthropomorphic data, computes PI metrics
% Stride time, step time, step length
%
% Copyright Tecnalia 2019
% Anthony Remazeilles
% License Beerware
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = computePI(csv_file, anthro_file, result_dir)

    %csv_file = "../sample_data/pi_csic/data/subject10/subject_10_trial_01.csv";
    %anthro_file = "../sample_data/pi_csic/data/subject10/subject_10_anthropometry.yaml";

    disp(["Input parameters: ", csv_file, " ", anthro_file, " ", result_dir])
    isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;

    if isOctave
        disp('Using Octave')
        pkg load signal
        pkg load mapping
        pkg load statistics
    else
        disp('Using Matlab')
    end

    % get the scv data

    angles = csv2cell(csv_file);
    header = angles(1, :);
    angles = cell2mat(angles(2:end, :));
    angles(1, :)

    display("segment the trial")
    segmentData = segment_gait(angles, header);

    display("Calculate the event")

    eventData = calculate_events(segmentData);

    display("Compute SpatioTemporal information")

    % First, estimate the frequency
    delta_t = diff(angles(:, 1));
    frequency = 1.0/mean(delta_t);
    % read anthropomorphic data
    anthropomorphic_data = read_simple_yaml(anthro_file);

    sp_data = calculate_spatiotemporal(anthropomorphic_data, frequency, angles, header, eventData);

    display("Store results")

    [filepath, name, ext] = fileparts(csv_file);

    filename = strcat(result_dir, "/", "stride_time_right", ".yaml")
    store_vector(filename, sp_data.strideTime.rightleg.data);

    filename = strcat(result_dir, "/", "stride_time_left", ".yaml")
    store_vector(filename, sp_data.strideTime.leftleg.data);

    filename = strcat(result_dir, "/", "step_time_right", ".yaml")
    store_vector(filename, sp_data.stepTime.rightleg.data);

    filename = strcat(result_dir, "/", "step_time_left", ".yaml")
    store_vector(filename, sp_data.stepTime.leftleg.data);

    filename = strcat(result_dir, "/", "step_length_right", ".yaml")
    store_vector(filename, sp_data.stepLength.rightleg.data);

    filename = strcat(result_dir, "/", "step_length_left", ".yaml")
    store_vector(filename, sp_data.stepLength.leftleg.data);
end

