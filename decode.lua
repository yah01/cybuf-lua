function decode(cybuf_data)
  
  data_size=#cybuf_data
  target_table={}
  cur_table=target_table
  cur_val=""
  cur_key=""
  cur_status=0 -----------cur_status为0表示当前读取的字符为key，否则为table
  is_in_val=0 -----------表示当前是否在一组引号内
  is_in_colon=0 -----------表示当前空格前一位是否为冒号
  table_count=0 ----------表示当前table嵌套的层数
  
  for i=2,data_size-1 do
    c=cybuf_data.sub(cybuf_data,i,i)
    if(i==data_size-1 and cur_key~='') then
      target_table[cur_key]=cur_val
    end
    if(c=='{') then
      
    end
    
    if(c=='"') then
      if(is_in_val==1) then
        is_in_val=0
      else
        is_in_val=1
      end
      goto continue
    end
   
    if(is_in_val==1) then
      if(cur_status==0) then
        cur_key=cur_key..c
      else
        cur_val=cur_val..c
      end
      goto continue
    end
    
    if(is_in_val==0) then
      if(c==':') then
        cur_status=1
        is_in_colon=1
      end
      if(c==' ') then
        if(is_in_colon==1) then
          is_in_colon=0
          goto continue
        end
        
        if(cur_key~='') then
          target_table[cur_key]=cur_val
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
print("分割线")
a='{  cy_name: "cy"  cy_age: 21  cy_is_virginal: false    }'
aa=decode(a)
b={}
b["aa"]=11
for i,v in pairs(aa) do
  print(i,v)
end
print("分割线")

