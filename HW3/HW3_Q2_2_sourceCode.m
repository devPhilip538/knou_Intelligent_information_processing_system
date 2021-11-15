clc; clear;
load HW3_Q2_1_result C1 C2 C3; % 문제2-1 결과 데이터 로드
C = [C1; C2; C3;]; % 클래스별 전체 집합 정의

M1 = mean(C1); % 클래스1 C1의 평균 계산
M2 = mean(C2); % 클래스2 C2의 평균 계산
M3 = mean(C3); % 클래스3 C3의 평균 계산
M = [M1;M2;M3]; % 클래스1~3 평균 집합

plot(C(:,1), C(:,2), '*'); % 클래스 1~3 전체 데이터 산점도 표시
hold on;
plot(M(:,1), M(:,2), 'r*'); % 클래스 1~3의 평균 집합 산점도 표시

save HW3_Q2_2_result M;