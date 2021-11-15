clc; clear; % 초기화
load HW4_Q1_1_result % 문제 1-1 결과 데이터 로드
SIZE = 100; % 데이터 개수

% 문제 1-1의 데이터 산점도 표시
plot(C1(:,1),C1(:,2), 'b*'); % 클래스 1 : 동그라미 모양, 빨간색으로 표현
hold on; 

plot(C2(:,1),C2(:,2), 'ro');  % 클래스 2 : 네모 모양, 파란색으로 표현 
hold on;

M = mean([C1; C2]); % 전체 데이터에 대한 평균
M1 = mean(C1); % 클래스 1의 평균 M1
M2 = mean(C2); % 클래스 2의 평균 M2 

S = cov([C1; C2]); % 전체 데이터에 대한 공분산

% PCA 분석
[V1,D1] = eig(S); % PCA를 적용한 고유치 분석(V1: 고유벡터행렬 / D1: 고유치행렬)
w1 = V1(:,2); % PCA에 대한 고유벡터값 w1
plot([0 w1(1)*D1(2,2)] + M(1), [0 w1(2)*D1(2,2)] + M(2), 'g'); % 주성분벡터 표현 : 녹색 선
hold on;

% LDA 분석
Sw = SIZE * cov(C1) + SIZE * cov(C2); % 클래스 내 산점행렬 계산(Within Scatter)
Sb = (M1 - M2)' * (M1 - M2); % 산점행렬 계산(Between Scatter)
[V2,D2] = eig(inv(Sw)*Sb); % LDA적용한 고유치 분석(V2: 고유벡터행렬 / D2: 고유치행렬)
w2 = V2(:,2); % LDA에 대한 고유벡터 w2
hold on;
plot([0 w2(1)*(-8)] + M(1), [0 w2(2)*(-8)] + M(2), 'm'); % 고유벡터 표현 : 마젠타색 선

legend('Class1', 'Class2','PCA', 'LDA'); % 각 산점도의 범례 그리기 
axis([-10 10 -5 10]); % 산점도 출력 공간 표시

hold off; % 그래프에 덮어쓰기 해제
grid on; % grid 적용

save HW4_Q1_2_result M S C1 C2 V1 V2 D1 D2 w1 w2