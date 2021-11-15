clc; clear; % 초기화
load HW5Data_1 data % HW5Data_1에서 data(800 X 2)를 읽어옴
X = data';          % X = data의 전치행렬로 정의 2 * 800
N = size(X,2);      % 데이터 사이즈(800)
M = [2 ; 6 ; 10];   % 가우시안 성분의 수 행렬(2, 6, 10개)
Maxtau = 30;       % 최대 반복횟수 설정

for k = 1 : size(M,1)                    % 수행할 가우시안 성분수 사이즈(3개)
    Mu = rand(M(k),2)*5;                 % 가우시안 성분의 초기화 (평균)
    
    for i = 1:M(k)                       % 가우시안 성분의 초기화 (분산)
        Sigma(i,1:2,1:2) = [1 0; 0 1];   % 가우시안 성분의 공분산 행렬 생성
    end                                  % 각각 가우시안 성분의 초기 공분산 행렬 생성 완료
    
    alpha = zeros(M(k),1) + 1/M(k);      % 파라미터의 초기화 (혼합계수)
    figure(M(k))                         % 창 생성
    
    drawgraph(X, Mu, Sigma, 1);             % 그래프 그리기 함수 호출
    title(sprintf('Init(M = %d)', M(k)) );  % 그래프(최초) 명
       
    for tau = 1:Maxtau                      % 최대 반복횟수까지 반복
        for j = 1:M(k)                      % 가우시안성분의 수 만큼 반복 
            px(j,:) = gausspdf(X, Mu(j,:), reshape(Sigma(j,:,:),2,2));  % 확률변수값 계산
        end
        sump = px'*alpha;                   % 혼합계수를 곱한 계산
        for j = 1:M(k)                      % 가우시안성분의 수 만큼 반복
            r(:,j) = (alpha(j)*px(j,:))'./sump;  % 기대치 계산
        end
        L(tau) = sum(log(sump));         % 현재 파라미터의 로그우도 계산

        for j = 1:M(k)                      % 가우시안성분의 수 만큼 반복 
            sumr = sum(r(:,j));             % 기대치의 성분별 합산
            Rj = repmat(r(:,j),1,2)';       % 행렬 계산을 위한 준비
            Mu(j,:) = sum(Rj.*X, 2)/sumr;   % 새로운 평균
            rxmu = (X - repmat(Mu(j,:), N, 1)').*Rj; % 새로운 공분산 계산
            Sigma(j,1:2, 1:2) = rxmu*(X-repmat(Mu(j,:),N,1)')'/sumr;  % 새로운 공분산 계산
            alpha(j) = sumr/N;           % 새로운 혼합계수
        end
                
        if (mod(tau,5) == 0)                       % 반복 횟수 첫번째자리가 1 일때(1,11,21 ~ 91)
          drawgraph(X, Mu, Sigma, ceil(tau/5)+1);  % 그래프 그리기 함수 호출
          title(sprintf('Tau = %d', tau));          % 그래프(최초) 명
        end
    end
    drawgraph(X,Mu, Sigma, ceil(tau/5)+2);   % 그래프 그리기 함수 호출
    title(sprintf('end (M = %d)', M(k)) );    % 그래프(최초) 명
    figure(max(M)+1);                         % 로그우도 그릴 그래프 호출
    plot(L, 'color', [1-k*0.3, 1-k*0.2, k*0.3]);  % 가우시안 성분의 수에 따라 그래프 색상 변화
    hold on;
end

legend(sprintf('M = %d', M(1)), sprintf('M = %d', M(2)), sprintf('M = %d', M(3))) % 범례 표시
hold off;
