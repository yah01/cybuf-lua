-------------此文件主要用于用cybuf格式数据构造table---------------

--------------基本类型值类型判断----------------
function class_identify(val)
  local des_val=val
  if(des_val=="true") then
    des_val=true
    return des_val
  end
  if(des_val=="false") then
    des_val=false
    return des_val
  end
  if(des_val==tostring(tonumber(des_val))) then
    des_val=tonumber(des_val)
  end
  return des_val
end

-------------------decode主函数-------------------
function decode(cybuf_data)
  --[[-dasda
  sdasdasd]]--
  local data_begin=1
  local data_size=#cybuf_data
  local begin_char=cybuf_data.sub(cybuf_data,data_begin,data_begin)
  while(begin_char==' ' or begin_char=='\t' or begin_char=='\n' or begin_char=='\r') do
    data_begin=data_begin+1
    begin_char=cybuf_data.sub(cybuf_data,data_begin,data_begin)
  end
  
  if(cybuf_data.sub(cybuf_data,data_begin,data_begin)=='{') then
    data_begin=data_begin+1
    local end_char=cybuf_data.sub(cybuf_data,data_size,data_size)
    while(end_char==' ' or end_char=='\t' or end_char=='\n' or end_char=='\r') do
      data_size=data_size-1
      end_char=cybuf_data.sub(cybuf_data,data_size,data_size)
    end
    if(cybuf_data.sub(cybuf_data,data_size,data_size)=='}') then
      data_size=data_size-1
    end
  end
  
  local target_table={}
  local cur_table=target_table
  local cur_val=""
  local cur_key=""
  local cur_status=0 -----------cur_status为0表示当前读取的字符为key，否则为table
  local is_in_string=false -----------表示当前是否在一组引号内
  local is_in_colon=false -----------表示当前空格前一位是否为冒号
  local table_count=0 ----------表示当前table嵌套的层数，待完成
  
  for i=data_begin,data_size do
    local c=cybuf_data.sub(cybuf_data,i,i)
    if(i==data_size and cur_key~='') then
      cur_val=cur_val..c
      target_table[cur_key]=class_identify(cur_val)
    end
    
    if(c=='{') then
      --[[-----table型数据-----------
      local son_data='{'
      local son_ch=c
      local son_is_in_string=false
      while(son_ch~='}' or son_is_in_string) do
        i=i+1
        son_data=son_data..son_ch
        son_ch=cybuf_data.sub(cybuf_data,i,i)
      end
      son_data=son_data..'}'
      print(son_data)
      --]]--
    --  target_table[cur_key]=decode(son_data)
      --]]--
      goto continue
    end
    
    if(c=='"') then
      if(is_in_string) then
        is_in_string=false
        target_table[cur_key]=class_identify(cur_val)
        cur_key=""
        cur_val=""
        cur_status=0
      else
        is_in_string=true
      end
      goto continue
    end
    
    if(is_in_string) then
      if(cur_status==0) then
        cur_key=cur_key..c
      else
        cur_val=cur_val..c
      end
      goto continue
    end
    
    if(not is_in_string) then
      if(c==':') then
        cur_status=1
        is_in_colon=true
        goto continue
      end
      if(c==' ') then
        if(is_in_colon) then
          is_in_colon=false
          goto continue
        end
        
        if(cur_key~='') then
          target_table[cur_key]=class_identify(cur_val)
          cur_key=""
          cur_val=""
          cur_status=0
        end
        goto continue
      end
      
      if(cur_status==0) then
        cur_key=cur_key..c
      else
        cur_val=cur_val..c
      end
    end
    
    ::continue::
  end

  return target_table
end


--a='{	cy_name: "cy"	cy_age: 21	cy_is_virginal: false}'
print("------------------分割线-------------------")
a='     {       Name:"hello"Age:10   Live: true}   '
aa=decode(a)
b={}
b["aa"]=11
for i,v in pairs(aa) do
  print(i,':',v,type(v))
end
print("------------------分割线-------------------")

