-----------该文件主要用于测试---------------

require("encode")
--require("decode")

for i=0,9 do
  if(i==4) then
    i=i+1
  end
  print(i)
end


a={}
a["cy_name"]="cy"
a["cy_age"]=21
a["cy_is_virginal"]=false
a["school"]={}
a["school"]["name"]="Wuhan University"
a["school"]["major"]={}
a["school"]["major"]["name"]="CS"
a["school"]["major"]["class"]="engineering"
print(encode(a))


