%Dictionary: {'United States', 'President', 'Congress', 'State', ...
%'Office', 'House', 'Vice', 'Citizens', 'Representatives', 'Electors'}
constitution = [76, 121, 60, 211, 57, 41, 36, 18, 29, 16];
bernieSanders = [58, 67, 41, 99, 27, 40, 6, 9, 21, 0];
hillaryClinton = [54, 144, 27, 205, 29, 82, 6, 10, 4, 5];
donaldTrump = [64, 226, 21, 158, 37, 54, 5, 5, 5, 1];
tedCruz = [51, 90, 27, 130, 16, 12, 1, 22, 1, 0];
johnKasich = [18, 59, 27, 137, 23, 57, 3, 7, 22, 0];

constitution = constitution/norm(constitution);
bernieSanders = bernieSanders/norm(bernieSanders);
hillaryClinton = hillaryClinton/norm(hillaryClinton);
donaldTrump = donaldTrump/norm(donaldTrump);
tedCruz = tedCruz/norm(tedCruz);
johnKasich = johnKasich/norm(johnKasich);

Z = [transpose(constitution),transpose(bernieSanders),...
    transpose(hillaryClinton),transpose(donaldTrump),...
    transpose(tedCruz),transpose(johnKasich)];

G = transpose(Z) * Z;

[M, mostSimilarIndex] = max(G(1,2:6));

disp('Most similar wikipedia page to the Constitution: ');
if mostSimilarIndex == 1
    disp('Bernie Sanders');
elseif mostSimilarIndex == 2
    disp('Hillary Clinton');
elseif mostSimilarIndex == 3
    disp('Donald Trump');
elseif mostSimilarIndex == 4
    disp('Ted Cruz');
elseif mostSimilarIndex == 5
    disp('John Kasich');
end