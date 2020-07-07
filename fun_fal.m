function f = fal(e,a,d)
if abs(e)>=d
    f = (abs(e))^a*sign(e);
else
    f = e*(d^(a-1));%Лђеп e/(d^(1-a))
end
