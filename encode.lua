-------------------encode函数主要负责将传入的table转化为CyBuf格式数据----------------

function encode(map,tab_count)
  --------------tab_count参数默认为0----------------
  if(tab_count==nil) then
    tab_count=0
  end
  --------------str为最终返回的CyBuf格式的字符串----------------
  local cybuf_str=''
  ----------计算制表符个数--------------
  for i=1,tab_count do
    cybuf_str=cybuf_str..'\t'
  end
  tab_count=tab_count+1
  cybuf_str=cybuf_str.."{\n"
  
  for i,v in pairs(map) do
    ----------计算制表符个数--------------
    for i=1,tab_count do
      cybuf_str=cybuf_str..'\t'
    end
    ----------处理非table元素-----------------
    
    if(type(v)~="table") then
      cybuf_str=cybuf_str..tostring(i)..': '
      if(type(v)=="string") then
        cybuf_str=cybuf_str..'"'..tostring(v)..'"'
      else
        cybuf_str=cybuf_str..tostring(v)
      end
      cybuf_str=cybuf_str..'\n'
      
    ----------处理table元素-----------------
    
    else
      cybuf_str=cybuf_str..tostring(i)..': \n'
      cybuf_str=cybuf_str..encode(v,tab_count)
    end
  end
  --------------------数据序列化完毕后，重新计算tab个数--------------------
  cybuf_str=cybuf_str..'\n'
  
  for i=1,tab_count-1 do
    cybuf_str=cybuf_str..'\t'
  end
  
  cybuf_str=cybuf_str..'}\n'
  
  return cybuf_str
end


