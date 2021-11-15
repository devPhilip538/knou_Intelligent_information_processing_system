clc; clear;
load HW4_COIL20 X Y Xt Yt; % 데이터 불러오기

%%%%% PCA and LDA for Face Recognition
%%%%% 주성분분석과 선형판별분석에 의한 얼굴인식 특징 추출
Train = X;                  % 280 x 1024 행렬, 학습데이터, 280개 객체 영상 데이터로 각 영상은 1024차원.
Train_label = Y';            % 280 x 1 행렬, 280개 객체 영상에 대한 클래스 레이블.
Test = Xt;                  % 1160 x 1024 행렬, 테스트 데이터, 1160개 객체 영상 데이터.
Test_label = Yt';            % 1160 x 1 행렬, 1160개 객체 영상에 대한 클래스 레이블.

Ntrn = size(Train,1);       % 학습데이터의 수
Ntst = size(Test,1);        % 테스트데이터의 수
Mcls = 20;                  % 클래스의 수

%%%%% PCA 특징추출
meanfig = mean(Train);                  % 학습데이터 행렬의 평균
M = repmat(meanfig, size(Train,1),1);   % 평균벡터를 데이터 수만큼 반복한 행렬
S = (Train - M) * (Train - M)' / Ntrn;  % 고유치분석을 위한 행렬를 계산
[V,D,U] = svd(S);                       % 고유치 분석
W = (Train - M)' * V;                   % 고유벡터 찾기

%%%%% LDA 특징추출
eval=diag(D);                           % PCA로 축소할 차원 결정 
for i = 1 : Ntrn
    if ((sum(eval(1:i)) / sum(eval)) > 0.95) break; % 고유치 합의 비율이 0.95보다 큰 특징의 차원을 찾음
    end
end

Ydim = i; % 고유치 의 합이 0.95보다 큰 특징의 차원값: 61
Wo = orth(W(:,1:Ydim));                 % 변한행렬 직교화
Train_matPCA = (Wo' * (Train)')';       % PCA에 의한 차원축소(학습데이터)
Test_matPCA = (Wo' * (Test)')';         % PCA에 의한 차원축소(테스트데이터)
Sw = zeros(Ydim);                       % Within-Scatter Martrix의 계산

for i = 1 : Mcls                          % 클래스 수만큼 for문을 수행
    C = Train_matPCA((i - 1) * Ntrn / Mcls + 1 : i * Ntrn / Mcls, :);  % 같은 클래스 집합 구분
    Sw = Sw + Ntrn / Mcls * cov(C);     % 클래스 내 산점행렬 값을 더해나감
    m(i,:) = mean(C);                   % 클래스의 평균값을 곗산
end

Sb = Mcls * cov(m);                     % Between-Scatter Matrix의 계산
[Vf, Df, Uf] = svd(inv(Sw)*Sb);         % LDA 변환행렬 찾기
Train_featureLDA = (Vf' * Train_matPCA')';        % LDA에 의한 특징추출 (학습데이터)
Test_featureLDA = (Vf' * Test_matPCA')';          % LDA에 의한 특징추출 (테스트데이터)

%%%%% Face Recognition Using PCA and LDA
%%%%% 주성분분석과 선형판별분석에 의한 얼굴인식 분류

%%%%% 추출된 PCA, LDA 특징으로 분류(최근접이웃 분류기)
for dim = 1 : Mcls-1                            % 가능한 모든 특징 차원에 대하여 반복 수행
    Wo = orth(W(:,1:dim));                      % 정한 차원만큼 주성분벡터행렬 직교화
    Train_featurePCA = (Wo' * (Train'))';          % PCA 특징추출 (학습데이터) 
    Test_featruePCA = (Wo' * (Test)')';            % PCA 특징추출 (테스트데이터)

    for i = 1 : Ntst                                    % 각 테스트 데이터에 대해 분류 시작 
        yt = Test_featruePCA(i,:);                  % 테스트 데이터에 대한 PCA 특징
        zt = Test_featureLDA(i,1:dim);              % 테스트 데이터에 대한 LDA 특징 
        
        for j=1 : Ntrn                                      % 학습데이터들과의 거리계산
            dy(j) = norm(yt - Train_featurePCA(j,1:dim));   % 학습데이터와의 거리 계산 (PCA)
            dz(j) = norm(zt - Train_featureLDA(j,1:dim));   % 학습데이터와의 거리 계산 (LDA)
        end

        [minvy, miniy] = min(dy);               % 최근접이웃 찾기 (PCA 특징)
        [minvz, miniz] = min(dz);               % 최근접이웃 찾기 (LDA 특징)
        
        min_labely(i) = Train_label(miniy);     % 최근접이웃의 클래스로 할당 (PCA) 
        min_labelz(i) = Train_label(miniz);     % 최근접이웃의 클래스로 할당 (LDA)
    end

    error_labely = find(min_labely - Test_label);      % 분류율 계산 (PCA) 
    correcty = Ntst - size(error_labely,2); 
    classification_ratey(dim) = correcty / Ntst; 
    
    error_labelz = find(min_labelz - Test_label);      % 분류율 계산 (LDA)
    correctz = Ntst - size(error_labelz,2); 
    classification_ratez(dim) = correctz / Ntst;
end

%%%%% Result
figure(1)
[maxv_classy maxi_classy] = max(classification_ratey); % PCA 분류에서 최대인 경우를 계산 및 출력
[maxv_classz maxi_classz] = max(classification_ratez); % LDA 분류에서 최대인 경우를 계산 및 출력
sprintf('PCA - 차원이 %d 일때, 분류율 %.2f 퍼센트 발생.', maxi_classy, maxv_classy * 100)
sprintf('LDA - 차원이 %d 일때, 분류율 %.2f 퍼센트 발생.', maxi_classz, maxv_classz * 100)

plot([1:Mcls-1], classification_ratey, 'b');    % PCA를 적용한 경우에 대한 그래프(청색 선)
hold on;
plot([1:Mcls-1], classification_ratez, 'r');    % LDA를 적용한 경우에 대한 그래프(적색 선)
legend('PCA', 'LDA');                           % 범례 입력
grid on;
hold off;

save HW4_Q2_1_result W Train Mcls Ntrn Train_label classification_ratey classification_ratez;