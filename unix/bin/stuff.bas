home

' Basic has no pointers. It is garbage collected.
' The traditional comment is "rem" but it should be fine to support ' (VB) and ! (Std BASIC)

dim i as int
dim x as real
dim c(20) : string

defint 
defstr ???

for i = 1 to 10
  print i
  gosub stuff(x,y)

  if i = 3 then
    print x
  elsif i = 4 then
    print y
  end
next

sub stuff(a,b)
  input l$
  print l$
end

