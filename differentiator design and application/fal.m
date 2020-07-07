function f = fal(x,a,delta)
if abs(x)>delta
    f = sign(x)*(abs(x)^a);
else
    f = x/(delta^(1-a));
end