function drawgraph(X, Mu, Sigma, cnt)   % 함수 drawgraph 정의(4개의 인자를 받음)
M = size(Mu, 1);                        % 입력받은 Mu의 수를 확인하여 Gaussian 수로 판단
subplot(2, 4, cnt);                     % 분할한 그래프를 그릴 것임 (τ값에 따른 변화)

plot(X(1,:), X(2,:), '*');             % 데이터의 산점도 그림
hold on                                 % 그래프 겹쳐 그리기
axis([-10 15 -2 12]);              % 가로/세로 축 고정
grid on                                 % 그래프에 점선(눈금) 표시
plot(Mu(:,1), Mu(:,2), 'mp');           % 중심 값 그림(마젠타색 별)
 
for j = 1:M                             % Gaussian 수 만큼 for문 수행
    sigma = reshape(Sigma(j,:,:),2,2);  % 연산을 위해 공분산행렬 재구성
    t = [-pi:0.1:pi]';                  % -π ~ π까지를 함수값으로 사용(원좌표계)
    A = sqrt(2) * [cos(t) sin(t)] * sqrtm(sigma)+repmat(Mu(j,:), size(t), 1);  % 가우시안 영역 계산
    plot(A(:,1), A(:,2), 'r-', 'linewidth', 2);  % 가우시안 영역 그림(적색 선)
end                                     % 가우시안 영역 그림 완료