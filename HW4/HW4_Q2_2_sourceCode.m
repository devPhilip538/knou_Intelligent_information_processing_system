clc; clear;

load HW4_Q2_1_result     % 데이터 불러오기

Ydim = 2; 
Wo = orth(W(:, 1 : Ydim));                 % 변한행렬 직교화
Train_matPCA = (Wo' * (Train)')';       % PCA에 의한 차원축소(학습데이터)
Sw = zeros(Ydim);                       % Within-Scatter Martrix의 계산

figure, hold on, grid on;
for ii = 1 : Mcls
    if exist("OCTAVE_VERSION", "builtin") > 0 % Octave
    plot(Train_matPCA(Train_label == ii,1), Train_matPCA(Train_label == ii,2), '.', 'MarkerSize', 5, 'Color',[rand rand rand])

    else % MATLAB
        plot(Train_matPCA(Train_label == ii,1), Train_matPCA(Train_label == ii,2), '.')
    end
end
title('PCA')
legend('Location','northeastoutside')

m = []; % m 초기화
for i = 1 : Mcls                                            % 클래스 수만큼 for문을 수행
    C = Train_matPCA((i-1) * Ntrn / Mcls + 1 : i * Ntrn / Mcls, :); % 같은 클래스 집합 구분
    Sw = Sw + Ntrn / Mcls * cov(C);                         % 클래스 내 산점행렬 값을 더해나감
    m(i,:) = mean(C);                                       % 클래스의 평균값을 곗산
end

Sb = Mcls * cov(m);                 % Between-Scatter Matrix의 계산
[Vf,Df,Uf] = svd(inv(Sw) * Sb);     % LDA 변환행렬 찾기
Z = (Vf' * Train_matPCA')';                    % LDA에 의한 특징추출 (학습데이터)

figure, hold on, grid on
for ii = 1 : Mcls
    if exist("OCTAVE_VERSION", "builtin")>0 % Octave
        plot(Z(Train_label == ii,1), Z(Train_label == ii,2), '.', 'MarkerSize', 5, 'Color',[rand rand rand])

    else % MATLAB
        plot(Z(Train_label==ii,1), Z(Train_label==ii,2), '.')
    end
end
title('LDA')
legend('Location','northeastoutside')

save HW4_Q2_2_result;


