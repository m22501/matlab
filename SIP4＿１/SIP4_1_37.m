[msc, fs] = audioread('piano.mp3');
t = 0:1/fs:length(msc)/fs;
t = t(1:end-1);

w = [0, 0.3, 0.4, 1];
a = [0, 0, 1, 1];
N = 100;
h = firpm(N, w, a);
freqz(h);

y = conv(msc, h);

%figure();
%subplot(1,2,1);
%plot(t, msc);

%subplot(1,2,2);
%plot(t, y(1:length(t)));

% 自作

% y 畳み込み計算の結果
% k,h,N システム数
% msc,n 信号長
% y2 自作畳み込み計算の結果
% y_err y2とyの誤差

y2 = zeros(size(msc)); % y2をmscと同じ行列にする

for n = 1:length(msc) + N % 信号長の回数実行

    d = 0; % y2に代入するための変数(無くてもよい)

    for k = 0:length(h)-1  % システムの大きさだけ繰り返し

        %mscの要素数をオーバーしないための条件
        if (n-k) > 0 && (n-k) <= length(msc)
            d = d + (msc(n-k)*h(k+1)); % 畳み込みの計算
        end

    end
    y2(n) = d; % 計算結果を代入
end

%要素数はすでに定義しているため転置不要
y_err = norm(y-y2) % 誤差の計算

% 出力結果　y_err = 4.3156e-15

