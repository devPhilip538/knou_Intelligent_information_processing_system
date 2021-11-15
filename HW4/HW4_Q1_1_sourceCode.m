clc; clear;
SIZE = 100; % 클래스별 데이터 개수 100개

% size 샘플 변수를 생성
% 주어진 데이터의 size 만큼의 평균값 
m1 = repmat([0,0], size, 1); 
m2 = repmat([0,5], size, 1);

% C1, C2 공통의 공분산 행렬 
s=[10 2; 2 1];

% 가우시안 분포를 만든다.
% randn 함수로 A,B 샘플의 2차원 데이터 행열을 반환한다.
% sqrtm 함수로 공분산을 행렬 제곱근하여 곱하여주고 계산된 평균값을 더하여 준다. 
C1 = randn(SIZE,2) * sqrtm(s) + m1;
C2 = randn(SIZE,2) * sqrtm(s) + m2;

% C1~C2 데이터를 x y 축에 맞게 화면에 보여준다. 
% 동그라미 모양, 빨간색으로 표현 
plot(C1(:,1),C1(:,2), 'b*'); % 별 모양, 파란색으로 표현
hold on; % 그래프 덮어쓰기 

plot(C2(:,1),C2(:,2), 'ro'); % 동그라미 모양, 빨간색으로 표현
hold on; % 그래프 덮어쓰기

legend('Class1', 'Class2'); % 각 산점도의 범례 그리기 
axis([-10 10 -5 10]); % 산점도 출력 공간 표시
hold off; % 그래프 덮어쓰기 해제
grid on;

% 작업 공간 변수를 파일로 저장
save HW4_Q1_1_result C1 C2 m1 m2 s