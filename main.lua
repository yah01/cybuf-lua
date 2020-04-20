-----------该文件主要用于测试---------------

require("encode")
--require("decode")

a={1,2,3}
--print(table.insert(a,2))

function f(ff)
  local tt=ff
  if(tt=="true") then
    tt=true
  end
  
  
  return tt
end


a="true"
print(a)
--a=true
a=tonumber(a)
print(a)
a=tostring(a)..'!'
print(a)


a={}
a["cy_name"]="cy"
a["cy_age"]=21
a["cy_is_virginal"]=false
a["school"]={}
a["school"]["name"]="Wuhan University"
a["school"]["major"]={}
a["school"]["major"]["name"]="CS"
a["school"]["major"]["class"]="engineering"
--print(encode(a,0))


