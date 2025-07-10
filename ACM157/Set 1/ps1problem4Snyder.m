sample = normrnd(0,1,15,1);
%sample = normrnd(0,1,50,1);
%sample = normrnd(0,1,100,1);
%sample = normrnd(0,1,1000,1);

qqplot(sample)
figure
histogram(sample)

%a) The points on the QQ plot do appear to fall roughly on a straight line
%but it's not completely clear without the aid of a fitted line. The tails
%are not consistently linear, though. The histogram doesn't appear to be
%consistently symmetric or bell shaped but it is usually unimodal. This is
%likely because our sample size is too small and not representative of the
%distribution.

%b) 50 samples: It's more clear that the QQ plot is linear but the tails
%are still ambiguous. The histogram is much more consistently symmetric but
%still occasionally has skewedness and isn't perfectly bell shaped. It is
%unimodal.
% 100 samples: The QQ plot is consistently linear, the tails are more
% clearly linear than previously. The histogram is consistently symmetric
% and convincingly bell shaped and unimodal.
% 1000 samples: The QQ plot is obviously linear. The histogram is
% consistently bell shaped, symmetric, and unimodal.

%c) I would estimate that the critical sample size is somewhere around 100
%samples.