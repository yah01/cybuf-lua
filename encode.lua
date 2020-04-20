-------------------encode函数主要负责将传入的table转化为CyBuf格式数据----------------

function encode(map,tab_count)
  
  if(tab_count==nil) then
    tab_count=0
  end
  
  local cybuf_str=''
  
  for i=1,tab_count do
    cybuf_str=cybuf_str..'\t'
  end
  tab_count=tab_count+1
  cybuf_str=cybuf_str.."{\n"
  
  for i,v in pairs(map) do
    
    for i=1,tab_count do
      cybuf_str=cybuf_str..'\t'
    end
    
    if(type(v)~="table") then
      cybuf_str=cybuf_str..tostring(i)..': '
      if(type(v)=="string") then
        cybuf_str=cybuf_str..'"'..tostring(v)..'"'
      else
        cybuf_str=cybuf_str..tostring(v)
      end
      cybuf_str=cybuf_str..'\n'
      
    else
      cybuf_str=cybuf_str..tostring(i)..': \n'
      cybuf_str=cybuf_str..encode(v,tab_count)
    end
  end
  
  cybuf_str=cybuf_str..'\n'
  
  for i=1,tab_count-1 do
    cybuf_str=cybuf_str..'\t'
  end
  
  cybuf_str=cybuf_str..'}\n'
  
  return cybuf_str
end


