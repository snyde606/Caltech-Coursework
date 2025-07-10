bootpop=[];

for k=1:31
  for j=1:40
      bootpop = [bootpop sample1(j)];
  end
end

r = mod(length(bwt),40);
k = (length(bwt)-r)./40;

bootpop2=[];
for a=1:k
  for j=1:40
      bootpop2 = [bootpop2 sample1(j)];
  end
end
bootpop3=[];
for a=1:k+1
  for j=1:40
      bootpop3 = [bootpop3 sample1(j)];
  end
end

method1 = [];
method2 = [];
for m=1:100

    samples=[];
    for a=1:1000
      samples = [samples;datasample(bootpop,40,'Replace',false)];
    end

    means=[];
    for a=1:1000
      means = [means mean(samples(a,:))];
    end

    val1 = sum(means)./1000;
    edited = (means-val1).^2;
    estimateste = sqrt(sum(edited)./1000) %3b
    method1 = [method1 estimateste];

    samples=[];
    p=(1-r/40).*(1-40./(length(bwt)-1));
    for a=1:1000
      randvar = rand();
      if randvar < p
           samples = [samples;datasample(bootpop2,40,'Replace',false)];
      else
           samples = [samples;datasample(bootpop3,40,'Replace',false)];
      end
    end

    means=[];
    for a=1:1000
      means = [means mean(samples(a,:))];
    end

    val1 = sum(means)./1000;
    edited = (means-val1).^2;
    estimateste2 = sqrt(sum(edited)./1000) % 3c
    method2 = [method2 estimateste2];
    
end

figure
boxplot(method1)
hold on
boxplot(method2)
boxplot(sterr)
ylim([0.06 0.1])