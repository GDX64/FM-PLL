function out = repelem( in, fac )
    out=zeros(1,length(in)*fac);
    for i = 1:fac
        out(i:fac:end)=in;
    end
end

