clc; clear;
load HW3Data_1.mat X Y;

Mstep = 5; %최대 반복 횟수 설정
INPUT = 2; %입력 2개 퍼셉트론
OUTPUT = 1; %출력 1개 퍼셉트론
Class1 = []; %Class 1
Class2 = []; %Class 2

% 데이터 X 를 클래스별로 변수에 저장
for i=1:size(Y, 1)
  % 데이터 Y 클래스의 데이터가 0이면 Class1 , 1이면 Class2 로 저장
  if (Y(i) == 0) 
   Class1(size(Class1,1)+1,:) = [X(i,:) Y(i,:)];
   else 
   Class2(size(Class2,1)+1,:) = [X(i,:) Y(i,:)];
   end
end

% 산점도 표시 Class 1, Class 2
plot(Class1(:,1),Class1(:,2), 'ro');
hold on;
plot(Class2(:,1),Class2(:,2), 'bx');
axis([-4 4 -4 4]); %  축 제한과 종횡비 설정
pause
% 타우 = 1 표시
w = rand(INPUT,1) * 0.4 -0.2;  % 파라미터 초기화
wo = rand(1) * 0.4 - 0.2';
a = [-4:0.1:4]; % 결정경계의 출력

plot(a, (-w(1,1) * a - wo) / w(2,1), 'b');
eta = 0.5;

for j = 2 : Mstep + 1 %모든 학습 데이터에 대해 반복횟수(6)만큼 학습 반복
  pause % 단계별 plot 을 위해 pause
  
  for i=1:size(X,1) % 학습데이터 X size
    x = X(i,:); % X(i) 벡터 데이터
    ry = Y(i,1); % X 데이터의 목표 클래스 데이터

    if (x*w+wo>0) y=1; else y=0; end; % 퍼셉트론 출력 계산
    e=ry-y; % 오차계산
    dw= eta*e*x'; % 기울기 수정량 계산
    dwo= eta*e*1; 
    w=w+dw; % 기울기 파라미터 수정
    wo=wo+dwo;
  end
  % 2~6 (5회 반복) plot 표시
  % 마지막 step 은 요구사항에 따라 초록색 결정경계로 표시
  if j == Mstep + 1 
    plot(a, (-w(1,1)*a-wo)/w(2,1),'Color','g','Linewidth', 4);
  else
    plot(a, (-w(1,1)*a-wo)/w(2,1),'Color',[j*0.15 1-j*0.15 j*0.15],'Linewidth', 1);
  end
  hold on;

end

legend('Class1', 'Class2','init', 't=2', 't=3', 't=4', 't=5', 't=6'); % 범례 표시;
hold off;
grid on;

save HW3_Q1_1_result w wo Class1 Class2;    % 학습된 퍼셉트론 파라미터를 저장 