var clevertap = {event:[], profile:[], account:[], onUserLogin:[], notifications:[], privacy:[]};
		 // replace with the CLEVERTAP_ACCOUNT_ID with the actual ACCOUNT ID value from your Dashboard -> Settings page
clevertap.account.push({"id": "TEST-468-W87-546Z"});
clevertap.privacy.push({optOut: false}); //set the flag to true, if the user of the device opts out of sharing their data
clevertap.privacy.push({useIP: false}); //set the flag to true, if the user agrees to share their IP data
 (function () {
         var wzrk = document.createElement('script');
         wzrk.type = 'text/javascript';
         wzrk.async = true;
         wzrk.src = ('https:' == document.location.protocol ? 'https://d2r1yp2w7bby2u.cloudfront.net' : 'http://static.clevertap.com') + '/js/a.js';
         var s = document.getElementsByTagName('script')[0];
         s.parentNode.insertBefore(wzrk, s);
  })();

function recieveMessage(event) {
  var message = JSON.parse(event.data);
  console.log(event.data)
   const clevertapdata = JSON.parse(event.data);
  console.log(clevertapdata.Type);
  //checking the type of the data recieved from webview if its an event, onuserlogin or profile set data.
    if (JSON.stringify(clevertapdata.Type) == "\"event\""){
     clevertap.event.push(clevertapdata.EventName,clevertapdata.Payload);
      console.log(JSON.stringify(clevertapdata.Type)+"\n"+JSON.stringify(clevertapdata.Payload));
    }
    else if (JSON.stringify(clevertapdata.Type) == "\"onuserlogin\""){
      clevertap.onUserLogin.push({"Site": clevertapdata.Payload});
      console.log(JSON.stringify(clevertapdata.Type)+"\n"+JSON.stringify(clevertapdata.Payload));
    }
    else if (JSON.stringify(clevertapdata.Type) == "\"profilepush\""){
      clevertap.profile.push({"Site": clevertapdata.Payload});
      console.log(JSON.stringify(clevertapdata.Type)+"\n"+JSON.stringify(clevertapdata.Payload));
    }
}
window.addEventListener("message", recieveMessage, false);
//console.log("test")