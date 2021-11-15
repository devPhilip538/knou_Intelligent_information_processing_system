clc; clear;
load HW3_Q2_1_result C1 C2 C3; % 
load HW3_Q2_2_result M;

K = 3; % 군집화 개수 : 3
RETRY = 10; % 최대 반복 횟수 10 : 
C = [C1; C2; C3;]; % 문제 2번의 생성한 데이터 Class 전체
SIZE = size(C,1); % 전체 데이터 개수
m = zeros(K,2); % 대표 백터값
Xlabel = zeros(SIZE,1); %대표 라벨값

figure(1);
plot(C(:,1), C(:,2),'*') % 그리기
hold on;
plot(M(:,1), M(:,2), 'r*');
hold on;

i=1; % i 초기화
while(i<=K) % K개 군집개수만큼 대표 벡터 선택
  t=floor(rand*SIZE); % 랜덤 데이터 선택
  if ((C(t,:)~=m(1,:)) & (C(t,:)~=m(2,:)) & (C(t,:)~=m(3,:)))
    m(i,:) = C(t,:); % 선택된 데이터를 대표벡터로
    plot(m(i,1), m(i,2),'ks'); % 대표벡터를 그래프에 표시
    i=i+1; % i 증가
  end
end

cmode=['gd'; 'b*'; 'mo']; % 클러스터별로 표시 기호 설정

for iteration=1:RETRY % 최대 10회 반복
  % 단계 4 (단계 2와 3을 반복)
  figure(iteration+1); 
  hold on;
  
  % 단계 2 -- 각 데이터를 가까운 클러스터에 할당
  for i=1:SIZE 
      for j=1:K % 군집 K개(3) 반복
          d(j)=(C(i,:)-m(j,:))*(C(i,:)-m(j,:))'; % 대표벡터와 거리 계산
      end
      [minv, Xlabel(i)]= min(d); % 가장 짧은거리 대표벡터로 라벨붙이기
      plot(C(i,1),C(i,2), cmode(Xlabel(i),:)); % 할당된 클러스터를 표시
      plot(M(:,1), M(:,2), 'r*'); % 클래스 1~3의 평균 집합 산점도 표시
  end

% 단계 3 -- 대표벡터를 다시 계산
  oldm = m; % 대표벡터를 oldm 변수에 저장
  for i = 1:K % 군집 K개(3) 반복
    I = find(Xlabel==i); % 라벨별로 모아진 데이터를 I(Class) 저장
    m(i,:) = mean(C(I,:)); % 라벨별로 모아진 I의(Class) 의 데이터 평균
    plot(m(i,1), m(i,2),'ks'); % 수정된 대표 벡터표시(라벨별로 모아진 데이터 평균)
  end
    
  %이전 평균값과 iteration 번째의 평균 값이 0.0001 보다 작으면 종료 
  if sum(sum(sqrt((oldm-m).^2))) < 10^(-3) 
    break; % 반복 완료 조건 검사 
  end 
end % 단계 4 (단계 2와 3을 반복)
hold on;
grid on;