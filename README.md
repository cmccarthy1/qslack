# qslack

The purpose of this repository is to allow kdb users to post from a kdb process to slack channels.

The number of potential use-cases for this are exhastive but the following are some examples:
- Use the post functionality within error trapping flag issues and mention relevant individuals
- Post the results of benchmarks/experiments to a centralised location
- Produce daily reports for a system (post .Q.w[] and other metrics to a monitoring channel)

**Note:** This functionality requires an OAuth `config/token` file to be defined this will be specific to the slack environment of an organisation so must be configured individually and distributed within an organisation. 

## Example

The following is an example of a script which 
- mentions a defined a user
- posts the time that the memory stats were produces
- displays the system memory stats within a code block

```
$vi example.q
\l slack.q

// The following is a function which correctly formats the string 
/* u = mentioned user name
/* c = channel name
notificationfn:{[u;c]
  msg:.slack.mentionUser[u];
  msg,:" please find attached the daily stats."
  msg,:.slack.newLine;
  msg,:"Stats collected at: ",string .z.p;
  msg,:.slack.newLine;
  msg,:.slack.stringify[.Q.w[]];  
  .slack.post[msg;c;"Daily Report";":memo:"]
  -1"Message has been posted";
  }
```

Running this function is completed as follows

```
$q example.q
notificationfn["cmccarthy1";"test_channel"]
"Message has been posted"
```

![Example Output](images/example_image.png?raw=true "Title")
