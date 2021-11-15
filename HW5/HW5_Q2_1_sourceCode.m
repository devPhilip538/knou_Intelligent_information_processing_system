clc; clear; % 초기화
load HW5Data_2.mat X Y; % HW5Data_2 데이터(X), 라벨(Y)를 로드
j = 1;  k = 1;  l = 1;  % 데이터 분류에 사용할 변수 j(Class1), k(Class2), l(Class3) 초기화
for i = 1:size(X, 1)    % 입력데이터 X에 대한 분류 시작
    if(Y(i,1) == 1)     % i행 1열 데이터의 라벨값이 1이면, Class1 
        X1(j, :) = X(i, :);    % X1 분류 및 저장
        j = j+1;               % X1 의 변수 하나 증가
    elseif(Y(i,2) == 1) % i행 2열 데이터의 라벨값이 1이면, Class2
        X2(k, :) = X(i, :);    % X2 분류 및 저장
        k = k+1;               % X2 의 변수 하나 증가
    elseif(Y(i,3) == 1) % i행 3열 데이터의 라벨값이 1이면, Class3 
        X3(l, :) = X(i, :);    % X3 분류 및 저장
        l = l+1;               % X3 의 변수 하나 증가
    end
    T(i, :) = Y(i,:); % 클래스 라벨 저장
end
plot(X1(:,1), X1(:,2), 'ro');  % X1의 산점도를 그림(빨강 o)
hold on;                       % 덮어쓰기
plot(X2(:,1), X2(:,2), 'go');  % X2의 산점도를 그림(녹색 o)
hold on;                       % 덮어쓰기
plot(X3(:,1), X3(:,2), 'bo');  % X3의 산점도를 그림(파랑 o)
legend('C1', 'C2', 'C3');      % 범례 표시
grid on;

save HW5_Q2_1_result X1 X2 X3 X T