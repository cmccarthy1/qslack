\d .slack

token:raze read0`:config/token
apiurl:`:https://slack.com/api
url:{` sv apiurl,x}

// Post a message to a channel
/* m = message content, this should be formatted by the user to be 
/*     appropriate for the slack message they wish to send
/* c = channel name to which the message is being sent
/* u = user name to be displayed when sending the message
/* e = emoji that will be displayed beside the user name (warning symbol ":warning:")
post:{[m;c;u;e]
  d:()!(); 
  d[`text]:m;
  d[`channel]:channelId[c];
  d[`as_user]:`false;
  d[`username]:u;
  if[count e;d[`icon_emoji]:e];
  d[`token]:token;
  .Q.hp[url `chat.postMessage;encode_type;encode d];
  }

// encoding must be url-encoded (Issues with sending token for json)
encode_type:"application/x-www-form-urlencoded"

// The purpose of this function is to encode a dictionary into a format appropriate for url encoding
encode:{(raze/)$[1=count x;string[key x],"=",$[10h=type value x;;string]value x;-1_raze((,'/)(string(key;{count[x]#"="};value)@\:x)),'"&"]}

// url-encode the token OAuth token associated with the app
tok:encode (1#`token)!enlist token

// Retrieve all information on public/private channels and all users
i.list:{[x;y].j.k .Q.hp[url x;encode_type;tok]}

channels:i.list[`channels.list;]
groups  :i.list[`groups.list;]
users   :i.list[`users.list;]

// For a given channel name return the channel ID
channelId:{[x]
  x:$[-11=type x;string x;x];
  c:channels[]`channels;
  g:groups[]`groups;
  m:exec name!id from raze `name`id#/:(c;g);
  if[0=count r:m@x;'`$"channel name not found"];
  r
  }

// For a given user name return the user ID
userId:{[x]
  x:$[-11=type x;string x;x];
  u:users[]`members;
  nid:exec name!id from `name`id#/:u;
  if[0=count r:nid@x;'`$"channel name not found"];
  r
  }

// The following are formatting functions for slack posts. 
// In some cases these are aliases for in built kdb functions or are trivial
// but improve readibility for less experienced kdb users

// mention a specific user in a message
mentionUser:{"<@",userId[x],">"}

// format a kdb object for posting
stringify:{.Q.s[x]}

// inline code
inline:{"`",x,"`"}

// create code block
codeBlock:{"```",x,"```"}

// new line
newLine:"\n"
