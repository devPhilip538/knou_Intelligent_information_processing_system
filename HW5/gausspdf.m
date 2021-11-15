function [out]=gausspdf(X, mu, sigma) % 함수 정의
n=size(X,1); % 입력 벡터의 차원
N=size(X,2);% 데이터의 수
Mu=repmat(mu',1,N); % 행렬 연산을 위한 준비

% 확률밀도값 계산
out = (1/((sqrt(2*pi))^n*sqrt(det(sigma))))*exp(-diag((X-Mu)'*inv(sigma)*(X-Mu))/2);