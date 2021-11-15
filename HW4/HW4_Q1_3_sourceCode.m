clc; clear;
load HW4_Q1_2_result D M S C1 C2 V1 V2 D1 D2 w1 w2;
% D : 고유치 행렬 , M : 전체 데이터에 대한 평균 , S : 전체 데이터에 대한 공분산
% V1, D1, w1 : PCA 고유벡터행렬, 고유치행렬, PCA 벡터
% V2, D2, w2 : LDA 고유벡터 행렬, 고유치행렬, LDA 벡터

% PCA
figure(1)
YX1 = w1' * C1'; % PCA 의 C1을 주성분벡터로 사영
YX2 = w1' * C2'; % PCA 의 C2를 주성분벡터로 사영 
pYX1 = w1 * YX1; % 사영된 C1 데이터를 2차원 공간으로 환원
pYX2 = w1 * YX2; % 사영된 C2 데이터를 2차원 공간으로 환원
plot(pYX1(1,:), pYX1(2,:) + M(2), 'b*'); % 2차원으로 환원된 C1 데이터의 산점도를 그림
hold on;
plot(pYX2(1,:), pYX2(2,:) + M(2), 'ro'); % 2차원으로 환원된 C2 데이터의 산점도를 그림
hold on;

% LDA
YX1 = w2' * C1'; % LDA 의 C1을 고유벡터로 사영
YX2 = w2' * C2'; % LDA 의 C2를 고유벡터로 사영 
pYX1 = w2 * YX1; % 사영된 C1 데이터를 2차원 공간으로 환원
pYX2 = w2 * YX2; % 사영된 C2 데이터를 2차원 공간으로 환원
plot(pYX1(1,:), pYX1(2,:) + M(2), 'b*'); % 2차원으로 환원된 C1 데이터의 산점도를 그림
hold on;
plot(pYX2(1,:), pYX2(2,:) + M(2), 'ro'); % 2차원으로 환원된 C2 데이터의 산점도를 그림
hold on;

plot([0 w1(1)*D1(2,2)] + M(1), [0  w1(2)*D1(2,2)] + M(2), 'g'); % 주성분벡터 표시 : 녹색 선
hold on;
plot([0 w2(1)*(-8)] + M(1), [0 w2(2)*(-8)] + M(2), 'm'); % 고유벡터 표현 : 마젠타색 선
hold off;
axis([-10 10 -5 10]); % 산점도 출력 공간 표시
legend('Class1', 'Class2','Class1', 'Class2','PCA', 'LDA'); % 범례 표시
grid on; hold off;