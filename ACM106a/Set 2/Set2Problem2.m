H = hilb(10);
[Q1,R1] = clgs(H);
[Q2,R2] = mgs(H);

acc1 = norm(H-Q1*R1,'fro')
acc2 = norm(H-Q2*R2,'fro')

orthog1 = norm(eye(size(Q1))-Q1'*Q1,'fro')
orthog2 = norm(eye(size(Q2))-Q2'*Q2,'fro')


H = hilb(100);
[Q1,R1] = clgs(H);
[Q2,R2] = mgs(H);

acc1 = norm(H-Q1*R1,'fro')
acc2 = norm(H-Q2*R2,'fro')

orthog1 = norm(eye(size(Q1))-Q1'*Q1,'fro')
orthog2 = norm(eye(size(Q2))-Q2'*Q2,'fro')