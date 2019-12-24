\l slack.q

// The following is a function which correctly formats the string 
/* u = mentioned user name
/* c = channel name
notificationfn:{[u;c]
  msg:.slack.mentionUser[u];
  msg,:" please find attached the daily stats.";
  msg,:.slack.newLine;
  msg,:"Stats collected at: ",string .z.p;
  msg,:.slack.newLine;
  msg,:.slack.codeBlock[.slack.stringify[.Q.w[]]];  
  .slack.post[msg;c;"Daily Report";":memo:"]
  -1"Message has been posted";
  }
