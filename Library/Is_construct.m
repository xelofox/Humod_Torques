%Establish the spatial inertia matrix
function Is=Is_construct(c,m,I)

Is(1:3,1:3)=m*eye(3);
Is(1:3,4:6)=m*transpose(mrot(c)); 
Is(4:6,1:3)=m*mrot(c);
Is(4:6,4:6)=I+m*mrot(c)*transpose(mrot(c));

end