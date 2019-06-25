function out = decan( in, fac )
    out=zeros(1,length(in)/fac);
    for i = 1:fac
        out=out+in(i:fac:end);
    end
    out=out > fac/2;
end

