load ('100m_(0).mat');
RealECG = val/200;
Fs = 360; % Sampling frequency of recorded signal 
L = length(RealECG); % Signal Length
TimeInterval = 10; % 10 second fragments
T = linspace(0,TimeInterval,L); % time axis
N = 2;
fc = 1; % Hz

 
subplot(2,1,1);
plot(T, RealECG); 
grid on;
title('Raw ECG Signal'); 
xlabel('Time (sec)'); 
ylabel('Unfiltred Value (mV)');
%axis([0, 2.5, ylim]);

[B,A] = butter(N, 2*fc/Fs, 'high');
rec = filtfilt(B,A,RealECG);
subplot(2,1,2);
plot(T, rec);
grid on;
title('ECG With Baseline Correction'); 
xlabel('Time (sec)'); 
ylabel('Voltage (mV)');
%axis([0,2.5,ylim])


% To find heartrate:
[pks, locs] = findpeaks(rec, "MinPeakHeight", 1);
peakInterval = diff(locs);
peakTime(1: numel(locs)) = T(locs(1:numel(locs)));
HeartRate = (numel(locs)*60)/(peakTime(numel(locs))-peakTime(1));
op = ['Heart Rate = ', num2str(HeartRate), ' beats/min'];
disp(op);
