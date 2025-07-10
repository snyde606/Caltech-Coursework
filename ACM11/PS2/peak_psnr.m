%2b
function psnr = peak_psnr(iTil,iRes)
    iTil = double(iTil); %convert from uint8 to double so we can take log10
    iRes = double(iRes); %^
    sm = (iTil-iRes).^2; % compute denominator matrix; will sum below
    siz = size(iTil); %use size to get M and N
    psnr = 10.*log10(255.^2.*siz(1).*siz(2)./sum(sum(sm))); % compute psnr
end