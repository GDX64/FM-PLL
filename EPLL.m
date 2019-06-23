function [A,w,fi,y,e] = EPLL(u,MI,Ts,f0)

    A=zeros(1,length(u));
    A(1)=1;
    fi=zeros(1,length(u));
    w=zeros(1,length(u));
    w(1)=f0*2*pi;
    e=zeros(1,length(u));

    for i=1:length(u)-1
    e(i)=u(i)-A(i)*sin(fi(i));

    A(i+1)=A(i)+MI(1)*Ts*e(i)*sin(fi(i));
    w(i+1)=w(i)+MI(2)*Ts*e(i)*cos(fi(i));
    fi(i+1)=fi(i)+Ts*w(i)+MI(3)*Ts*e(i)*cos(fi(i));


    end
    e(i+1)=u(i)-A(i)*sin(fi(i));
    
    y=sin(fi).*A;
end