clc; clear;
load HW3_Q1_1_result Class1 Class2 w wo; % 문제1-1 의 HW3_Q1_1_result 학습된 퍼셉트론 파라미터 읽기
 
TestData = [4 2; 2, 3; -1, 2; -3, -2]; % 문제1-2의 new Data 입력1(4,2), 입력2(2,2), 입력3(-1,-2), 입력4(-3,-2)
a = [-4:0.1:4]; % 결정경계의 출력

% 클래스별 산점도 그리기
plot(Class1(:,1),Class1(:,2), 'ro');
hold on;
plot(Class2(:,1),Class2(:,2), 'bx');
axis([-4 4 -4 4]);


% 입력된 new Data 4개 의 퍼셉트론 결정경계 모델의 분류 반복문
for i = 1 : size(TestData,1)
    % 퍼셉트론 결정결계의 판별함수
    if (TestData(i,:) * w + wo > 0)
        y(1,i) = 1;   % Class 2
    else
        y(1,i) = 0;   % Class 1
    end
    sprintf('데이터%d(%d, %d) = Class%d', i, TestData(i,1), TestData(i,2), y(1,i)+1)
    %테스트 데이터1~4 별로 산점도 그리기
    plot(TestData(i,1), TestData(i,2), 's', 'Color', [i*0.25 1-i*0.2 i*0.25])
end

plot(a, (-w(1,1)*a-wo)/w(2,1),'Color','g','Linewidth', 4);
legend('Class1', 'Class2', 'Test1', 'Test2', 'Test3', 'Test4') % 범례 표시
hold off;
grid on;

save HW3_Q1_2_result y
