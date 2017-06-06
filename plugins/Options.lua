
local Realm =  Realm -- put Your Realm Group Id here!
--[[ 
Ye Gp Mizni
 Botto Add Mikoni Toosh 
 Id Gpio Migiri Mizri Inja
 Age Bott Jayie Add Bshe Va Charge Bshe Ya Chargesh Tamoom Bshe
 To Gp Mige :| 
 ]]

function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

local function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end

local function index_function(user_id)
  for k,v in pairs(_config.admins) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end

local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

local function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

local function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end

local function sudolist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = "*List of sudo users :*\n"
   else
 text = "_لیست سودو های ربات :_\n"
  end
for i=1,#sudo_users do
    text = text..i.." - "..sudo_users[i].."\n"
end
return text
end

local function adminlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '*List of bot admins :*\n'
   else
 text = "_لیست ادمین های ربات :_\n"
  end
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..'- '..(user[2] or '')..' ➣ ('..user[1]..')\n'
		  	i = i +1
		  	end
		  	if compare == text then
   if not lang then
		  		text = '*No* `admins` *available*'
      else
		  		text = '_ادمینی برای ربات تعیین نشده_'
           end
		  	end
		  	return text
    end

local function chat_list(msg)
	i = 1
	local data = load_data(_config.moderation.data)
    local groups = 'groups'
    if not data[tostring(groups)] then
        return 'No groups at the moment'
    end
    local message = 'List of Groups:\n*Use #join (ID) to join*\n\n'
    for k,v in pairsByKeys(data[tostring(groups)]) do
		local group_id = v
		if data[tostring(group_id)] then
			settings = data[tostring(group_id)]['settings']
		end
        for m,n in pairsByKeys(settings) do
			if m == 'set_name' then
				name = n:gsub("", "")
				chat_name = name:gsub("‮", "")
				group_name_id = name .. '\n(ID: ' ..group_id.. ')\n\n'
				if name:match("[\216-\219][\128-\191]") then
					group_info = i..' - \n'..group_name_id
				else
					group_info = i..' - '..group_name_id
				end
				i = i + 1
			end
        end
		message = message..group_info
    end
	return message
end

local function botrem(msg)
	local data = load_data(_config.moderation.data)
	data[tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	local groups = 'groups'
	if not data[tostring(groups)] then
		data[tostring(groups)] = nil
		save_data(_config.moderation.data, data)
	end
	data[tostring(groups)][tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	if redis:get('CheckExpire::'..msg.to.id) then
		redis:del('CheckExpire::'..msg.to.id)
	end
	if redis:get('ExpireDate:'..msg.to.id) then
		redis:del('ExpireDate:'..msg.to.id)
	end
	tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end

local function warning(msg)
	local hash = "gp_lang:"..msg.to.id
	local lang = redis:get(hash)
	local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
	if expiretime == -1 then
		return
	else
	local d = math.floor(expiretime / 86400) + 1
        if tonumber(d) == 1 and not is_sudo(msg) and is_owner(msg) then
			if lang then
				tdcli.sendMessage(msg.to.id, 0, 1, 'از شارژ گروه 1 روز باقی مانده، برای شارژ مجدد با سودو ربات تماس بگیرید وگرنه با اتمام زمان شارژ، گروه از لیست ربات حذف وربات گروه را ترک خواهد کرد. '..Segreto..'', 1, 'md')
			else
				tdcli.sendMessage(msg.to.id, 0, 1, '*Group* `1` *day remaining charge, to recharge the robot contact with the* `sudo`.\n *With the completion of charging time, the group* `removed` *from the robot list and the robot will* `leave` *the group.* '..Segreto..'', 1, 'md')
			end
		end
	end
end

local function action_by_reply(arg, data)
    local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
    if cmd == "adminprom" then
local function adminprom_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already an* `admin` "..Segreto.."", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل ادمین ربات بود_ "..Segreto.."", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been promoted as* `admin` "..Segreto.."", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _به مقام ادمین ربات منتصب شد_ "..Segreto.."", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, adminprom_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "admindem" then
local function admindem_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
	local nameid = index_function(tonumber(data.id_))
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `admin` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل ادمین ربات نبود_ "..Segreto.."", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been demoted from* `admin` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از مقام ادمین ربات برکنار شد_ "..Segreto.."", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, admindem_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "visudo" then
local function visudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل سودو ربات بود_ "..Segreto.."", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now* `sudoer` "..Segreto.."", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _به مقام سودو ربات منتصب شد_ "..Segreto.."", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "desudo" then
local function desudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل سودو ربات نبود_ "..Segreto.."", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is no longer a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از مقام سودو ربات برکنار شد_ "..Segreto.."", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_کاربر یافت نشد_ "..Segreto.."", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*Error* `404`\n*User Not Found* "..Segreto.."", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already an* `admin` "..Segreto.."", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل ادمین ربات بود_ "..Segreto.."", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been promoted as* `admin` "..Segreto.."", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _به مقام ادمین ربات منتصب شد_ "..Segreto.."", 0, "md")
   end
end
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `admin` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل ادمین ربات نبود_ "..Segreto.."", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been demoted from* `admin` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از مقام ادمین ربات برکنار شد_ "..Segreto.."", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل سودو ربات بود_ "..Segreto.."", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now* `sudoer` "..Segreto.."", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _به مقام سودو ربات منتصب شد_ "..Segreto.."", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل سودو ربات نبود_ "..Segreto.."", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is no longer a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از مقام سودو ربات برکنار شد_ "..Segreto.."", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_ "..Segreto.."", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*Error* `404`\n*User Not Found* "..Segreto.."", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already an* `admin` "..Segreto.."", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل ادمین ربات بود_ "..Segreto.."", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been promoted as* `admin` "..Segreto.."", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _به مقام ادمین ربات منتصب شد_ "..Segreto.."", 0, "md")
   end
end 
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `admin` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل ادمین ربات نبود_ "..Segreto.."", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been demoted from* `admin` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از مقام ادمین ربات برکنار شد_ "..Segreto.."", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل سودو ربات بود_ "..Segreto.."", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now* `sudoer` "..Segreto.."", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _به مقام سودو ربات منتصب شد_ "..Segreto.."", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از قبل سودو ربات نبود_ "..Segreto.."", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is no longer a* `sudoer` "..Segreto.."", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* _از مقام سودو ربات برکنار شد_ "..Segreto.."", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_ "..Segreto.."", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*Error* `404`\n*User Not Found* "..Segreto.."", 0, "md")
      end
   end
end

local function pre_process(msg)
	if msg.to.type ~= 'pv' then
		local hash = "gp_lang:"..msg.to.id
		local lang = redis:get(hash)
		local data = load_data(_config.moderation.data)
		local gpst = data[tostring(msg.to.id)]
		local chex = redis:get('CheckExpire::'..msg.to.id)
		local exd = redis:get('ExpireDate:'..msg.to.id)
		if gpst and not chex and msg.from.id ~= SUDO and not is_sudo(msg) then
			redis:set('CheckExpire::'..msg.to.id,true)
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 86400, true)
			if lang then
				tdcli.sendMessage(msg.to.id, msg.id_, 1, '_گروه به مدت 1 روز شارژ شد. لطفا با سودو برای شارژ بیشتر تماس بگیرید. در غیر اینصورت گروه شما از لیست ربات حذف و ربات گروه را ترک خواهد کرد._ '..Segreto..'', 1, 'md')
			else
				tdcli.sendMessage(msg.to.id, 0, 1, '*Group charged for* `1` *day, to recharge the robot contact with the* `sudo`.\n *With the completion of charging time, the group* `removed` *from the robot list and the robot will* `leave` *the group.* '..Segreto..'', 1, 'md')
			end
		end
		if chex and not exd and msg.from.id ~= SUDO and not is_sudo(msg) then
			local text1 = '*Charging finished.*\n\n'
			..'*Group Info:*\n'
			..'*ID:* `'..msg.to.id..'`\n'
			..'*Name:* `'..msg.to.title..'`\n\n'
			..'*If you want the robot to leave this group use the following command:*\n'
			..'`/Leave '..msg.to.id..'`\n\n'
			..'*For Join to this group, you can use the following command:*\n'
			..'`/Jointo '..msg.to.id..'`\n'
			..'*--------------------*\n'
			..'*If you want to recharge the group can use the following code:*\n\n'
			..'*To charge 1 month:*\n'
			..'`/Plan 1 '..msg.to.id..'`\n\n'
			..'*To charge 3 months:*\n'
			..'`/Plan 2 '..msg.to.id..'`\n\n'
			..'*For unlimited charge:*\n'
			..'`/Plan 3 '..msg.to.id..'`'
			local text2 = '_شارژ این گروه به پایان رسید. به دلیل عدم شارژ مجدد، گروه از لیست ربات حذف و ربات از گروه خارج میشود._'
			local text3 = '*Charging finished.*\n\n'
			..'*Group Info:*\n'
			..'*ID:* `'..msg.to.id..'`\n'
			..'*Name:* `'..msg.to.title..'`\n\n'
			..'*If you want the robot to leave this group use the following command:*\n'
			..'`/Leave '..msg.to.id..'`\n\n'
			..'*For Join to this group, you can use the following command:*\n'
			..'`/Jointo '..msg.to.id..'`\n'
			..'*--------------------*\n'
			..'*If you want to recharge the group can use the following code:*\n\n'
			..'*To charge 1 month:*\n'
			..'`/Plan 1 '..msg.to.id..'`\n\n'
			..'*To charge 3 months:*\n'
			..'`/Plan 2 '..msg.to.id..'`\n\n'
			..'*For unlimited charge:*\n'
			..'`/Plan 3 '..msg.to.id..'`'
			local text4 = '*Charging finished.*\n*I leave from this group !'
			if lang then
				tdcli.sendMessage(Realm, 0, 1, text1, 1, 'md')
				tdcli.sendMessage(msg.to.id, 0, 1, text2, 1, 'md')
			else
				tdcli.sendMessage(Realm, 0, 1, text3, 1, 'md')
				tdcli.sendMessage(msg.to.id, 0, 1, text4, 1, 'md')
			end
			botrem(msg)
		else
			local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
			local day = (expiretime / 86400)
			if tonumber(day) > 0.208 and not is_sudo(msg) and is_mod(msg) then
				warning(msg)
			end
		end
	end
	return msg
end

local function run(msg, matches)
if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end


local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if tonumber(msg.from.id) == SUDO then
if matches[1] == "clear cache" and is_sudo(msg) then
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
    return "*All Cache Has Been Cleared*"
   end
if (matches[1] == "visudo" or matches[1] == "سودو") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="visudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="visudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="visudo"})
      end
   end
if (matches[1] == "desudo" or matches[1] == "حذف سودو") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="desudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="desudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="desudo"})
      end
   end
end
if is_sudo(msg) then
   		if (matches[1]:lower() == 'add' or matches[1] == 'افزودن') and not matches[2] and not redis:get('ExpireDate:'..msg.to.id) and is_admin(msg) then
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 86400, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				local adder = '*New Group Added !*\n\n'
			..'*Group Info:*\n'
			..'*ID:* `'..msg.to.id..'`\n'
			..'*Name:* `'..msg.to.title..'`\n\n'
			..'*Adder Name:* '..msg.from.first_name..'\n'
			..'*Adder Username:* @'..msg.from.username..'\n\n'
			..'*If you want the robot to leave this group use the following command:*\n'
			..'`/Leave '..msg.to.id..'`\n\n'
			..'*For Join to this group, you can use the following command:*\n'
			..'`/Jointo '..msg.to.id..'`\n'
			..'*--------------------*\n'
			..'*If you want to charge the group can use the following code:*\n\n'
			..'*To charge 1 month:*\n'
			..'`/Plan 1 '..msg.to.id..'`\n\n'
			..'*To charge 3 months:*\n'
			..'`/Plan 2 '..msg.to.id..'`\n\n'
			..'*For unlimited charge:*\n'
			..'`/Plan 3 '..msg.to.id..'`'
					tdcli.sendMessage(Realm, msg.id_, 1, adder, 1, 'md')
		end
		if (matches[1]:lower() == 'rem' or matches[1] == 'حذف گروه') and not matches[2] and is_admin(msg) then
			if redis:get('CheckExpire::'..msg.to.id) then
				redis:del('CheckExpire::'..msg.to.id)
			end
			redis:del('ExpireDate:'..msg.to.id)
		end
		if (matches[1]:lower() == 'gid' or matches[1] == 'اطلاعات') and is_admin(msg) then
			tdcli.sendMessage(msg.to.id, msg.id_, 1, '`'..msg.to.id..'`', 1,'md')
		end
		if (matches[1] == 'leave' or matches[1] == 'خروج') and matches[2] and is_admin(msg) then
			if lang then
				tdcli.sendMessage(matches[2], 0, 1, 'ربات با دستور سودو از گروه خارج شد.\nبرای اطلاعات بیشتر با سودو تماس بگیرید.', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(Realm, msg.id_, 1, 'ربات با موفقیت از گروه '..matches[2]..' خارج شد.', 1,'md')
			else
				tdcli.sendMessage(matches[2], 0, 1, '*Robot left the group.*\n*For more information contact with @PrswShrr.*', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(Realm, msg.id_, 1, '*Robot left from under group successfully:*\n\n`'..matches[2]..'`', 1,'md')
			end
		end
		if (matches[1]:lower() == 'charge' or matches[1] == "شارژ") and matches[2] and matches[3] and is_admin(msg) then
		if string.match(matches[2], '^-%d+$') then
			if tonumber(matches[3]) > 0 and tonumber(matches[3]) < 1001 then
				local extime = (tonumber(matches[3]) * 86400)
				redis:setex('ExpireDate:'..matches[2], extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				if lang then
					tdcli.sendMessage(Realm, 0, 1, 'ربات در گروه '..matches[2]..' به مدت '..matches[3]..' روز تمدید گردید.', 1, 'md')
					tdcli.sendMessage(matches[2], 0, 1, 'ربات توسط ادمین به مدت `'..matches[3]..'` روز شارژ شد\nبرای مشاهده زمان شارژ گروه دستور /check استفاده کنید...',1 , 'md')
				else
					tdcli.sendMessage(Realm, 0, 1, '*Recharged successfully in the group:* `'..matches[2]..'`\n_Expire Date:_ `'..matches[3]..'` *Day(s)*', 1, 'md')
					tdcli.sendMessage(matches[2], 0, 1, '*Robot recharged* `'..matches[3]..'` *day(s)*\n*For checking expire date, send* `/check`',1 , 'md')
				end
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_تعداد روزها باید عددی از 1 تا 1000 باشد._', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Expire days must be between 1 - 1000_', 1, 'md')
				end
			end
		end
		end
		if matches[1]:lower() == 'plan' or matches[1] == 'پلن' then
		if matches[2] == '1' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^-%d+$') then
			local timeplan1 = 2592000
			redis:setex('ExpireDate:'..matches[3], timeplan1, true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(Realm, msg.id_, 1, 'پلن 1 با موفقیت برای گروه '..matches[3]..' فعال شد\nاین گروه تا 30 روز دیگر اعتبار دارد! ( 1 ماه )', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '_ربات با موفقیت فعال شد و تا 30 روز دیگر اعتبار دارد!_', 1, 'md')
			else
				tdcli.sendMessage(Realm, msg.id_, 1, '*Plan 1 Successfully Activated!\nThis group recharged with plan 1 for 30 days (1 Month)*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `30` *Days (1 Month)*', 1, 'md')
			end
		end
		end
		if matches[2] == '2' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^-%d+$') then
			local timeplan2 = 7776000
			redis:setex('ExpireDate:'..matches[3],timeplan2,true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(Realm, 0, 1, 'پلن 2 با موفقیت برای گروه '..matches[3]..' فعال شد\nاین گروه تا 90 روز دیگر اعتبار دارد! ( 3 ماه )', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, 'ربات با موفقیت فعال شد و تا 90 روز دیگر اعتبار دارد! ( 3 ماه )', 1, 'md')
			else
				tdcli.sendMessage(Realm, msg.id_, 1, '*Plan 2 Successfully Activated!\nThis group recharged with plan 2 for 90 days (3 Month)*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `90` *Days (3 Months)*', 1, 'md')
			end
		end
		end
		if matches[2] == '3' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^-%d+$') then
			redis:set('ExpireDate:'..matches[3],true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(Realm, msg.id_, 1, 'پلن 3 با موفقیت برای گروه '..matches[3]..' فعال شد\nاین گروه به صورت نامحدود شارژ شد!', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, 'ربات بدون محدودیت فعال شد ! ( نامحدود )', 1, 'md')
			else
				tdcli.sendMessage(Realm, msg.id_, 1, '*Plan 3 Successfully Activated!\nThis group recharged with plan 3 for unlimited*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `Unlimited`', 1, 'md')
			end
		end
		end
		end
		if (matches[1]:lower() == 'jointo' or matches[1] == 'ورود به') and matches[2] and is_admin(msg) then
		if string.match(matches[2], '^-%d+$') then
			if lang then
				tdcli.sendMessage(Realm, msg.id_, 1, 'با موفقیت تورو به گروه '..matches[2]..' اضافه کردم.', 1, 'md')
				tdcli.addChatMember(matches[2], msg.from.id, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, '_سودو به گروه اضافه شد._', 1, 'md')
			else
				tdcli.sendMessage(Realm, msg.id_, 1, '*I added you to this group:*\n\n`'..matches[2]..'`', 1, 'md')
				tdcli.addChatMember(matches[2], msg.from.id, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, 'Admin Joined!', 1, 'md')
			end
		end
		end
end

	if msg.to.type == 'channel' or msg.to.type == 'chat' then
		if (matches[1] == 'charge' or matches[1] == 'شارژ') and matches[2] and not matches[3] and is_sudo(msg) then
			if tonumber(matches[2]) > 0 and tonumber(matches[2]) < 1001 then
				local extime = (tonumber(matches[2]) * 86400)
				redis:setex('ExpireDate:'..msg.to.id, extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id)
				end
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '*Group Charged For* `'..matches[2]..'` *Day[s]*', 1, 'md')
					tdcli.sendMessage(Realm, 0, 1, '*Group ID:* '..msg.to.id..'\n*Group Name:* '..msg.to.title..'\n*Charged For:* `'..matches[2]..'`', 1, 'md')
					else 
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '*Group Charged For* `'..matches[2]..'` *Day[s]*', 1, 'md')
					tdcli.sendMessage(Realm, 0, 1, '*Group ID:* '..msg.to.id..'\n*Group Name:* '..msg.to.title..'\n*Charged For:* `'..matches[2]..'`', 1, 'md')
				end
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_تعداد روزها باید عددی از 1 تا 1000 باشد._', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '*Expire days must be between 1 - 1000*', 1, 'md')
				end
			end
		end
		if (matches[1]:lower() == 'check' or matches[1] == 'اعتبار') and is_mod(msg) and not matches[2] and is_owner(msg) then
			local expi = redis:ttl('ExpireDate:'..msg.to.id)
			if expi == -1 then
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_گروه به صورت نامحدود شارژ میباشد!_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '*Unlimited Charging!*', 1, 'md')
				end
			else
				local day = math.floor(expi / 86400) + 1
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, day..' روز تا اتما شارژ گروه باقی مانده است.', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '`'..day..'` *Day(s) remaining until Expire.*', 1, 'md')
				end
			end
		end
		end
		if (matches[1] == 'check' or matches[1] == 'اعتبار') and is_mod(msg) and matches[2] and is_admin(msg) then
		if string.match(matches[2], '^-%d+$') then
			local expi = redis:ttl('ExpireDate:'..matches[2])
			if expi == -1 then
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_گروه به صورت نامحدود شارژ میباشد!_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '*Unlimited Charging!*', 1, 'md')
				end
			else
				local day = math.floor(expi / 86400 ) + 1
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, day..' روز تا اتما شارژ گروه باقی مانده است.', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '`'..day..'` *Day(s) remaining until Expire.*', 1, 'md')
				end
			end
		end
	end
if (matches[1] == "adminprom" or matches[1] == "ادمین") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="adminprom"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="adminprom"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="adminprom"})
      end
   end
if (matches[1] == "admindem" or matches[1] == "حذف ادمین") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.to.id,cmd="admindem"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="admindem"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="admindem"})
      end
   end

if matches[1] == 'creategroup' or matches[1] == 'ساخت گروه' and is_admin(msg) then
local text = matches[2]
tdcli.createNewGroupChat({[0] = msg.from.id}, text, dl_cb, nil)
  if not lang then
return '_Group Has Been Created!_'
  else
return '_گروه ساخته شد!_'
   end
end

if (matches[1] == 'createsuper' or matches[1] == 'ساخت سوپر گروه') and is_admin(msg) then
local text = matches[2]
tdcli.createNewChannelChat(text, 1, '--|@SegretoTeam|--', (function(b, d) tdcli.addChatMember(d.id_, msg.from.id, 0, dl_cb, nil) end), nil)
   if not lang then 
return '_SuperGroup Has Been Created and_ [`'..msg.from.id..'`] _Joined To This SuperGroup._'
  else
return '_سوپرگروه ساخته شد و_ [`'..msg.from.id..'`] _به گروه اضافه شد._'
   end
end

if (matches[1] == 'tosuper' or matches[1] == 'تبدیل به سوپر') and is_admin(msg) then
local id = msg.to.id
tdcli.migrateGroupChatToChannelChat(id, dl_cb, nil)
  if not lang then
return '_Group Has Been Changed To SuperGroup!_'
  else
return '_گروه به سوپر گروه تبدیل شد!_'
   end
end

if (matches[1] == 'import' or matches[1] == 'ورود لینک') and is_admin(msg) then
if matches[2]:match("^([https?://w]*.?telegram.me/joinchat/.*)$") or matches[2]:match("^([https?://w]*.?t.me/joinchat/.*)$") then
local link = matches[2]
if link:match('t.me') then
link = string.gsub(link, 't.me', 'telegram.me')
end
tdcli.importChatInviteLink(link, dl_cb, nil)
   if not lang then
return '*Done!*\n*I joined via link*'
  else
return '*انجام شد!*'
  end
  end
end

if (matches[1] == 'setbotname' or matches[1] == 'تغییر نام ربات') and is_sudo(msg) then
tdcli.changeName(matches[2])
   if not lang then
return '_Bot Name Changed To:_ *'..matches[2]..'*'
  else
return '_اسم ربات تغییر کرد به:_ \n*'..matches[2]..'*'
   end
end

if (matches[1] == 'setbotusername' or matches[1] == 'تغییر یوزرنیم ربات') and is_sudo(msg) then
tdcli.changeUsername(matches[2])
   if not lang then
return '_Bot Username Changed To:_ @'..matches[2]
  else
return '_یوزرنیم ربات تغییر کرد به:_ \n@'..matches[2]..''
   end
end

if (matches[1] == 'delbotusername' or matches[1] == 'حذف یوزرنیم ربات') and is_sudo(msg) then
tdcli.changeUsername('')
   if not lang then
return '*Done!*'
  else
return '*انجام شد!*'
  end
end

if (matches[1] == 'markread' or matches[1] == 'تیک دوم') and is_sudo(msg) then
if matches[2] == 'on' or matches[2] == 'فعال' then
redis:set('markread','on')
   if not lang then
return '_Markread >_ *ON*'
else
return '_تیک دوم >_ *روشن*'
   end
end
if matches[2] == 'off' or matches[2] == 'غیرفعال' then
redis:set('markread','off')
  if not lang then
return '_Markread >_ *OFF*'
   else
return '_تیک دوم >_ *خاموش*'
      end
   end
end

if (matches[1] == 'bc' or matches[1] == 'ارسال') and is_admin(msg) then
		local text = matches[2]
tdcli.sendMessage(matches[3], 0, 0, text, 0)	
end

if (matches[1] == 'broadcast' or matches[1] == 'ارسال به همه') and is_sudo(msg) then		
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
end	
end



if matches[1] == "mention" and is_mod(msg) then
            local utf8 = dofile('./libs/utf8.lua')
local id = matches[2]
local text = matches[3]
tdcli_function ({ID="SendMessage",
 chat_id_=msg.to.id,
 reply_to_message_id_=msg.id,
 disable_notification_=0,
 from_background_=1,
 reply_markup_=nil,
 input_message_content_={ID="InputMessageText",
 text_=matches[3],
 disable_web_page_preview_=1,
 clear_draft_=0,
 entities_={[0] = {ID="MessageEntityMentionName",
 offset_=0,
 length_=utf8.len(matches[3]),
 user_id_=id}}}},
 dl_cb, nil)
end


        if matches[1] == "whois" and is_mod(msg) then
		            local utf8 = dofile('./libs/utf8.lua')
            local text = 'Click Here For See The User..!'
local id = matches[2]
tdcli_function ({ID="SendMessage",
 chat_id_=msg.to.id,
 reply_to_message_id_=msg.id,
 disable_notification_=0,
 from_background_=1,
 reply_markup_=nil,
 input_message_content_={ID="InputMessageText",
 text_=text,
 disable_web_page_preview_=1,
 clear_draft_=0,
 entities_={[0] = {ID="MessageEntityMentionName",
 offset_=0,
 length_=29,
 user_id_=id}}}},
 dl_cb, nil)
      end






  if is_sudo(msg) then
	if (matches[1]:lower() == "sendfile" or matches[1] == 'ارسال فایل') and matches[2] and matches[3] then
		local send_file = "./"..matches[2].."/"..matches[3]
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, '--|@SegretoTeam|--', dl_cb, nil)
	end
	if matches[1]:lower() == "sendplug" or matches[1] == 'ارسال پلاگین' and matches[2] then
	    local plug = "./plugins/"..matches[2]..".lua"
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, plug, '--|@SegretoTeam|--', dl_cb, nil)
    end
  end

    if (matches[1]:lower() == 'save' or matches[1] == 'ذخیره پلاگین') and matches[2] and is_sudo(msg) then
        if tonumber(msg.reply_to_message_id_) ~= 0  then
            function get_filemsg(arg, data)
                function get_fileinfo(arg,data)
                    if data.content_.ID == 'MessageDocument' then
                        fileid = data.content_.document_.document_.id_
                        filename = data.content_.document_.file_name_
                        if (filename:lower():match('.lua$')) then
                            local pathf = tcpath..'/data/document/'..filename
                            if pl_exi(filename) then
                                local pfile = 'plugins/'..matches[2]..'.lua'
                                os.rename(pathf, pfile)
                                tdcli.downloadFile(fileid , dl_cb, nil)
                                tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Plugin</b> <code>'..matches[2]..'</code> <b>Has Been Saved.</b>', 1, 'html')
                            else
                                tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
                            end
                        else
                            tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file is not Plugin File._', 1, 'md')
                        end
                    else
                        return
                    end
                end
                tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
            end
	        tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
        end
    end

if (matches[1] == 'sudolist' or  matches[1] == 'لیست سودو') and is_sudo(msg) then
return sudolist(msg)
    end
if (matches[1] == 'chats' or matches[1] == 'لیست گروه ها') and is_admin(msg) then
return chat_list(msg)
    end
   if (matches[1]:lower() == 'join' or matches[1] == 'افزودن') and matches[2] and is_admin(msg) and matches[2] then
	   tdcli.sendMessage(msg.to.id, msg.id, 1, 'I Invite you in '..matches[2]..'', 1, 'html')
	   tdcli.sendMessage(matches[2], 0, 1, "Admin Joined!🌚", 1, 'html')
    tdcli.addChatMember(matches[2], msg.from.id, 0, dl_cb, nil)
  end
  
    if matches[1] == 'ping' or matches[1] == 'پینگ' then    
  tdcli.sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './segreto.gif', 'Segreto Is Online..!\n\n--|@SegretoTeam|--', dl_cb, nil)
end

		if (matches[1] == 'rem' or matches[1] == 'حذف گروه') and matches[2] and is_admin(msg) then
    local data = load_data(_config.moderation.data)
			-- Group configuration removal
			data[tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = nil
				save_data(_config.moderation.data, data)
			end
			data[tostring(groups)][tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
	   tdcli.sendMessage(matches[2], 0, 1, "Group has been removed by admin command", 1, 'html')
    return '_Group_ *'..matches[2]..'* _removed_'
		end
if matches[1] == 'segreto' or matches[1] == 'سگرتو' then
return tdcli.sendMessage(msg.to.id, msg.id, 1, _config.info_text, 1, 'md')
    end
if (matches[1] == 'adminlist' or matches[1] == 'لیست ادمین') and is_admin(msg) then
return adminlist(msg)
    end
     if (matches[1] == 'left' or matches[1] == 'خروج') and is_admin(msg) then
  tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
  	   tdcli.sendMessage(msg.to.id, 0, 1, "*Done !*\n`Leave` *Command recived!*\n*I Leave Group*", 1, 'md')
   end
   
     if (matches[1] == 'autoleave' or matches[1] == 'خروج خودکار') and is_admin(msg) then
local hash = 'auto_leave_bot'
--Enable Auto Leave
     if matches[2] == 'enable' or matches[2] == 'فعال' then
    redis:del(hash)
   return 'Auto leave has been enabled'
--Disable Auto Leave
     elseif matches[2] == 'disable' or matches[2] == 'غیرفعال' then
    redis:set(hash, true)
   return 'Auto leave has been disabled'
--Auto Leave Status
      elseif matches[2] == 'status' or  matches[2] == 'موقعیت' then
      if not redis:get(hash) then
   return 'Auto leave is enable'
       else
   return 'Auto leave is disable'
         end
      end
   end


if (matches[1] == "helptools" or  matches[1] == "راهنما ابزار") and is_mod(msg) then
if not lang then
text = [[

_Sudoer And Admins Bot Help :_

*!visudo* `[username|id|reply]`
_Add Sudo_

*!desudo* `[username|id|reply]`
_Demote Sudo_

*!sudolist *
_Sudo(s) list_

*!adminprom* `[username|id|reply]`
_Add admin for bot_

*!admindem* `[username|id|reply]`
_Demote bot admin_

*!adminlist *
_Admin(s) list_

*!leave *
_Leave current group_

*!autoleave* `[disable/enable]`
_Automatically leaves group_

*!creategroup* `[text]`
_Create normal group_

*!createsuper* `[text]`
_Create supergroup_

*!tosuper *
_Convert to supergroup_

*!chats*
_List of added groups_

*!join* `[id]`
_Adds you to the group_

*!rem* `[id]`
_Remove a group from Database_

*!import* `[link]`
_Bot joins via link_

*!setbotname* `[text]`
_Change bot's name_

*!setbotusername* `[text]`
_Change bot's username_

*!delbotusername *
_Delete bot's username_

*!markread* `[off/on]`
_Second mark_

*!broadcast* `[text]`
_Send message to all added groups_

*!bc* `[text] [gpid]`
_Send message to a specific group_

*!sendfile* `[folder] [file]`
_Send file from folder_

*!sendplug* `[plug]`
_Send plugin_

*!del* `[Reply]`
_Remove message Person you are_

*!save* `[plugin name] [reply]`
_Save plugin by reply_

*!savefile* `[address/filename] [reply]`
_Save File by reply to specific folder_

*!clear cache*
_Clear All Cache Of .telegram-cli/data_

*!check*
_Stated Expiration Date_

*!check* `[GroupID]`
_Stated Expiration Date Of Specific Group_

*!charge* `[GroupID]` `[Number Of Days]`
_Set Expire Time For Specific Group_

*!charge* `[Number Of Days]`
_Set Expire Time For Group_

*!jointo* `[GroupID]`
_Invite You To Specific Group_

*!leave* `[GroupID]`
_Leave Bot From Specific Group_

_You can use_ *[!/#]* _at the beginning of commands._

`This help is only for sudoers/bot admins.`
 
*This means only the sudoers and its bot admins can use mentioned commands.*

*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
_راهنمای ادمین و سودو های ربات _

*سودو* `[username|id|reply]`
_اضافه کردن سودو_

*حذف سودو* `[username|id|reply]`
_حذف کردن سودو_

*لیست سودو* 
_لیست سودو‌های ربات_

*ادمین* `[username|id|reply]`
_اضافه کردن ادمین به ربات_

*حذف ادمین* `[username|id|reply]`
_حذف فرد از ادمینی ربات_

*لیست ادمین* 
_لیست ادمین ها_

*خروج* 
_خارج شدن ربات از گروه_

*خروج خودکار* `[غیرفعال/فعال | موقعیت]`
_خروج خودکار_

*ساخت گروه* `[اسم انتخابی]`
_ساخت گروه ریلم_

*ساخت سوپر گروه* `[اسم انتخابی]`
_ساخت سوپر گروه_

*تبدیل به سوپر* 
_تبدیل به سوپر گروه_

*لیست گروه ها*
_لیست گروه های مدیریتی ربات_

*افزودن* `[ایدی گروه]`
_جوین شدن توسط ربات_

*حذف گروه* `[ایدی گروه]`
_حذف گروه ازطریق پنل مدیریتی_

*ورود لینک* `[لینک_]`
_جوین شدن ربات توسط لینک_

*تغییر نام ربات* `[text]`
_تغییر اسم ربات_

*تغییر یوزرنیم ربات* `[text]`
_تغییر یوزرنیم ربات_

*حذف یوزرنیم ربات* 
_پاک کردن یوزرنیم ربات_

*تیک دوم* `[فعال/غیرفعال]`
_تیک دوم_

*ارسال به همه* `[متن]`
_فرستادن پیام به تمام گروه های مدیریتی ربات_

*ارسال* `[متن]` `[ایدی گروه]`
_ارسال پیام مورد نظر به گروه خاص_

*ارسال فایل* `[cd]` `[file]`
_ارسال فایل موردنظر از پوشه خاص_

*ارسال پلاگین* `[اسم پلاگین]`
_ارسال پلاگ مورد نظر_

* ذخیره پلاگین* `[اسم پلاگین] [reply]`
_ذخیره کردن پلاگین_

*ذخیره فایل* `[address/filename] [reply]`
_ذخیره کردن فایل در پوشه مورد نظر_

*پاک کردن حافظه*
_پاک کردن کش مسیر .telegram-cli/data_

*اعتبار*
_اعلام تاریخ انقضای گروه_

*اعتبار* `[ایدی گروه]`
_اعلام تاریخ انقضای گروه مورد نظر_

*شارژ* `[ایدی گروه]` `[تعداد روز]`
_تنظیم تاریخ انقضای گروه مورد نظر_

*شارژ* `[تعداد روز]`
_تنظیم تاریخ انقضای گروه_

*ورود به* `[ایدی گروه]`
_دعوت شدن شما توسط ربات به گروه مورد نظر_

*خروج* `[ایدی گروه]`
_خارج شدن ربات از گروه مورد نظر_

*شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید*

_این راهنما فقط برای سودو ها/ادمین های ربات میباشد!_

`این به این معناست که فقط سودو ها/ادمین های ربات میتوانند از دستورات بالا استفاده کنند!`

*موفق باشید ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
end
return { 
patterns = {                                                                   
command .. "([Hh]elptools)$", 
command .. "([Vv]isudo)$", 
command .. "([Dd]esudo)$",
command .. "([Ss]udolist)$",
command .. "([Vv]isudo) (.*)$", 
command .. "([Dd]esudo) (.*)$",
command .. "([Aa]dminprom)$", 
command .. "([Aa]dmindem)$",
command .. "([Aa]dminlist)$",
command .. "([Aa]dminprom) (.*)$", 
command .. "([Aa]dmindem) (.*)$",
command .. "([Ll]eft)$",
command .. "([Aa]utoleave) (.*)$", 
command .. "([Ss]egreto)$",
command .. "([Cc]reategroup) (.*)$",
command .. "([Cc]reatesuper) (.*)$",
command .. "([Tt]osuper)$",
command .. "([Cc]hats)$",
command .. "([Cc]lear cache)$",
command .. "([Jj]oin) (-%d+)$",
command .. "([Rr]em) (-%d+)$",
command .. "([Ii]mport) (.*)$",
command .. "([Ss]etbotname) (.*)$",
command .. "([Ss]etbotusername) (.*)$",
command .. "([Dd]elbotusername) (.*)$",
command .. "([Mm]arkread) (.*)$",
command .. "([Bb]c) +(.*) (-%d+)$",
command .. "([Bb]roadcast) (.*)$",
command .. "([Aa]dd)$",
command .. "([Gg]id)$",
command .. "([Cc]heck)$",
command .. "([Cc]heck) (-%d+)$",
command .. "([Cc]harge) (-%d+) (%d+)$",
command .. "([Cc]harge) (%d+)$",
command .. "([Jj]ointo) (-%d+)$",
command .. "([Ll]eave) (-%d+)$",
command .. "([Pp]lan) ([123]) (-%d+)$",
command .. "([Rr]em)$",
command .. "([Pp]ing)$",
command .. "(mention) (.*) (.*)$",
command .. "([Ww]hois) (.*)$",
"^(mention) (.*) (.*)$",
"^([Ww]hois) (.*)$",
"^([Pp]ing)$",
 "^([Hh]elptools)$", 
 "^([Vv]isudo)$", 
 "^([Dd]esudo)$",
 "^([Ss]udolist)$",
 "^([Vv]isudo) (.*)$", 
 "^([Dd]esudo) (.*)$",
 "^([Aa]dminprom)$", 
 "^([Aa]dmindem)$",
 "^([Aa]dminlist)$",
 "^([Aa]dminprom) (.*)$", 
 "^([Aa]dmindem) (.*)$",
 "^([Ll]eft)$",
 "^([Aa]utoleave) (.*)$", 
 "^([Ss]egreto)$",
 "^([Cc]reategroup) (.*)$",
 "^([Cc]reatesuper) (.*)$",
 "^([Tt]osuper)$",
 "^([Cc]hats)$",
 "^([Cc]lear cache)$",
 "^([Jj]oin) (-%d+)$",
 "^([Rr]em) (-%d+)$",
 "^([Ii]mport) (.*)$",
 "^([Ss]etbotname) (.*)$",
 "^([Ss]etbotusername) (.*)$",
 "^([Dd]elbotusername) (.*)$",
 "^([Mm]arkread) (.*)$",
 "^([Bb]c) +(.*) (-%d+)$",
 "^([Bb]roadcast) (.*)$",
 "^([Aa]dd)$",
 "^([Gg]id)$",
 "^([Cc]heck)$",
 "^([Cc]heck) (-%d+)$",
 "^([Cc]harge) (-%d+) (%d+)$",
 "^([Cc]harge) (%d+)$",
 "^([Jj]ointo) (-%d+)$",
 "^([Ll]eave) (-%d+)$",
 "^([Pp]lan) ([123]) (-%d+)$",
 "^([Rr]em)$",
 "^([Ss]tats)$",
 "^([Rr]eset)$",
}, 
patterns_fa = {
	"^(افزودن)$",
	"^(حذف گروه)$",
    "^(حذف گروه) (-%d+)$",	
    "^(راهنما ابزار)$",
	"^(لیست سودو)$",
	"^(اطلاعات)$",
	"^(ساخت گروه) (.*)$",
	"^(ورود به) (-%d+)$",
	"^(ساخت گروه) (.*)$",
	"^(ساخت سوپر گروه) (.*)$",
	"^(ذخیره فایل) (.*)$",
	"^(سودو)$",
	"^(سودو) (.*)$",	
	"^(حذف سودو)$",
	"^(حذف سودو) (.*)$",	
	"^(ادمین)$",
		"^(پینگ)$",
	"^(حذف ادمین)$",
	"^(حذف ادمین) (.*)$",
	"^(ارسال فایل) (.*)$",
	"^(حذف یوزرنیم ربات) (.*)$",
    "^(تغییر یوزرنیم ربات) (.*)$",
	"^(تغییر نام ربات) (.*)$",
	"^(تبدیل به سوپر)$",
	"^(ارسال به همه) (.*)$",
	"^(لیست گروه ها)$",
	"^(خروج)$",
	"^(خروج) (-%d+)$",	
	"^(لیست ادمین)$",
	"^(خروج خودکار) (.*)$",
    "^(شارژ) (-%d+) (%d+)$",
    "^(شارژ) (%d+)$",	
    "^(پلن) ([123]) (-%d+)$",
    "^(اعتبار)$",
    "^(اعتبار) (-%d+)$",
    "^(تیک دوم) (.*)$",
	"^(پاک کردن حافظه)$",
	"^(سگرتو)$",
},
run = run, 
pre_process = pre_process
}