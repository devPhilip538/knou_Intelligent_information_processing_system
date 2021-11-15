clc; clear; % 초기화
load HW5Data_1 data; % HW5Data_1 data 로드
scatter(data(:,1), data(:,2), 3, [0 0 1], '*') % scatter 를 이용하여 data 산점도 표시(파란색 *)
grid on;