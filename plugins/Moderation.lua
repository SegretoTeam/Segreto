local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return ''
else
     return ''
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '*Group Already Added*\n*Name:* `'..msg.to.title..'`'
else
return '*Group Already Added*\n*Name:* `'..msg.to.title..'`'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_mention = 'no',
          lock_markdown = 'no',
          lock_flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'disable',
		  lock_join = 'no',
                  lock_fwd = 'no',
                  lock_audio = 'no',
                  lock_video = 'no',
                  lock_contact = 'no',
                  lock_text = 'no',
                  lock_photos = 'no',
                  lock_gif = 'no',
                  lock_loc = 'no',
                  lock_doc = 'no',
                  lock_sticker = 'no',
                  lock_voice = 'no',
                   lock_all = 'no',
				   lock_keyboard = 'no'
          
      },
	  }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '*SuperGroup Has Been Added*\n*Name:* '..msg.to.title..'\n*Group charged For* `1` *day*\n*Please add me to admins!*'
else
  return '*SuperGroup Has Been Added*\n*Name:* '..msg.to.title..'\n*Group charged For* `1` *day*\n*Please add me to admins!*'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return ''
   else
        return ''
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '*Group Is Not Added*'
else
    return '*Group Is Not Added*'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*SuperGroup Has Been Removed*\n*Name:* '..msg.to.title..''
 else
  return '*SuperGroup Has Been Removed*\n*Name:* '..msg.to.title..''
end
end

 local function config_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
  print(serpent.block(data))
   for k,v in pairs(data.members_) do
   local function config_mods(arg, data)
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = v.user_id_
  }, config_mods, {chat_id=arg.chat_id,user_id=v.user_id_})
 
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
owner_id = v.user_id_
   local function config_owner(arg, data)
  print(serpent.block(data))
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = owner_id
  }, config_owner, {chat_id=arg.chat_id,user_id=owner_id})
   end
end
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*All Group* `Admins` *Has Been Promoted To* `Moderators` *And SuperGroup* `Creator` *Has Been Added To* `Owner List`"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_تمام ادمین های گروه به مقام مدیر منتصب شدند و سازنده گروه به مقام مالک گروه منتصب شد_"..Segreto.." ", 0, "md")
     end
 end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "*Word* *["..word.."]* *is already filtered*"
            else
         return "_کلمه_ *"..word.."* _از قبل فیلتر بود_"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "*Word* *"..word.."* *added to filtered words list*"
            else
         return "_کلمه_ *["..word.."]* _به لیست کلمات فیلتر شده اضافه شد_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "*Word* *["..word.."]* *removed from filtered words list*"
       elseif lang then
         return "_کلمه_ *"..word.."* _از لیست کلمات فیلتر شده حذف شد_"
     end
      else
       if not lang then
         return "*Word* *["..word.."]* *is not filtered*"
       elseif lang then
         return "_کلمه_ *"..word.."* _از قبل فیلتر نبود_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "*SuperGroup Is Not Added*"
 else
    return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "*No* `moderator` *in this group*"
else
   return "در حال حاضر هیچ مدیری برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "*SuperGroup Is Not Added*"
else
return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "*No* `owner` *in this group*"
else
    return "در حال حاضر هیچ مالکی برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of owners :*\n'
else
   message = '*لیست مالکین گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*superGroup Is Not Added*"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_"..Segreto.." ", 0, "md")
     end
  end
if cmd == "setmanager" then
local function manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now the* `group manager`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *ادمین گروه شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "remmanager" then
local function rem_manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]**is no longer* `group manager`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از ادمینی گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already in* `white list`"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل در لیست سفید بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been added to* `white list`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به لیست سفید اضافه شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not in* `white list`"..Segreto.." ", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل در لیست سفید نبود*"..Segreto.." ", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been removed from* `white list`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از لیست سفید حذف شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `group owner`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل صاحب گروه بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now the* `group owner`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به مقام صاحب گروه منتصب شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `moderator`"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل مدیر گروه بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been* `promoted`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به مقام مدیر گروه منتصب شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `group owner`"..Segreto.." ", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل صاحب گروه نبود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is no longer a* `group owner`"..Segreto.." ", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از مقام صاحب گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `moderator`"..Segreto.." ", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل مدیر گروه نبود*"..Segreto.." ", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been* `demoted`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از مقام مدیر گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User Id* : `"..data.id_.."`"..Segreto.." ", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_کاربر یافت نشد_"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*Error* `404`\n*User Not Found*"..Segreto.." ", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*SuperGroup Is Not Added*"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_"..Segreto.." ", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now the* `group manager`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *ادمین گروه شد*"..Segreto.." ", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]**is no longer* `group manager`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از ادمینی گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already in* `white list`"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل در لیست سفید بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been added to* `white list`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به لیست سفید اضافه شد*"..Segreto.." ", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not in* `white list`"..Segreto.." ", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل در لیست سفید نبود*"..Segreto.." ", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been removed from* `white list`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از لیست سفید حذف شد*"..Segreto.." ", 0, "md")
   end
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `group owner`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل صاحب گروه بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now the* `group owner`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به مقام صاحب گروه منتصب شد*"..Segreto.." ", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `moderator`"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل مدیر گروه بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been* `promoted`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به مقام مدیر گروه منتصب شد*"..Segreto.." ", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `group owner`"..Segreto.." ", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل صاحب گروه نبود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is no longer a* `group owner`"..Segreto.." ", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از مقام صاحب گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `moderator`"..Segreto.." ", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل مدیر گروه نبود*"..Segreto.." ", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been* `demoted`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از مقام مدیر گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User Id*: `"..data.id_.."`"..Segreto.." ", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "اطلاعات برای [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*Error* `404`\n*User Not Found*"..Segreto.." ", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*SuperGroup Is Not Added*"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_"..Segreto.." ", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now the* `group manager`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *ادمین گروه شد*"..Segreto.." ", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is no longer* `group manager`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از ادمینی گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already in* `white list`"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل در لیست سفید بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been added to* `white list`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به لیست سفید اضافه شد*"..Segreto.." ", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not in* `white list`"..Segreto.." ", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل در لیست سفید نبود*"..Segreto.." ", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been removed from* `white list`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از لیست سفید حذف شد*"..Segreto.." ", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `group owner`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل صاحب گروه بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is now the* `group owner`"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به مقام صاحب گروه منتصب شد*"..Segreto.." ", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is already a* `moderator`"..Segreto.." ", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل مدیر گروه بود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been* `promoted`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *به مقام مدیر گروه منتصب شد*"..Segreto.." ", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `group owner`"..Segreto.." ", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل صاحب گروه نبود*"..Segreto.." ", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is no longer a* `group owner`"..Segreto.." ", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از مقام صاحب گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *is not a* `moderator`"..Segreto.." ", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از قبل مدیر گروه نبود*"..Segreto.." ", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`>` *User :* *[*"..user_name.."*]* | *["..data.id_.."]* *has been* `demoted`"..Segreto.." ", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ *[*"..user_name.."*]* | *["..data.id_.."]* *از مقام مدیر گروه برکنار شد*"..Segreto.." ", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'ندارد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'اطلاعات برای [ '..data.id_..' ] :\nیوزرنیم : '..username..'\nنام : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_"..Segreto.." ", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_"..Segreto.." ", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*Error* `404`\n*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "`>` *Lock* *Link* Posting Is Already *Enable*"
elseif lang then
 return "ارسال لینک در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Link* Posting Has Been *Enable*"
else
 return "ارسال لینک در گروه ممنوع شد"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "`>` *Lock* *Link* Posting Is Not *Enable*" 
elseif lang then
return "ارسال لینک در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Link* Posting Has Been *Disable*" 
else
return "ارسال لینک در گروه آزاد شد"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "`>` *Lock* *Tag* Posting Is Already *Enable*"
elseif lang then
 return "ارسال تگ در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Tag* Posting Has Been *Enable*"
else
 return "ارسال تگ در گروه ممنوع شد"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
 return ""
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "`>` *Lock* *Tag* Posting Is Not *Enable*" 
elseif lang then
return "ارسال تگ در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Tag* Posting Has Been *Disable*" 
else
return "ارسال تگ در گروه آزاد شد"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "`>` *Lock* *Mention* Posting Is Already *Enable*"
elseif lang then
 return "ارسال فراخوانی افراد هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "`>` *Lock* *Mention* Posting Has Been *Enable*"
else 
 return "ارسال فراخوانی افراد در گروه ممنوع شد"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "`>` *Lock* *Mention* Posting Is Not *Enable*" 
elseif lang then
return "ارسال فراخوانی افراد در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Mention* Posting Has Been *Disable*" 
else
return "ارسال فراخوانی افراد در گروه آزاد شد"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "`>` *Lock* *Arabic/Persian* Posting Is Already *Enable*"
elseif lang then
 return "ارسال کلمات عربی/فارسی در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Arabic/Persian* Posting Has Been *Enable*"
else
 return "ارسال کلمات عربی/فارسی در گروه ممنوع شد"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "`>` *Lock* *Arabic/Persian* Posting Is Not *Enable*" 
elseif lang then
return "ارسال کلمات عربی/فارسی در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Arabic/Persian* Posting Has Been *Disable*" 
else
return "ارسال کلمات عربی/فارسی در گروه آزاد شد"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "`>` *Lock* *Editing* Is Already *Enable*"
elseif lang then
 return "ویرایش پیام هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Editing* Has Been *Enable*"
else
 return "ویرایش پیام در گروه ممنوع شد"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "`>` *Lock* *Editing* Is Not *Enable*" 
elseif lang then
return "ویرایش پیام در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Editing* Has Been *Disable*" 
else
return "ویرایش پیام در گروه آزاد شد"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "`>` *Lock* *Spam* Is Already *Enable*"
elseif lang then
 return "ارسال هرزنامه در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Spam* Has Been *Enable*"
else
 return "ارسال هرزنامه در گروه ممنوع شد"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "`>` *Lock* *Spam* Posting Is Not *Enable*" 
elseif lang then
 return "ارسال هرزنامه در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
return "`>` *Lock* *Spam* Posting Has Been *Disable*" 
else
 return "ارسال هرزنامه در گروه آزاد شد"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_flood = data[tostring(target)]["settings"]["lock_flood"] 
if lock_flood == "yes" then
if not lang then
 return "`>` *Lock* *Flooding* Is Already *Enable*"
elseif lang then
 return "ارسال پیام مکرر در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Flooding* Has Been *Enable*"
else
 return "ارسال پیام مکرر در گروه ممنوع شد"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_flood = data[tostring(target)]["settings"]["lock_flood"]
 if lock_flood == "no" then
if not lang then
return "`>` *Lock* *Flooding* Is Not *Enable*" 
elseif lang then
return "ارسال پیام مکرر در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Flooding* Has Been *Disable*" 
else
return "ارسال پیام مکرر در گروه آزاد شد"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "`>` *Lock* *Bots* Protection Is Already *Enabled*"
elseif lang then
 return "محافظت از گروه در برابر ربات ها هم اکنون فعال است"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Bots* Protection Has Been *Enabled*"
else
 return "محافظت از گروه در برابر ربات ها فعال شد"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "`>` *Lock* *Bots* Protection Is Not *Enabled*" 
elseif lang then
return "محافظت از گروه در برابر ربات ها غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Bots* Protection Has Been *Disabled*" 
else
return "محافظت از گروه در برابر ربات ها غیر فعال شد"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "yes" then
if not lang then
 return "`>` *Lock* *Lock Join* Is Already *Enable*"
elseif lang then
 return "ورود به گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_join"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Lock Join* Has Been *Enable*"
else
 return "ورود به گروه ممنوع شد"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "no" then
if not lang then
return "*Lock Join* Is Not *Enable*" 
elseif lang then
return "ورود به گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_join"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "*Lock Join* Has Been *Disable*" 
else
return "ورود به گروه آزاد شد"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "`>` *Lock* *Markdown* Posting Is Already *Enable*"
elseif lang then
 return "ارسال پیام های دارای فونت در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Markdown* Posting Has Been *Enable*"
else
 return "ارسال پیام های دارای فونت در گروه ممنوع شد"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "`>` *Lock* *Markdown* Posting Is Not *Enable*"
elseif lang then
return "ارسال پیام های دارای فونت در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Markdown* Posting Has Been *Disable*"
else
return "ارسال پیام های دارای فونت در گروه آزاد شد"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "`>` *Lock* *Webpage* Is Already *Enable*"
elseif lang then
 return "ارسال صفحات وب در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Webpage* Has Been *Enable*"
else
 return "ارسال صفحات وب در گروه ممنوع شد"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "`>` *Lock* *Webpage* Is Not *Enable*" 
elseif lang then
return "ارسال صفحات وب در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Webpage* Has Been *Disable*" 
else
return "ارسال صفحات وب در گروه آزاد شد"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "`>` *Lock* *Pinned Message* Is Already *Enable*"
elseif lang then
 return "سنجاق کردن پیام در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock* *Pinned Message* Has Been *Enable*"
else
 return "سنجاق کردن پیام در گروه ممنوع شد"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "`>` *Lock* *Pinned Message* Is Not *Enable*" 
elseif lang then
return "سنجاق کردن پیام در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock* *Pinned Message* Has Been *Disable*" 
else
return "سنجاق کردن پیام در گروه آزاد شد"
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return ""
else
  return ""
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "disable"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "no"		
 end
 end
 if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_gif"] then			
data[tostring(target)]["settings"]["lock_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_text"] then			
data[tostring(target)]["settings"]["lock_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_photo"] then			
data[tostring(target)]["settings"]["lock_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_video"] then			
data[tostring(target)]["settings"]["lock_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_audio"] then			
data[tostring(target)]["settings"]["lock_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_voice"] then			
data[tostring(target)]["settings"]["lock_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_sticker"] then			
data[tostring(target)]["settings"]["lock_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_contact"] then			
data[tostring(target)]["settings"]["lock_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_forward"] then			
data[tostring(target)]["settings"]["lock_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_location"] then			
data[tostring(target)]["settings"]["lock_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_document"] then			
data[tostring(target)]["settings"]["lock_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tgservice"] then			
data[tostring(target)]["settings"]["lock_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_inline"] then			
data[tostring(target)]["settings"]["lock_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_game"] then			
data[tostring(target)]["settings"]["lock_game"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_keyboard"] then			
data[tostring(target)]["settings"]["lock_keyboard"] = "no"		
end
end
local hash = "lockall:"..msg.to.id
local check_time = redis:ttl(hash)
day = math.floor(check_time / 86400)
bday = check_time % 86400
hours = math.floor( bday / 3600)
bhours = bday % 3600
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if not lang then
if not redis:get(hash) or check_time == -1 then
 lock_all1 = 'no'
elseif tonumber(check_time) > 1 and check_time < 60 then
 lock_all1 = '_enable for_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 lock_all1 = '_enable for_ '..min..' _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 lock_all1 = '_enable for_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 86400 then
 lock_all1 = '_enable for_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
 end
elseif lang then
if not redis:get(hash) or check_time == -1 then
 lock_all2 = '*no*'
elseif tonumber(check_time) > 1 and check_time < 60 then
 lock_all2 = '_فعال برای_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 lock_all2 = '_فعال برای_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 lock_all2 = '_فعال برای_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 86400 then
 lock_all2 = '_فعال برای_ *'..day..'* _روز و_ *'..hours..'* _ساعت و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
 end
end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
local cmdss = redis:hget('group:'..msg.to.id..':cmd', 'bot')
	local cmdsss = ''
	if lang then
	if cmdss == 'owner' then
	cmdsss = cmdsss..'اونر و بالاتر'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'مدیر و بالاتر'
	else
	cmdsss = cmdsss..'کاربر و بالاتر'
	end
	else
	if cmdss == 'owner' then
	cmdsss = cmdsss..'Owner or higher'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'Moderator or higher'
	else
	cmdsss = cmdsss..'Member or higher'
	end
	end
if not lang then
local settings = data[tostring(target)]["settings"] 
text = "*Group Settings For:*\n[`"..msg.to.title.."`]\n\n"
.."`>` *Links -* "..settings.lock_link.."\n"
.."`>` *Tags -* "..settings.lock_tag.."\n"
.."`>` *Join -* "..settings.lock_join.."\n"
.."`>` *Flood -* "..settings.lock_flood.."\n"
.."`>` *Spam -* "..settings.lock_spam.."\n"
.."`>` *Mention -* "..settings.lock_mention.."\n"
.."`>` *Arabic -* "..settings.lock_arabic.."\n"
.."`>` *Contact -* "..settings.lock_contact.."\n"
.."`>` *Forward -* "..settings.lock_forward.."\n"
.."`>` *Sticker -* "..settings.lock_sticker.."\n"
.."`>` *Webpage -* "..settings.lock_webpage.."\n"
.."`>` *Gif -* "..settings.lock_gif.."\n"
.."`>` *Text -* "..settings.lock_text.."\n"
.."`>` *Inline -* "..settings.lock_inline.."\n"
.."`>` *Game -* "..settings.lock_game.."\n"
.."`>` *Photo -* "..settings.lock_photo.."\n"
.."`>` *Video -* "..settings.lock_video.."\n"
.."`>` *Audio -* "..settings.lock_audio.."\n"
.."`>` *Voice -* "..settings.lock_voice.."\n"
.."`>` *Location -* "..settings.lock_location.."\n"
.."`>` *Document -* "..settings.lock_document.."\n"
.."`>` *Keyboard -* "..settings.lock_keyboard.."\n"
.."-------------------\n"
.."`>` *Pin -* "..settings.lock_pin.."\n"
.."`>` *Edit -* "..settings.lock_edit.."\n"
.."`>` *Bots Protection -* "..settings.lock_bots.."\n"
.."`>` *Flood Sensitivity -* `"..NUM_MSG_MAX.."`\n"
.."`>` *Character Sensitivity -* `"..SETCHAR.."`\n"
.."`>` *Flood Check Time -* `"..TIME_CHECK.."`\n"
.."`>` *Commands -* `"..cmdsss.."`\n"
.."`>` *Lock All -* "..lock_all1.."\n"
.."`>` *Welcome -* "..welcome.."\n"
.."-------------------\n"
.."`>` *Expire Date -* `"..expire_date.."`\n"
else
local settings = data[tostring(target)]["settings"] 
 text = "_تنظیمات گروه:_\n"
.."`>` _لینک :_ "..settings.lock_link.."\n"
.."`>` _تگ :_ "..settings.lock_tag.."\n"
.."`>` _جوین :_ "..settings.lock_join.."\n"
.."`>` _فلود{رگباری} :_ "..settings.lock_flood.."\n"
.."`>` _اسپم :_ "..settings.lock_spam.."\n"
.."`>` _منشن{فراخوانی} :_ "..settings.lock_mention.."\n"
.."`>` _نوشتار عربی :_ "..settings.lock_arabic.."\n"
.."`>`_کانتکت :_ "..settings.lock_contact.."\n"
.."`>`_فوروارد :_ "..settings.lock_forward.."\n"
.."`>` _استیکر :_ "..settings.lock_sticker.."\n"
.."`>` _صفحه وب :_ "..settings.lock_webpage.."\n"
.."`>` _مارکداون{زیبانویسی} :_ "..settings.lock_markdown.."\n"
.."`>` _پین کردن :_ "..settings.lock_pin.."\n"
.."`>` _ادیت کردن :_ "..settings.lock_edit.."\n"
.."`>` _گیف{تصویر متحرک} :_ "..settings.lock_gif.."\n"
.."`>` _نوشتار :_ "..settings.lock_text.."\n"
.."`>` _اینلاین{درون خطی} :_ "..settings.lock_inline.."\n"
.."`>` _بازی های تحت وب :_ "..settings.lock_game.."\n"
.."`>` _عکس :_ "..settings.lock_photo.."\n"
.."`>` _فیلم :_ "..settings.lock_video.."\n"
.."`>` _موسیقی :_ "..settings.lock_audio.."\n"
.."`>` _صدا :_ "..settings.lock_voice.."\n"
.."`>` _مکان :_ "..settings.lock_location.."\n"
.."`>` _فایل :_ "..settings.lock_document.."\n"
.."`>` _کیبورد{صفحه کلید} :_ "..settings.lock_keyboard.."\n"
.."------------\n"
.."`>` _حفاظت از ورود ربات :_ "..settings.lock_bots.."\n"
.."`>` _حساسیت فلود :_ "..NUM_MSG_MAX.."\n"
.."`>` _حساسیت کاراکتر :_ "..SETCHAR.."\n"
.."`>` _حساسیت زمانی فلود :_ "..TIME_CHECK.."\n"
.."`>` _دستورات :_ "..cmdsss.."\n"
.."`>` _قفل همه :_ "..lock_all1.."\n"
.."_----------_\n"
.."`>` _انقضا :_ "..expire_date.."\n"
 end
text = string.gsub(text, 'yes', '`[Lock]`')
text = string.gsub(text, 'no', '`[Unlock]`')
text = string.gsub(text, 'enable', '`[Enable]`')
text = string.gsub(text, 'disable', '`[Disable]`')
return text
end
--------settings---------
---------------lock Gif-------------------
local function lock_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_gif = data[tostring(target)]["settings"]["lock_gif"] 
if lock_gif == "yes" then
if not lang then
 return "`>` *Lock Gif* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن تصاویر متحرک فعال است"
end
else
 data[tostring(target)]["settings"]["lock_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "`>` *Lock Gif* Has Been *Enable*"
else
 return "بیصدا کردن تصاویر متحرک فعال شد"
end
end
end

local function unlock_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_gif = data[tostring(target)]["settings"]["lock_gif"]
 if lock_gif == "no" then
if not lang then
return "`>` *Lock Gif* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن تصاویر متحرک غیر فعال بود"
end
else 
data[tostring(target)]["settings"]["lock_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Gif* Has Been *Disable*" 
else
return "بیصدا کردن تصاویر متحرک غیر فعال شد"
end
end
end
---------------lock Game-------------------
local function lock_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_game = data[tostring(target)]["settings"]["lock_game"] 
if lock_game == "yes" then
if not lang then
 return "`>` *Lock Game* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن بازی های تحت وب فعال است"
end
else
 data[tostring(target)]["settings"]["lock_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Game* Has Been *Enable*"
else
 return "بیصدا کردن بازی های تحت وب فعال شد"
end
end
end

local function unlock_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_game = data[tostring(target)]["settings"]["lock_game"]
 if lock_game == "no" then
if not lang then
return "`>` *Lock Game* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن بازی های تحت وب غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`>` *Lock Game* Has Been *Disable*" 
else
return "بیصدا کردن بازی های تحت وب غیر فعال شد"
end
end
end
---------------lock Inline-------------------
local function lock_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_inline = data[tostring(target)]["settings"]["lock_inline"] 
if lock_inline == "yes" then
if not lang then
 return "`>` *Lock Inline* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن کیبورد شیشه ای فعال است"
end
else
 data[tostring(target)]["settings"]["lock_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Inline* Has Been *Enable*"
else
 return "بیصدا کردن کیبورد شیشه ای فعال شد"
end
end
end

local function unlock_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_inline = data[tostring(target)]["settings"]["lock_inline"]
 if lock_inline == "no" then
if not lang then
return "`>` *Lock Inline* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن کیبورد شیشه ای غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Inline* Has Been *Disable*" 
else
return "بیصدا کردن کیبورد شیشه ای غیر فعال شد"
end
end
end
---------------lock Text-------------------
local function lock_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_text = data[tostring(target)]["settings"]["lock_text"] 
if lock_text == "yes" then
if not lang then
 return "`>` *Lock Text* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن متن فعال است"
end
else
 data[tostring(target)]["settings"]["lock_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Text* Has Been *Enable*"
else
 return "بیصدا کردن متن فعال شد"
end
end
end

local function unlock_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_text = data[tostring(target)]["settings"]["lock_text"]
 if lock_text == "no" then
if not lang then
return "`>` *Lock Text* Is Already *Disable*"
elseif lang then
return "بیصدا کردن متن غیر فعال است" 
end
else 
data[tostring(target)]["settings"]["lock_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Text* Has Been *Disable*" 
else
return "بیصدا کردن متن غیر فعال شد"
end
end
end
---------------lock photo-------------------
local function lock_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_photo = data[tostring(target)]["settings"]["lock_photo"] 
if lock_photo == "yes" then
if not lang then
 return "`>` *Lock Photo* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن عکس فعال است"
end
else
 data[tostring(target)]["settings"]["lock_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Photo* Has Been *Enable*"
else
 return "بیصدا کردن عکس فعال شد"
end
end
end

local function unlock_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end
 
local lock_photo = data[tostring(target)]["settings"]["lock_photo"]
 if lock_photo == "no" then
if not lang then
return "`>` *Lock Photo* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن عکس غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Photo* Has Been *Disable*" 
else
return "بیصدا کردن عکس غیر فعال شد"
end
end
end
---------------lock Video-------------------
local function lock_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_video = data[tostring(target)]["settings"]["lock_video"] 
if lock_video == "yes" then
if not lang then
 return "`>` *Lock Video* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن فیلم فعال است"
end
else
 data[tostring(target)]["settings"]["lock_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "`>` *Lock Video* Has Been *Enable*"
else
 return "بیصدا کردن فیلم فعال شد"
end
end
end

local function unlock_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_video = data[tostring(target)]["settings"]["lock_video"]
 if lock_video == "no" then
if not lang then
return "`>` *Lock Video* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن فیلم غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Video* Has Been *Disable*" 
else
return "بیصدا کردن فیلم غیر فعال شد"
end
end
end
---------------lock Audio-------------------
local function lock_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_audio = data[tostring(target)]["settings"]["lock_audio"] 
if lock_audio == "yes" then
if not lang then
 return "`>` *Lock Audio* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن آهنگ فعال است"
end
else
 data[tostring(target)]["settings"]["lock_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Audio* Has Been *Enable*"
else 
return "بیصدا کردن آهنگ فعال شد"
end
end
end

local function unlock_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_audio = data[tostring(target)]["settings"]["lock_audio"]
 if lock_audio == "no" then
if not lang then
return "`>` *Lock Audio* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن آهنک غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`>` *Lock Audio* Has Been *Disable*"
else
return "بیصدا کردن آهنگ غیر فعال شد" 
end
end
end
---------------lock Voice-------------------
local function lock_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_voice = data[tostring(target)]["settings"]["lock_voice"] 
if lock_voice == "yes" then
if not lang then
 return "`>` *Lock Voice* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن صدا فعال است"
end
else
 data[tostring(target)]["settings"]["lock_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Voice* Has Been *Enable*"
else
 return "بیصدا کردن صدا فعال شد"
end
end
end

local function unlock_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_voice = data[tostring(target)]["settings"]["lock_voice"]
 if lock_voice == "no" then
if not lang then
return "`>` *Lock Voice* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن صدا غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`>` *Lock Voice* Has Been *Disable*" 
else
return "بیصدا کردن صدا غیر فعال شد"
end
end
end
---------------lock Sticker-------------------
local function lock_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"] 
if lock_sticker == "yes" then
if not lang then
 return "`>` *Lock Sticker* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن برچسب فعال است"
end
else
 data[tostring(target)]["settings"]["lock_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Sticker* Has Been *Enable*"
else
 return "بیصدا کردن برچسب فعال شد"
end
end
end

local function unlock_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end 
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"]
 if lock_sticker == "no" then
if not lang then
return "`>` *Lock Sticker* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن برچسب غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`>` *Lock Sticker* Has Been *Disable*"
else
return "بیصدا کردن برچسب غیر فعال شد"
end 
end
end
---------------lock Contact-------------------
local function lock_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_contact = data[tostring(target)]["settings"]["lock_contact"] 
if lock_contact == "yes" then
if not lang then
 return "`>` *Lock Contact* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن مخاطب فعال است"
end
else
 data[tostring(target)]["settings"]["lock_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Contact* Has Been *Enable*"
else
 return "بیصدا کردن مخاطب فعال شد"
end
end
end

local function unlock_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_contact = data[tostring(target)]["settings"]["lock_contact"]
 if lock_contact == "no" then
if not lang then
return "`>` *Lock Contact* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن مخاطب غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Contact* Has Been *Disable*" 
else
return "بیصدا کردن مخاطب غیر فعال شد"
end
end
end
---------------lock Forward-------------------
local function lock_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_forward = data[tostring(target)]["settings"]["lock_forward"] 
if lock_forward == "yes" then
if not lang then
 return "`>` *Lock Forward* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن نقل قول فعال است"
end
else
 data[tostring(target)]["settings"]["lock_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Forward* Has Been *Enable*"
else
 return "بیصدا کردن نقل قول فعال شد"
end
end
end

local function unlock_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_forward = data[tostring(target)]["settings"]["lock_forward"]
 if lock_forward == "no" then
if not lang then
return "`>` *Lock Forward* Is Already *Disable*"
elseif lang then
return "بیصدا کردن نقل قول غیر فعال است"
end 
else 
data[tostring(target)]["settings"]["lock_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`>` *Lock Forward* Has Been *Disable*" 
else
return "بیصدا کردن نقل قول غیر فعال شد"
end
end
end
---------------lock Location-------------------
local function lock_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_location = data[tostring(target)]["settings"]["lock_location"] 
if lock_location == "yes" then
if not lang then
 return "`>` *Lock Location* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن موقعیت فعال است"
end
else
 data[tostring(target)]["settings"]["lock_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "`>` *Lock Location* Has Been *Enable*"
else
 return "بیصدا کردن موقعیت فعال شد"
end
end
end

local function unlock_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_location = data[tostring(target)]["settings"]["lock_location"]
 if lock_location == "no" then
if not lang then
return "`>` *Lock Location* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن موقعیت غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Location* Has Been *Disable*" 
else
return "بیصدا کردن موقعیت غیر فعال شد"
end
end
end
---------------lock Document-------------------
local function lock_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
return ""
end
end

local lock_document = data[tostring(target)]["settings"]["lock_document"] 
if lock_document == "yes" then
if not lang then
 return "`>` *Lock Document* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن اسناد فعال لست"
end
else
 data[tostring(target)]["settings"]["lock_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Document* Has Been *Enable*"
else
 return "بیصدا کردن اسناد فعال شد"
end
end
end

local function unlock_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return ""
end
end 

local lock_document = data[tostring(target)]["settings"]["lock_document"]
 if lock_document == "no" then
if not lang then
return "`>` *Lock Document* Is Already *Disable*" 
elseif lang then
return "بیصدا کردن اسناد غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock Document* Has Been *Disable*" 
else
return "بیصدا کردن اسناد غیر فعال شد"
end
end
end
---------------lock TgService-------------------
local function lock_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"] 
if lock_tgservice == "yes" then
if not lang then
 return "`>` *Lock TgService* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن خدمات تلگرام فعال است"
end
else
 data[tostring(target)]["settings"]["lock_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock TgService* Has Been *Enable*"
else
return "بیصدا کردن خدمات تلگرام فعال شد"
end
end
end

local function unlock_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return "شما مدیر گروه نیستید"
end 
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"]
 if lock_tgservice == "no" then
if not lang then
return "`>` *Lock TgService* Is Already *Disable*"
elseif lang then
return "بیصدا کردن خدمات تلگرام غیر فعال است"
end 
else 
data[tostring(target)]["settings"]["lock_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock TgService* Has Been *Disable*"
else
return "بیصدا کردن خدمات تلگرام غیر فعال شد"
end 
end
end

---------------lock Keyboard-------------------
local function lock_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return ""
else
 return ""
end
end

local lock_keyboard = data[tostring(target)]["settings"]["lock_keyboard"] 
if lock_keyboard == "yes" then
if not lang then
 return "`>` *Lock Keyboard* Is Already *Enable*"
elseif lang then
 return "بیصدا کردن صفحه کلید فعال است"
end
else
 data[tostring(target)]["settings"]["lock_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`>` *Lock Keyboard* Has Been *Enable*"
else
return "بیصدا کردن صفحه کلید فعال شد"
end
end
end

local function unlock_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return ""
else
return "شما مدیر گروه نیستید"
end 
end

local lock_keyboard = data[tostring(target)]["settings"]["lock_keyboard"]
 if lock_keyboard == "no" then
if not lang then
return "`>` *Lock Keyboard* Is Already *Disable*"
elseif lang then
return "بیصدا کردن صفحه کلید غیرفعال است"
end 
else 
data[tostring(target)]["settings"]["lock_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`>` *Lock TgService* Has Been *Disable*"
else
return "بیصدا کردن صفحه کلید غیرفعال شد"
end 
end
end


local function run(msg, matches)
if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end
local cmd = redis:hget('group:'..msg.to.id..':cmd', 'bot')
local lockalll = redis:get('group:'..msg.to.id..':lockall')
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if cmd == 'moderator' and not is_mod(msg) or cmd == 'owner' and not is_owner(msg) or lockalll and not is_mod(msg) then
 return 
 else
if msg.to.type ~= 'pv' then
if matches[1]:lower() == "id" or matches[1] == 'ایدی' then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'> Your Name : '..msg.from.first_name..'\n> Your Username : '..('@'..msg.from.username or 'No Username')..'\n> Your TGId : '..msg.from.id..'\n> Group Info : '..msg.to.id..'|'..msg.to.title,dl_cb,nil)
       elseif lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'نام شما : '..msg.from.first_name..'\nیوزرنیم شما : '..('@'..msg.from.username or 'No Username')..'\nایدی شما : '..msg.from.id..'\nدرباره گروه : '..msg.to.id..'|'..msg.to.title..'',dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, '`>` *Your Name* : '..msg.from.first_name..'\n`>` *Your Username* : '..('@'..msg.from.username or 'No Username')..'\n`>` *Your TGId* : '..msg.from.id..'\n`>` *Group Info* : '..msg.to.id..'|'..msg.to.title, 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, 'نام شما : '..msg.from.first_name..'\nیوزرنیم شما : '..('@'..msg.from.username or 'بدون یوزرنیم')..'\nایدی شما : '..msg.from.id..'\nدرباره گروه: '..msg.to.id..'|'..msg.to.title, 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
getUser(msg.from.id,getpro)
end
if msg.reply_id and is_mod(msg) and not matches[2] then
tdcli.getMessage(msg.to.id, msg.reply_id, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] and #matches[2] > 3 and is_mod(msg) and not matches[3] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if (matches[1]:lower() == "pin" or matches[1] == 'سنجاق') and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
end
end
if (matches[1]:lower() == 'unpin' or matches[1] == 'حذف سنجاق') and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
end
end
if matches[1]:lower() == "add" or matches[1] == 'افزودن' then
return modadd(msg)
end
if matches[1]:lower() == "rem" or matches[1] == 'حذف گروه' then
return modrem(msg)
end
if (matches[1]:lower() == "setmanager" or matches[1] == 'ادمین گروه') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setmanager"})
      end
   end
if (matches[1]:lower() == "remmanager" or matches[1] == 'حذف ادمین گروه') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remmanager"})
      end
   end
if (matches[1]:lower() == "whitelist" or matches[1] == 'لیست سفید') and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if (matches[1]:lower() == "whitelist" or matches[1] == 'لیست سفید') and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if (matches[1]:lower() == "setowner" or matches[1] == 'مالک') and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if (matches[1]:lower() == "remowner" or matches[1] == 'حذف مالک') and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if (matches[1]:lower() == "promote" or matches[1] == 'مدیر') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if (matches[1]:lower() == "demote" or matches[1] == 'حذف مدیر') and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end
if (matches[1]:lower() == "lock" or matches[1] == 'قفل') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "link" then
return lock_link(msg, data, target)
end
if matches[2] == "tag" then
return lock_tag(msg, data, target)
end
if matches[2] == "mention" then
return lock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return lock_arabic(msg, data, target)
end
if matches[2] == "edit" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood" then
return lock_flood(msg, data, target)
end
if matches[2] == "bots" then
return lock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return lock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "join" then
return lock_join(msg, data, target)
end
if matches[2] == 'cmds' then
			redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
			return 'cmds has been locked for member'
			end
else
if matches[2] == 'لینک' then
return lock_link(msg, data, target)
end
if matches[2] == 'تگ' then
return lock_tag(msg, data, target)
end
if matches[2] == 'فراخوانی' then
return lock_mention(msg, data, target)
end
if matches[2] == 'عربی' then
return lock_arabic(msg, data, target)
end
if matches[2] == 'ویرایش' then
return lock_edit(msg, data, target)
end
if matches[2] == 'هرزنامه' then
return lock_spam(msg, data, target)
end
if matches[2] == 'پیام مکرر' then
return lock_flood(msg, data, target)
end
if matches[2] == 'ربات' then
return lock_bots(msg, data, target)
end
if matches[2] == 'فونت' then
return lock_markdown(msg, data, target)
end
if matches[2] == 'وب' then
return lock_webpage(msg, data, target)
end
if matches[2] == 'سنجاق' and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "ورود" then
return lock_join(msg, data, target)
end
if matches[2] == 'دستورات' then
			redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
			return 'دستورات برای کاربر عادی قفل شد'
			end
			end
end
if (matches[1]:lower() == "unlock" or matches[1] == 'باز') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "link" then
return unlock_link(msg, data, target)
end
if matches[2] == "tag" then
return unlock_tag(msg, data, target)
end
if matches[2] == "mention" then
return unlock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return unlock_arabic(msg, data, target)
end
if matches[2] == "edit" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" then
return unlock_flood(msg, data, target)
end
if matches[2] == "bots" then
return unlock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "join" then
return unlock_join(msg, data, target)
end
if matches[2] == 'cmds' then
			redis:del('group:'..msg.to.id..':cmd')
			return 'cmds has been unlocked for member'
			end
	else
if matches[2] == 'لینک' then
return unlock_link(msg, data, target)
end
if matches[2] == 'تگ' then
return unlock_tag(msg, data, target)
end
if matches[2] == 'فراخوانی' then
return unlock_mention(msg, data, target)
end
if  matches[2] == 'عربی' then
return unlock_arabic(msg, data, target)
end
if matches[2] == 'ویرایش' then
return unlock_edit(msg, data, target)
end
if matches[2] == 'هرزنامه' then
return unlock_spam(msg, data, target)
end
if matches[2] == 'پیام مکرر' then
return unlock_flood(msg, data, target)
end
if matches[2] == 'ربات' then
return unlock_bots(msg, data, target)
end
if matches[2] == 'فونت' then
return unlock_markdown(msg, data, target)
end
if matches[2] == 'وب' then
return unlock_webpage(msg, data, target)
end
if matches[2] == 'سنجاق' and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "ورود" then
return unlock_join(msg, data, target)
end
if matches[2] == 'دستورات' then
			redis:del('group:'..msg.to.id..':cmd')
			return 'دستورات برای کاربر عادی باز شد'
			end
	end
end
if (matches[1]:lower() == "lock" or matches[1] == 'قفل') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "gif" then
return lock_gif(msg, data, target)
end
if matches[2] == "text" then
return lock_text(msg ,data, target)
end
if matches[2] == "photo" then
return lock_photo(msg ,data, target)
end
if matches[2] == "video" then
return lock_video(msg ,data, target)
end
if matches[2] == "audio" then
return lock_audio(msg ,data, target)
end
if matches[2] == "voice" then
return lock_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return lock_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return lock_contact(msg ,data, target)
end
if matches[2] == "forward" then
return lock_forward(msg ,data, target)
end
if matches[2] == "location" then
return lock_location(msg ,data, target)
end
if matches[2] == "document" then
return lock_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return lock_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return lock_inline(msg ,data, target)
end
if matches[2] == "game" then
return lock_game(msg ,data, target)
end
if matches[2] == "keyboard" then
return lock_keyboard(msg ,data, target)
end
if matches[2] == 'all' then
local hash = 'lockall:'..msg.to.id
redis:set(hash, true)
return "`>` *Lock All* Has Been *Enable*"
end
else
if matches[2] == 'تصاویر متحرک' then
return lock_gif(msg, data, target)
end
if matches[2] == 'متن' then
return lock_text(msg ,data, target)
end
if matches[2] == 'عکس' then
return lock_photo(msg ,data, target)
end
if matches[2] == 'فیلم' then
return lock_video(msg ,data, target)
end
if matches[2] == 'اهنگ' then
return lock_audio(msg ,data, target)
end
if matches[2] == 'صدا' then
return lock_voice(msg ,data, target)
end
if matches[2] == 'برچسب' then
return lock_sticker(msg ,data, target)
end
if matches[2] == 'مخاطب' then
return lock_contact(msg ,data, target)
end
if matches[2] == 'نقل قول' then
return lock_forward(msg ,data, target)
end
if matches[2] == 'موقعیت' then
return lock_location(msg ,data, target)
end
if matches[2] == 'اسناد' then
return lock_document(msg ,data, target)
end
if matches[2] == 'خدمات تلگرام' then
return lock_tgservice(msg ,data, target)
end
if matches[2] == 'کیبورد شیشه ای' then
return lock_inline(msg ,data, target)
end
if matches[2] == 'بازی' then
return lock_game(msg ,data, target)
end
if matches[2] == 'صفحه کلید' then
return lock_keyboard(msg ,data, target)
end
if matches[2]== 'همه' then
local hash = 'lockall:'..msg.to.id
redis:set(hash, true)
return "بیصدا کردن گروه فعال شد"
end
end
end
if (matches[1]:lower() == "unlock" or matches[1] == 'باز') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "gif" then
return unlock_gif(msg, data, target)
end
if matches[2] == "text" then
return unlock_text(msg, data, target)
end
if matches[2] == "photo" then
return unlock_photo(msg ,data, target)
end
if matches[2] == "video" then
return unlock_video(msg ,data, target)
end
if matches[2] == "audio" then
return unlock_audio(msg ,data, target)
end
if matches[2] == "voice" then
return unlock_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return unlock_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return unlock_contact(msg ,data, target)
end
if matches[2] == "forward" then
return unlock_forward(msg ,data, target)
end
if matches[2] == "location" then
return unlock_location(msg ,data, target)
end
if matches[2] == "document" then
return unlock_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return unlock_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return unlock_inline(msg ,data, target)
end
if matches[2] == "game" then
return unlock_game(msg ,data, target)
end
if matches[2] == "keyboard" then
return unlock_keyboard(msg ,data, target)
end
 if matches[2] == 'all' then
         local hash = 'lockall:'..msg.to.id
        redis:del(hash)
          return "`>` *Lock All* Has Been *Disable*"
end
else
if matches[2] == 'تصاویر متحرک' then
return unlock_gif(msg, data, target)
end
if matches[2] == 'متن' then
return unlock_text(msg, data, target)
end
if matches[2] == 'عکس' then
return unlock_photo(msg ,data, target)
end
if matches[2] == 'فیلم' then
return unlock_video(msg ,data, target)
end
if matches[2] == 'اهنگ' then
return unlock_audio(msg ,data, target)
end
if matches[2] == 'صدا' then
return unlock_voice(msg ,data, target)
end
if matches[2] == 'برچسب' then
return unlock_sticker(msg ,data, target)
end
if matches[2] == 'مخاطب' then
return unlock_contact(msg ,data, target)
end
if matches[2] == 'نقل قول' then
return unlock_forward(msg ,data, target)
end
if matches[2] == 'موقعیت' then
return unlock_location(msg ,data, target)
end
if matches[2] == 'اسناد' then
return unlock_document(msg ,data, target)
end
if matches[2] == 'خدمات تلگرام' then
return unlock_tgservice(msg ,data, target)
end
if matches[2] == 'کیبورد شیشه ای' then
return unlock_inline(msg ,data, target)
end
if matches[2] == 'بازی' then
return unlock_game(msg ,data, target)
end
if matches[2] == 'صفحه کلید' then
return unlock_keyboard(msg ,data, target)
end
 if matches[2]=='همه' and is_mod(msg) then
         local hash = 'lockall:'..msg.to.id
        redis:del(hash)
          return "گروه ازاد شد و افراد می توانند دوباره پست بگذارند"
		  
end
end
end
if (matches[1]:lower() == 'cmds' or matches[1] == 'دستورات') and is_owner(msg) then 
	if not lang then
		if matches[2]:lower() == 'owner' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner') 
		return 'cmds set for owner or higher' 
		end
		if matches[2]:lower() == 'moderator' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
		return 'cmds set for moderator or higher'
		end 
		if matches[2]:lower() == 'member' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'member') 
		return 'cmds set for member or higher' 
		end 
	else
		if matches[2] == 'مالک' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner') 
		return 'دستورات برای مدیرکل به بالا دیگر جواب می دهد' 
		end
		if matches[2] == 'مدیر' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
		return 'دستورات برای مدیر به بالا دیگر جواب می دهد' 
		end 
		if matches[2] == 'کاربر' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'member') 
		return 'دستورات برای کاربر عادی به بالا دیگر جواب می دهد' 
		end 
		end
	end
if (matches[1]:lower() == "gpinfo" or matches[1] == 'اطلاعات گروه') and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
if not lang then
ginfo = "*Group Info :*\n*Admin Count :* *"..data.administrator_count_.."*\n*Member Count :* *"..data.member_count_.."*\n*Kicked Count :* *"..data.kicked_count_.."*\n*Group ID :* *"..data.channel_.id_.."* "..Segreto..""
elseif lang then
ginfo = "*اطلاعات گروه :*\n_تعداد مدیران :_ *"..data.administrator_count_.."*\n_تعداد اعضا :_ *"..data.member_count_.."*\n_تعداد اعضای حذف شده :_ *"..data.kicked_count_.."*\n_شناسه گروه :_ *"..data.channel_.id_.."* "..Segreto..""
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if (matches[1]:lower() == 'newlink' or matches[1] == 'لینک جدید') and is_mod(msg) and not matches[2] then
	local function callback_link (arg, data)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Bot is not group creator*\n*set a link for group with using* `/setlink` "..Segreto.."", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_ "..Segreto.."", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created* "..Segreto.."", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد_ "..Segreto.."", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'newlink' or matches[1] == 'لینک جدید') and is_mod(msg) and (matches[2] == 'pv' or matches[2] == 'خصوصی') then
	local function callback_link (arg, data)
		local result = data.invite_link_
		local administration = load_data(_config.moderation.data) 
				if not result then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Bot is not group creator*\n*set a link for group with using* `/setlink` "..Segreto.."", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_ "..Segreto.."", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = result
					save_data(_config.moderation.data, administration)
        if not lang then
		tdcli.sendMessage(user, msg.id, 1, "*Newlink Group* _:_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*New link Was Send In Your Private Message* "..Segreto.."", 1, 'md')
        elseif lang then
		tdcli.sendMessage(user, msg.id, 1, "*لینک جدید گروه* _:_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد و در پیوی شما ارسال شد_ "..Segreto.."", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'setlink' or matches[1] == 'تنظیم لینک') and is_owner(msg) then
		if not matches[2] then
		data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
			if not lang then
			return '*Please send the new group* `link` *now* "..Segreto.."'
    else 
         return 'لطفا لینک گروه خود را ارسال کنید'
       end
	   end
		 data[tostring(chat)]['settings']['linkgp'] = matches[2]
			 save_data(_config.moderation.data, data)
      if not lang then
			return '*Group Link Was Saved Successfully.* "..Segreto.."'
    else 
         return 'لینک گروه شما با موفقیت ذخیره شد'
       end
		end
		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "`Newlink` *has been set* "..Segreto..""
           else
           return "لینک جدید ذخیره شد "..Segreto..""
		 	end
       end
		end
    if (matches[1]:lower() == 'link' or matches[1] == 'لینک') and is_mod(msg) and not matches[2] then
local data = load_data(_config.moderation.data)
local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "*First create a link for group with using* `/newlink`\n*If bot not group creator set a link with using* `/setlink` "..Segreto..""
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید "..Segreto..""
      end
      end
     if not lang then
       tex = "*Group Link For :* `"..msg.to.title.."`\n\n [Click Here For join To Group]("..linkgp..")"
     else
       tex = "*لینک گروه :* `"..msg.to.title.."`\n\n [اینجا را کلیک کنید برای جوین دادن در گروه]("..linkgp..")"
         end
		 	local hlink = function(arg, data)
	 tdcli_function({ID = "SendInlineQueryResultMessage",
	 chat_id_ = msg.chat_id_,
	 reply_to_message_id_ = msg.id_,
	 disable_notification_ = 0,
	 from_background_ = 1,
	 query_id_ = data.inline_query_id_,
	 result_id_ = data.results_[0].id_},
	 dl_cb, nil)
	end
	 tdcli_function({ID = "GetInlineQueryResults",
	 bot_user_id_ = 107705060,
	 chat_id_ = msg.chat_id_,
	 user_location_ = {ID = "Location",
	 latitude_ = 0,longitude_ = 0},
	 query_ = tex,offset_ = 0},
	 hlink, nil)
end
      --  return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     --end
    if (matches[1]:lower() == 'link' or matches[1] == 'لینک') and (matches[2] == 'pv' or matches[2] == 'خصوصی') then
	if is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "*First create a link for group with using* `/newlink`\n*If bot not group creator set a link with using* `/setlink` "..Segreto..""
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید "..Segreto..""
      end
      end
     if not lang then
	 tdcli.sendMessage(chat, msg.id, 1, "<b>link Was Send In Your Private Message</b>", 1, 'html')
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
	 tdcli.sendMessage(chat, msg.id, 1, "<b>لینک گروه در پیوی  شما ارسال شد</b>", 1, 'html')
      tdcli.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
     end
	 end
  if (matches[1]:lower() == "setrules" or matches[1] == 'تنظیم قوانین') and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "`Group rules` *has been set*"
   else 
  return "قوانین گروه ثبت شد"
   end
  end
  if matches[1]:lower() == "rules" or matches[1] == 'قوانین' then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = [[✅ *The Default Rules :*

🔸_Don't Flood._
🔸_Don't Spam._
🔸_Don't Send Link_
🔸_Don't Send Porn Video-Pic_

—|@SegretoTeam|—]]
	 elseif lang then
       rules = [[_✅ قوانین پپیشفرض:_

🔸* ارسال پیام مکرر ممنوع.*
🔸 *ارسال اسپم ممنوع.*
🔸* ارسال لینک ممنوع.*
🔸*ارسال عکس و فیلم پورن ممنوع. *


—|@SegretoTeam|—]] 
	   end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if (matches[1]:lower() == "res" or matches[1] == 'کاربری') and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if (matches[1]:lower() == "whois" or matches[1] == 'شناسه') and matches[2] and string.match(matches[2], '^%d+$') and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if matches[1]:lower() == 'setchar' or matches[1]:lower() == 'حداکثر حروف مجاز' then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "*Character sensitivity* has been set to : *[ "..matches[2].." ]*"..Segreto..""
   else
     return "_حداکثر حروف مجاز در پیام تنظیم شد به :_ *[ "..matches[2].." ]*"..Segreto..""
		end
  end
  if (matches[1]:lower() == 'setflood' or matches[1] == 'تنظیم پیام مکرر') and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "_Wrong number, range is_ *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "Group *flood* sensitivity has been set to : *[ "..matches[2].." ]* "..Segreto..""
    else
    return '_محدودیت پیام مکرر به_ *'..tonumber(matches[2])..'* _تنظیم شد._ '..Segreto..''
    end
       end
  if (matches[1]:lower() == 'setfloodtime' or matches[1] == 'تنظیم زمان بررسی') and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "_Wrong number, range is_ *[2-10]* "..Segreto..""
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "Group *flood* *check time* has been set to : *[ "..matches[2].." ]* "..Segreto..""
    else
    return "_حداکثر زمان بررسی پیام های مکرر تنظیم شد به :_ *[ "..matches[2].." ]* "..Segreto..""
    end
       end
	   if matches[1]:lower() == 'kossher' then
	    return tdcli.sendMessage(msg.to.id, msg.id, 1, '..kos..', 1, 'md')
end  
		if (matches[1]:lower() == 'clean' or matches[1] == 'پاک کردن') and is_owner(msg) then
		if not lang then
			if matches[2] == 'mods' then
				if next(data[tostring(chat)]['mods']) == nil then
					return "*No* `moderators` *in this group* "..Segreto..""
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*All* `moderators` *has been demoted* "..Segreto..""
         end
			if matches[2] == 'filterlist' then
				if next(data[tostring(chat)]['filterlist']) == nil then
					return "*Filtered words list* is *empty* "..Segreto..""
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*Filtered words list* has been *cleaned* "..Segreto..""
			end
			if matches[2] == 'rules' then
				if not data[tostring(chat)]['rules'] then
					return "*No* `rules` *available* "..Segreto..""
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
				return "*Group rules* has been *cleaned* "..Segreto..""
       end
			if matches[2] == 'welcome' then
				if not data[tostring(chat)]['setwelcome'] then
					return "*Welcome Message not set* "..Segreto..""
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
				return "*Welcome message* has been *cleaned* "..Segreto..""
       end
			if matches[2] == 'about' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
					return "*No* `description` *available* "..Segreto..""
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
				return "*Group description* has been *cleaned* "..Segreto..""
		   	end
			else
			if matches[2] == 'مدیران' then
				if next(data[tostring(chat)]['mods']) == nil then
                return "هیچ مدیری برای گروه انتخاب نشده است "..Segreto..""
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            return "تمام مدیران گروه تنزیل مقام شدند "..Segreto..""
         end
			if matches[2] == 'لیست فیلتر' then
				if next(data[tostring(chat)]['filterlist']) == nil then
					return "_لیست کلمات فیلتر شده خالی است_ "..Segreto..""
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_لیست کلمات فیلتر شده پاک شد_ "..Segreto..""
			end
			if matches[2] == 'قوانین' then
				if not data[tostring(chat)]['rules'] then
               return "قوانین برای گروه ثبت نشده است "..Segreto..""
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
            return "قوانین گروه پاک شد "..Segreto..""
       end
			if matches[2] == 'خوشآمد' then
				if not data[tostring(chat)]['setwelcome'] then
               return "پیام خوشآمد گویی ثبت نشده است "..Segreto..""
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
            return "پیام خوشآمد گویی پاک شد "..Segreto..""
       end
			if matches[2] == 'درباره' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
              return "پیامی مبنی بر درباره گروه ثبت نشده است "..Segreto..""
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
              return "پیام مبنی بر درباره گروه پاک شد "..Segreto..""
		   	end
			
			end
			if matches[2] == 'bots' or matches[2] == 'ربات ها' then
  function clbot(arg, data)
    for k, v in pairs(data.members_) do
      kick_user(v.user_id_, msg.to.id)
	end
    tdcli.sendMessage(msg.to.id, msg.id, 1, '*All Bots Was Kicked!* '..Segreto..'', 1, 'md')
  end
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, clbot, nil)
  end
        end
		if (matches[1]:lower() == 'clean' or matches[1] == 'پاک کردن') and is_admin(msg) then
		if not lang then
			if matches[2] == 'owners' then
				if next(data[tostring(chat)]['owners']) == nil then
					return "*No* `owners` *in this group* "..Segreto..""
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*All* `owners` has been *demoted* "..Segreto..""
			end
			else
			if matches[2] == 'مالکان' then
				if next(data[tostring(chat)]['owners']) == nil then
                return "مالکی برای گروه انتخاب نشده است "..Segreto..""
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            return "تمامی مالکان گروه تنزیل مقام شدند "..Segreto..""
			end
			end
     end
if (matches[1]:lower() == "setname" or matches[1] == 'تنظیم نام') and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if (matches[1]:lower() == "setabout" or matches[1] == 'تنظیم درباره') and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_ "..Segreto..""
    else
     return "پیام مبنی بر درباره گروه ثبت شد "..Segreto..""
      end
  end
  if matches[1]:lower() == "about" or matches[1] == 'درباره' and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_ "..Segreto..""
      elseif lang then
      about = "پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1]:lower() == 'filter' or matches[1] == 'فیلتر' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1]:lower() == 'unfilter' or matches[1] == 'حذف فیلتر' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if (matches[1]:lower() == 'config' or matches[1] == 'پیکربندی') and is_admin(msg) then
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, config_cb, {chat_id=msg.to.id})
  end
  if (matches[1]:lower() == 'filterlist' or matches[1] == 'لیست فیلتر') and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1]:lower() == "modlist" or matches[1] == 'لیست مدیران' then
return modlist(msg)
end
if (matches[1]:lower() == "whitelist" or matches[1] == 'لیست سفید') and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end
if (matches[1]:lower() == "ownerlist" or matches[1] == 'لیست مالکان') and is_owner(msg) then
return ownerlist(msg)
end
if (matches[1]:lower() == "settings" or matches[1] == 'تنظیمات') and is_mod(msg) then
return group_settings(msg, target)
end
if (matches[1]:lower() == "locklist" or matches[1] == 'لیست بیصدا') and is_mod(msg) then
return settings(msg, target)
end
if matches[1]:lower() == "setlang" and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if matches[2] == "fa" then
redis:set(hash, true)
return "*زبان گروه تنظیم شد به : فارسی*"..Segreto
end
end
if matches[1] == 'زبان انگلیسی' then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "_Group Language Set To:_ EN"..Segreto
end
 if (matches[1] == 'locktime' or matches[1] == 'زمان بیصدا') and is_mod(msg) then
local hash = 'lockall:'..msg.to.id
local hour = tonumber(matches[2])
local num1 = (tonumber(hour) * 3600)
local minutes = tonumber(matches[3])
local num2 = (tonumber(minutes) * 60)
local second = tonumber(matches[4])
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "_lock all has been enabled for_ \n⏺ *hours :* `"..matches[2].."`\n⏺ *minutes :* `"..matches[3].."`\n⏺ *seconds :* `"..matches[4].."`"..Segreto
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[2].."\n⏺ دقیقه : "..matches[3].."\n⏺ ثانیه : "..matches[4]..Segreto
 end
 end
 if (matches[1] == 'lockhours' or matches[1]== 'ساعت بیصدا') and is_mod(msg) then
       local hash = 'lockall:'..msg.to.id
local hour = matches[2]
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "lock all has been enabled for \n⏺ hours : "..matches[2]..Segreto
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[2]..Segreto
 end
 end
  if (matches[1] == 'lockminutes' or matches[1]== 'دقیقه بیصدا')  and is_mod(msg) then
 local hash = 'lockall:'..msg.to.id
local minutes = matches[2]
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "lock all has been enabled for \n⏺ minutes : "..matches[2]..Segreto
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ دقیقه : "..matches[2]..Segreto
 end
 end
  if (matches[1] == 'settingseconds' or matches[1] == 'ثانیه بیصدا') and is_mod(msg) then
       local hash = 'lockall:'..msg.to.id
local second = matches[2]
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "lock all has been enabled for \n⏺ seconds : "..matches[2]..Segreto
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ثانیه : "..matches[2]..Segreto
 end
 end
 if (matches[1] == 'lockall' or matches[1] == 'موقعیت') and (matches[2] == 'status' or matches[2] == 'بیصدا') and is_mod(msg) then
         local hash = 'lockall:'..msg.to.id
      local lock_time = redis:ttl(hash)
		
		if tonumber(lock_time) < 0 then
		if not lang then
		return '*lock All is Disable.*\n*Now Members Can Send Message* '..Segreto..''
		else
		return '_بیصدا بودن گروه غیر فعال است._ '..Segreto..''
		end
		else
		if not lang then
          return lock_time.." Sec"
		  elseif lang then
		  return lock_time.."ثانیه"
		end
		end
  end

if (matches[1]:lower() == "help" or matches[1] == 'راهنما') and is_mod(msg) then
if not lang then
text = [[
*SEGRETO Bot Commands:*

*!setmanager* `[username|id|reply]` 
Add User To Group Admins(CreatorBot)
-----
*!Remmanager* `[username|id|reply]` 
 Remove User From Owner List(CreatorBot)
 -----
*!setowner* `[username|id|reply]` 
Set Group Owner(Multi Owner)
-----
*!remowner* `[username|id|reply]` 
 Remove User From Owner List
 -----
*!promote* `[username|id|reply]` 
Promote User To Group Admin
-----
*!demote* `[username|id|reply]` 
Demote User From Group Admins List
-----
*!whitelist* `[+ | -]`	
Add User To White List
-----
*!silent* `[username|id|reply]` 
Silent User From Group
-----
*!unsilent* `[username|id|reply]` 
Unsilent User From Group
-----
*!kick* `[username|id|reply]` 
Kick User From Group
-----
*!ban* `[username|id|reply]` 
Ban User From Group
-----
*!unban* `[username|id|reply]` 
UnBan User From Group
--------------------------------------------------
*!setflood* `[2-50]`
Set Flooding Number
-----
*!res* `[username]`
Show User ID
-----
*!id* `[reply]`
Show User ID
-----
*!whois* `[id]`
Show User's Username And Name
-----
*!newlink*
Create A New Link
-----
*!newlink pv*
Create A New Link The Pv
-----
*!link*
Show Group Link
-----
*!link pv*
Send Group Link In Your Private Message
--------------------------------------------------
*!lock* `[link | join | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention | pin | cmds | all | gif | photo | document | sticker | keyboard | video | text | forward | location | audio | voice | contact]`
If This Actions Lock, Bot Check Actions And Delete Them
-----
*!unlock* `[link | join | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention | pin | cmds | all | gif | photo | document | sticker | keyboard | video | text | forward | location | audio | voice | contact]`
If This Actions Unlock, Bot Not Delete Them
-----
*!locktime* `(hour) (minute) (seconds)`
lock group at this time 
*!lockhours* `(number)`
lock group at this time 
-----
*!set*`[rules | name | link | about | welcome]`
Bot Set Them
-----
*!clean* `[bans | mods | bots | rules | about | silentlist | filtelist | welcome]`   
Bot Clean Them
-----
*!settings*
Show Group Settings
-----
*!cmds* `[member | moderator | owner]`	
set cmd
-----
*!welcome enable/disable*
Enable Or Disable Group Welcome
--------------------------------------------------
*!filter* `[word]`
Word filter
-----
*!unfilter* `[word]`
Word unfilter
--------------------------------------------------
*!pin* `[reply]`
Pin Your Message
-----
*!unpin* 
Unpin Pinned Message
--------------------------------------------------
*!silentlist*
Show Silented Users List

*!filterlist*
Show Filtered Words List

*!banlist*
Show Banned Users List

*!ownerlist*
Show Group Owners List 

*!whitelist*
Show Group whitelist List

*!modlist* 
Show Group Moderators List
--------------------------------------------------
*!rules*
Show Group Rules
-----
*!about*
Show Group Description
-----
*!id*
Show Your And Chat ID
-----
*!gpinfo*
Show Group Information
--------------------------------------------------
*!setlang fa*
Set Persian Language

*!setwelcome [text]*
set Welcome Message
--------------------------------------------------
_You Can Use *[!/#$]* To Run The Commands_
_This Help List Only For *Moderators/Owners!*_
_Its Means, Only Group *Moderators/Owners* Can Use It!_

--|@SegretoTeam|--]]

elseif lang then

text = [[
*دستورات ربات :*

*ادمین گروه* `[username|id|reply]` 
افزودن ادمین گروه(درصورت اینکه ربات سازنده  گروه)

*حذف ادمین گروه* `[username|id|reply]` 
حذف ادمین گروه(درصورت اینکه ربات سازنده  گروه)

*مالک* `[username|id|reply]` 
انتخاب مالک گروه(قابل انتخاب چند مالک)

*حذف مالک* `[username|id|reply]` 
 حذف کردن فرد از فهرست مالکان گروه
 
*مدیر* `[username|id|reply]` 
ارتقا مقام کاربر به مدیر گروه

*حذف مدیر* `[username|id|reply]` 
تنزیل مقام مدیر به کاربر

*تنظیم پیام مکرر* `[2-50]`
تنظیم حداکثر تعداد پیام مکرر

*سکوت* `[username|id|reply]` 
بیصدا کردن کاربر در گروه

*!حذف سکوت* `[username|id|reply]` 
در آوردن کاربر از حالت بیصدا در گروه

*!اخراج* `[username|id|reply]` 
حذف کاربر از گروه

*!بن* `[username|id|reply]` 
مسدود کردن کاربر از گروه

*!حذف بن* `[username|id|reply]` 
در آوردن از حالت مسدودیت کاربر از گروه

*کاربری* `[username]`
نمایش شناسه کاربر

*ایدی* `[reply]`
نمایش شناسه کاربر

*شناسه* `[id]`
نمایش نام کاربر, نام کاربری و اطلاعات حساب
----------------
*قفل* `[لینک | ورود | تگ | ویرایش | عربی | وب | ربات |هرزنامه | پیام مکرر | فونت | فراخوانی | سنجاق|همه | تصاویر متحرک | عکس | اسناد | برچسب | صفحه کلید | فیلم | متن | نقل قول | موقعیت | اهنگ | صدا | مخاطب | کیبورد شیشه ای|بازی|خدمات تلگرام|]`
در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد

*باز* `[لینک | ورود | تگ | ویرایش | عربی | وب | ربات |هرزنامه | پیام مکرر | فونت | فراخوانی | سنجاق|همه | تصاویر متحرک | عکس | اسناد | برچسب | صفحه کلید | فیلم | متن | نقل قول | موقعیت | اهنگ | صدا | مخاطب | کیبورد شیشه ای|بازی|خدمات تلگرام|]`
در صورت قفل نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد
----------------
*زمان بیصدا* `(ساعت) (دقیقه) (ثانیه)`
بیصدا کردن گروه با ساعت و دقیقه و ثانیه 
*ساعت بیصدا* `(عدد)`
بیصدا کردن گروه در ساعت 
*دقیقه بیصدا* `(عدد)`
بیصدا کردن گروه در دقیقه 
*ثانیه بیصدا* `(عدد)`
بیصدا کردن گروه در ثانیه 

*تنظیم*`[قوانین | نام | لینک | درباره | خوشآمد]`
ربات آنهارا ثبت خواهد کرد

*پاک کردن* `[بن | مدیران | ربات | قوانین | درباره | لیست سکوت | خوشآمد]`   
ربات آنهارا پاک خواهد کرد

*لیست سفید* `[+|-]`
افزودن افراد به لیست سفید

*فیلتر* `[کلمه]`
فیلتر‌کلمه مورد نظر

*حذف فیلتر* `[کلمه]`
ازاد کردن کلمه مورد نظر

*سنجاق* `[reply]`
ربات پیام شمارا در گروه سنجاق خواهد کرد

*حذف سنجاق* 
ربات پیام سنجاق شده در گروه را حذف خواهد کرد

*!خوشآمد فعال/غیرفعال*
فعال یا غیرفعال کردن خوشآمد گویی

*تنظیمات*
نمایش تنظیمات گروه

*دستورات* `[کاربر | مدیر | مالک]`	
نتخاب کردن قفل cmd بر چه مدیریتی

*لیست بیصدا*
نمایش فهرست بیصدا های گروه

*لیست بیصدا*
نمایش فهرست افراد بیصدا

*فیلتر لیست*
نمایش لیست کلمات فیلتر شده

*لیست سفید*
نمایش افراد سفید شده از گروه

*لیست بن*
نمایش افراد مسدود شده از گروه

*لیست مالکان*
نمایش فهرست مالکان گروه 

*لیست مدیران* 
نمایش فهرست مدیران گروه

*قوانین*
نمایش قوانین گروه

*درباره*
نمایش درباره گروه

*ایدی*
نمایش شناسه شما و گروه

*اطلاعات گروه*
نمایش اطلاعات گروه

*لینک جدید*
ساخت لینک جدید

*لینک جدید خصوصی*
ساخت لینک جدید در پیوی

*لینک*
نمایش لینک گروه

*لینک خصوصی*
ارسال لینک گروه به چت خصوصی شما

*زبان انگلیسی*
تنظیم زبان انگلیسی

*!تنظیم خوشآمد [متن]*
ثبت پیام خوش آمد گویی
----------------
این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!
*موفق باشید ;)*]]
end
return text
end
--------------------- Welcome -----------------------
	if (matches[1]:lower() == "welcome" or matches[1] == 'خوشآمد') and is_mod(msg) then
	if not lang then
		if matches[2] == "enable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "enable" then
				return "Group *welcome* Is Already *Enable* "..Segreto..""
			else
		data[tostring(chat)]['settings']['welcome'] = "enable"
	    save_data(_config.moderation.data, data)
				return "Group *welcome* Has Been *Enable* "..Segreto..""
			end
		end
		
		if matches[2] == "disable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "disable" then
				return "Group *welcome* Is Already *Disable* "..Segreto..""
			else
		data[tostring(chat)]['settings']['welcome'] = "disable"
	    save_data(_config.moderation.data, data)
				return "Group *welcome* Has Been *Disable* "..Segreto..""
			end
		end
		else
				if matches[2] == "فعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "enable" then
				return "_خوشآمد گویی از قبل فعال بود_ "..Segreto..""
			else
		data[tostring(chat)]['settings']['welcome'] = "enable"
	    save_data(_config.moderation.data, data)
				return "_خوشآمد گویی فعال شد_ "..Segreto..""
			end
		end
		
		if matches[2] == "غیرفعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "disable" then
				return "_خوشآمد گویی از قبل فعال نبود_ "..Segreto..""
			else
		data[tostring(chat)]['settings']['welcome'] = "disable"
	    save_data(_config.moderation.data, data)
				return "_خوشآمد گویی غیرفعال شد_ "..Segreto..""
			end
		end
		end
	end
	if (matches[1]:lower() == "setwelcome" or matches[1] == 'تنظیم خوشآمد') and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "*Welcome Message Has Been Set To :*\n"..matches[2].."\n\n*You can use :*\n`{gpname}` *Group Name*\n`{rules}` *Show Group Rules*\n`{time}` *Show time english*\n`{date}` *Show date english*\n`{timefa}` *Show time persian*\n`{datefa}` *Show date persian*\n`{name}` *New Member First Name*\n`{username}` *New Member Username* "..Segreto..""
       else
		return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{time} ➣ ساعت به زبان انگلیسی _\n_{date} ➣ تاریخ به زبان انگلیسی _\n_{timefa} ➣ ساعت به زبان فارسی _\n_{datefa} ➣ تاریخ به زبان فارسی _\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_ "..Segreto..""
        end
     end
	end
end
end
local checkmod = true
-----------------------------------------
local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
	checkmod = false
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdcli.sendMessage(msg.to.id, 0, 1, '*First Add Me To* `Admins` 😐 '..Segreto..'', 1, "md")
			else
				return tdcli.sendMessage(msg.to.id, 0, 1, '*First Add Me To* `Admins` 😐 '..Segreto..'', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://irapi.ir/time/')
          if res ~= 200 then return "No connection" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome My Friend :)*"
    elseif lang then
     welcome = "_خوش آمدید_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = [[✅ *The Default Rules :*

🔸_Don't Flood._
🔸_Don't Spam._
🔸_Don't Send Link_
🔸_Don't Send Porn Video-Pic_

—|@SegretoTeam|—]]
    elseif lang then
       rules = [[_✅ قوانین پپیشفرض:_

🔸* ارسال پیام مکرر ممنوع.*
🔸 *ارسال اسپم ممنوع.*
🔸* ارسال لینک ممنوع.*
🔸*ارسال عکس و فیلم پورن ممنوع. *


—|@SegretoTeam|—]]
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "enable" then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "enable" then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
	return msg
 end
return {
patterns ={
command .. "([Ii][Dd])$",
command .. "([Aa]dd)$",
command .. "([Rr]em)$",
command .. "([Ii][Dd]) (.*)$",
command .. "([Pp]in)$",
command .. "([Uu]npin)$",
command .. "([Gg]pinfo)$",
command .. "([Ss]etmanager)$",
command .. "([Ss]etmanager) (.*)$",
command .. "([Rr]emmanager)$",
command .. "([Rr]emmanager) (.*)$",
command .. "([Ww]hitelist) ([+-])$",
command .. "([Ww]hitelist) ([+-]) (.*)$",
command .. "([Ww]hitelist)$",
command .. "([Ss]etowner)$",
command .. "([Ss]etowner) (.*)$",
command .. "([Rr]emowner)$",
command .. "([Rr]emowner) (.*)$",
command .. "([Pp]romote)$",
command .. "([Pp]romote) (.*)$",
command .. "([Dd]emote)$",
command .. "([Dd]emote) (.*)$",
command .. "([Mm]odlist)$",
command .. "([Oo]wnerlist)$",
command .. "([Ll]ock) (.*)$",
command .. "([Uu]nlock) (.*)$",
command .. "([Ll]ink)$",
command .. "([Ll]ink) (pv)$",
command .. "([Ss]etlink)$",
command .. "([Ss]etlink) ([https?://w]*.?telegram.me/joinchat/%S+)$",
command .. "([Ss]etlink) ([https?://w]*.?t.me/joinchat/%S+)$",
command .. "([Nn]ewlink)$",
command .. "([Nn]ewlink) (pv)$",  
command .. "([Rr]ules)$",
command .. "([Ss]ettings)$",
command .. "([Mm]utelist)$",
command .. "([Ss]etrules) (.*)$",
command .. "([Aa]bout)$",
command .. "([Ss]etabout) (.*)$",
command .. "([Ss]etname) (.*)$",
command .. "([Cc]lean) (.*)$",
command .. "([Ss]etflood) (%d+)$",
command .. "([Ss]etchar) (%d+)$",
command .. "([Ss]etfloodtime) (%d+)$",
command .. "([Rr]es) (.*)$",
command .. "([Cc]mds) (.*)$",
command .. "([Hh]elp)$",
command .. "([Ss]etlang) (fa)$",
command .. "([Ff]ilter) (.*)$",
command .. "([Uu]nfilter) (.*)$",
command .. "([Ff]ilterlist)$",
command .. "([Cc]onfig)$",
command .. "([Ss]etwelcome) (.*)",
command .. "([Ww]elcome) (.*)$",
command .. '([Ll]ockall) (status)$',
command .. '([Hh]elplock)$',
command .. '([Ll]ocktime) (%d+) (%d+) (%d+)$',
command .. '([Ll]ockhours) (%d+)$',
command .. '([Ll]ockminutes) (%d+)$',
command .. '([Ll]ockseconds) (%d+)$',
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([Ii][Dd])$",
"^([Aa][Dd][Dd])$",
"^([Rr][Ee][Mm])$",
"^([Ii][Dd]) (.*)$",
"^([Pp][Ii][Nn])$",
"^([Uu][Nn][Pp][Ii][Nn])$",
"^([Gg][Pp][Ii][Nn][Ff][Oo])$",
"^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
"^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
"^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-])$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-]) (.*)$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt])$",
"^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr])$",
"^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr])$",
"^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Pp][Rr][Oo][Mm][Oo][Tt][Ee])$",
"^([Pp][Rr][Oo][Mm][Oo][Tt][Ee]) (.*)$",
"^([Dd][Ee][Mm][Oo][Tt][Ee])$",
"^([Dd][Ee][Mm][Oo][Tt][Ee]) (.*)$",
"^([Mm][Oo][Dd][Ll][Ii][Ss][Tt])$",
"^([Oo][Ww][Nn][Ee][Rr][Ll][Ii][Ss][Tt])$",
"^([Ll][Oo][Cc][Kk]) (.*)$",
"^([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)$",
"^([Ll][Ii][Nn][Kk])$",
"^([Ll][Ii][Nn][Kk]) (pv)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk])$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?[Tt].me/joinchat/%S+)$",
"^([Nn][Ee][Ww][Ll][Ii][Nn][Kk])$",
"^([Nn][Ee][Ww][Ll][Ii][Nn][Kk]) (pv)$",  
"^([Rr][Uu][Ll][Ee][Ss])$",
"^([Kk][Oo][Ss][Ss][HH][Ee][Rr])",
"^([Ss][Ee][Tt][Tt][Ii][Nn][Gg][Ss])$",
"^([Ss][Ee][Tt][Rr][Uu][Ll][Ee][Ss]) (.*)$",
"^([Aa][Bb][Oo][Uu][Tt])$",
"^([Ss][Ee][Tt][Aa][Bb][Oo][Uu][Tt]) (.*)$",
"^([Ss][Ee][Tt][Nn][Aa][Mm][Ee]) (.*)$",
"^([Cc][Ll][Ee][Aa][Nn]) (.*)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd]) (%d+)$",
"^([Ss][Ee][Tt][Cc][Hh][Aa][Rr]) (%d+)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd][Tt][Ii][Mm][Ee]) (%d+)$",
"^([Rr][Ee][Ss]) (.*)$",
"^([Cc][Mm][Dd][Ss]) (.*)$",
"^([Hh][Ee][Ll][Pp])$",
"^([Ss][Ee][Tt][Ll][Aa][Nn][Gg]) (fa)$",
"^([Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Uu][Nn][Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Ff][Ii][Ll][Tt][Ee][Rr][Ll][Ii][Ss][Tt])$",
"^([Cc][Oo][Nn][Ff][Ii][Gg])$",
"^([Ss][Ee][Tt][Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)",
"^([Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)",
'^([Mm]uteall) (status)$',
'^([Hh]elplock)$',
'^([Mm]utetime) (%d+) (%d+) (%d+)$',
'^([Mm]utehours) (%d+)$',
'^([Mm]uteminutes) (%d+)$',
'^([Mm]uteseconds) (%d+)$',
},
patterns_fa = {
'^(ایدی)$',
'^(ایدی) (.*)$',
'^(تنظیمات)$',
'^(سنجاق)$',
'^(حذف سنجاق)$',
'^(افزودن)$',
'^(حذف گروه)$',
'^(ادمین گروه)$',
'^(ادمین گروه) (.*)$',
'^(حذف ادمین گروه) (.*)$',
'^(حذف ادمین گروه)$',
'^(لیست سفید) ([+-]) (.*)$',
'^(لیست سفید) ([+-])$',
'^(لیست سفید)$',
'^(مالک)$',
'^(مالک) (.*)$',
'^(حذف مالک) (.*)$',
'^(حذف مالک)$',
'^(مدیر)$',
'^(مدیر) (.*)$',
'^(حذف مدیر)$',
'^(حذف مدیر) (.*)$',
'^(قفل) (.*)$',
'^(باز) (.*)$',
'^(لینک جدید)$',
'^(لینک جدید) (خصوصی)$',
'^(اطلاعات گروه)$',
'^(دستورات) (.*)$',
'^(قوانین)$',
'^(لینک)$',
'^(تنظیم لینک)$',
'^(تنظیم لینک) ([https?://w]*.?telegram.me/joinchat/%S+)$',
'^(تنظیم لینک) ([https?://w]*.?t.me/joinchat/%S+)$',
'^(تنظیم قوانین) (.*)$',
'^(لینک) (خصوصی)$',
'^(کاربری) (.*)$',
'^(تنظیم پیام مکرر) (%d+)$',
'^(تنظیم زمان بررسی) (%d+)$',
'^(حداکثر حروف مجاز) (%d+)$',
'^(پاک کردن) (.*)$',
'^(درباره)$',
'^(تنظیم نام) (.*)$',
'^(تنظیم درباره) (.*)$',
'^(لیست فیلتر)$',
'^(لیست بیصدا)$',
'^(لیست مالکان)$',
'^(لیست مدیران)$',
'^(راهنما)$',
'^(پیکربندی)$',
'^(فیلتر) (.*)$',
'^(حذف فیلتر) (.*)$',
'^(خوشآمد) (.*)$',
'^(تنظیم خوشآمد) (.*)$',
'^(راهنما بیصدا)$',
'^(ساعت بیصدا) (%d+)$',
'^(دقیقه بیصدا) (%d+)$',
'^(ثانیه بیصدا) (%d+)$',
'^(موقعیت) (بیصدا)$',
'^(زمان بیصدا) (%d+) (%d+) (%d+)$',
'^(زبان انگلیسی)$',
'^([https?://w]*.?telegram.me/joinchat/%S+)$',
'^([https?://w]*.?t.me/joinchat/%S+)$'
},
run=run,
pre_process = pre_process
}
