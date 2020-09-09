%establish the antisymetric matrix of a vector
function mat = mrot(v)
x=v(1);
y=v(2);
z=v(3);
mat=[0 -z y;
     z 0 -x;
     -y x 0];
end