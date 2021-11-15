% size 샘플 변수를 생성
size=100;

% 주어진 데이터의 size 만큼의 평균값
m1=repmat([0,0], size,1);
m2=repmat([3,5], size,1);

% C1, C2 공분산 행렬
s1=[4 0; 0 4];
s2=[3 0; 0 5];

% 가우시안 분포를 만든다.
% randn 함수로 A,B 샘플의 2차원 데이터 행열을 반환한다.
% sqrtm 함수로 공분산을 행렬 제곱근하여 곱하여주고 계산된 평균값을 더하여 준다.
C1=randn(size,2)*sqrtm(s1) + m1;
C2=randn(size,2)*sqrtm(s2) + m2;

% X1~X2 데이터를 x y 축에 맞게 화면에 보여준다.
% 동그라미 모양, 빨간색으로 표현
plot(C1(:,1),C1(:,2), 'ro');
hold on; % 그래프 덮어쓰기

% 네모 모양, 파란색으로 표현
plot(C2(:,1),C2(:,2), 'bs');
hold on; % 그래프 덮어쓰기

% 각 산점도의 범례 그리기
legend('C1', 'C2') 
hold off; % 그래프 덮어쓰기 해제

% 작업 공간 변수를 파일로 저장
save HW2_Q1_1_result C1 C2