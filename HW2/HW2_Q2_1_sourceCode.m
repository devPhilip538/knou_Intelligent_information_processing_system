clc; clear;

load matlab_iris_shuffle.mat iris_class iris_data
% iris data 로드
CLASS = cell2mat(iris_class);
DATA = str2double(iris_data);

% iris data DATA & CLASS 를 한개의 데이터로 합친다.
IRIS = [DATA CLASS];
N = size(IRIS,1); % IRIS DATA 수

K = [1 5 10 15 20 25 30]; % 과제에서 주어진 K 값을 행렬화 하여 for문으로 사용할 것임
Etrain = zeros(1,size(K,2)); %K값에대한 오류율 행렬 저장

% K 값 (1 5 10 15 20 25 30) 반복문 수행
for n = 1:size(K,2)
  k = K(n); % K값
  
  % 전체 데이터 IRIS DATA size만큼 반복수행
  for i = 1:N 
    xt=IRIS(i,1:4); % IRIS DATA 입력
    xc=IRIS(i,5); % IRIS CLASS 입력
  
    for j=1:N % 모든 데이터와의 거리 계산
      d(j,1) = norm(xt-IRIS(j,1:4)); % 데이터 유클리디안거리 를 계산하여 입력력
      d(j,2) = IRIS(j,5); % 클래스명 입력
    end

  
    [data,idx] = sort(d(:,1)); % 거리 순으로 정렬(data = 정렬된 거리(d) 값 , idx = d 데이터의 대응하는 index)
    sort_data = [data, d(idx,2)]; %iris 클래스도 동일하게 정렬하기 
    c=zeros(3,1); % 가까운 K개의 데이터를 저장할 행렬 선언
   
    for j=1:k   % 가까운 K개 데이터의 라벨만큼 반복
        if (sort_data(j,2) == 1) c(1) = c(1) +1; end % 정렬된 K개의 데이터의 클래스 카운트
        if (sort_data(j,2) == 2) c(2) = c(2) +1; end
        if (sort_data(j,2) == 3) c(3) = c(3) +1; end
    end
    
    [~, maxi] = max(c); % 최대 투표수를 받은 클래스로 할당
    if(maxi ~= xc) %원래 클래스라벨과 다르면 
        Etrain(n) = Etrain(n) + 1; % 오류데이터의 개수를 증가
    end
  end
end

% K , 오류개수, 오류율 순차적으로 노출
K
Etrain
Etrain_rate = Etrain / N

% 작업 공간 변수를 파일로 저장
save HW2_Q2_1_result K Etrain Etrain_rate