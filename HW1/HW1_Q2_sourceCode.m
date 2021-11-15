% 작업된 파일을 불러온다.
load HW1_Q1_result

% (표준)평균 값을 구한다.
m1 = mean(C1);
m2 = mean(C2);
m3 = mean(C3);
m4 = mean(C4);

% (표준) 공분산을 반환
s1 = cov(C1);
s2 = cov(C2);
s3 = cov(C3);
s4 = cov(C4);

% 작업 공간 변수를 파일로 저장
save HW1_Q2_result m1 m2 m3 m4 s1 s2 s3 s4
