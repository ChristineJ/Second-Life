string MESSAGE_SEPERATOR = "#";

integer listenHandle;

integer iChannel = -83313382;

integer iRequest = -1;

string messageSerialize(list lItems){
    return llDumpList2String(lItems,MESSAGE_SEPERATOR);
}

list messageUnserialize(string sMessage){
        list l = llParseStringKeepNulls(sMessage,[MESSAGE_SEPERATOR],[]);
        if(llList2String(l,0) == ""){
            return [];
        }
        return l;
        
}

key request(integer iCode,list lParameter,key kKey){
    
        llOwnerSay((string)iCode+": "+messageSerialize(lParameter));
        llMessageLinked(LINK_THIS,iCode,messageSerialize(lParameter),kKey);
        return kKey;
        
}

default
{
    state_entry()
    {
        listenHandle = llListen(iChannel, "",NULL_KEY, "");
    }
    
    link_message(integer iSender, integer iNumber, string sMessage, key kID){
        if(iNumber == 2000 && iRequest == 1000){
            llRegionSayTo(kID,iChannel,"CJOS_REMOTE#2000#"+sMessage);
        }else if(iNumber == 2101 && iRequest == 1101){
            llOwnerSay("Outfit change requested");
            list lMessage = messageUnserialize(sMessage);
            request(100010,lMessage,kID);
        }
    }
    
    listen( integer channel, string name, key id, string message )
    {
        if(llGetOwner() == llGetOwnerKey(id)){
            list commands = llParseStringKeepNulls(message,["#"],[]);
            if(llList2String(commands,0) == "CJOS_REMOTE"){
                iRequest = llList2Integer(commands,1);
                //llMessageLinked(LINK_THIS,iRequest,messageSerialize(llList2List(commands,2,-1)),id);
                request(iRequest,llList2List(commands,2,-1),id);
            }
        }
    }
}
