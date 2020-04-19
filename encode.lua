function marshal_table(map,tab_count)
  local str=''
  for i=1,tab_count do
    str=str..'\t'
  end
  tab_count=tab_count+1
  str=str.."{\n"
  for i,v in pairs(map) do
    ----------计算制表符个数--------------
    for i=1,tab_count do
      str=str..'\t'
    end
    ----------处理非table元素-----------------
    if(type(v)~="table") then
      str=str..tostring(i)..': '
      if(type(v)=="string") then
        str=str..'"'..tostring(v)..'"'
      else
        str=str..tostring(v)
      end
      str=str..'\n'
    ----------处理table元素-----------------
    else
      str=str..tostring(i)..': \n'
      str=str..marshal_table(v,tab_count)
    end
  end
  str=str..'\n'
  for i=1,tab_count-1 do
    str=str..'\t'
  end
  str=str..'}\n'
  return str
end


