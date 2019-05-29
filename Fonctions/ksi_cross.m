function mat=ksi_cross(ksi)

mat(1:3,1:3)=mrot(ksi(4:6)); mat(4:6,4:6)=mat(1:3,1:3);
mat(4:6,1:3)=mrot(ksi(1:3));

end