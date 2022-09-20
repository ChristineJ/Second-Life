list layers = ["gloves","jacket","pants","shirt","shoes","skirt","socks","underpants","undershirt","eyes","hair","alpha","tattoo","skin"];
list attachmentpoints = ["chest","skull","left shoulder","right shoulder","left hand","right hand","left foot","right foot","spine",
"pelvis","mouth","chin","left ear","right ear","left eyeball","right eyeball","nose","r upper arm","r forearm",
"l upper arm","l forearm","right hip","r upper leg","r lower leg","left hip","l upper leg","l lower leg","stomach","left pec",
"right pec","neck","root"];

string MESSAGE_SEPERATOR     = "#";

integer LISTEN_TIME = 10;


integer iListenScanChannel = 123;
integer iListenScanHandle;
integer iListenActive = 0;

integer iListenUntil;

integer iScanCounter;
integer iScanCounterTarget;
key kScanRequest;

list lScanFolders;

integer intergerRnd(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));
}

listenStart(){
    if (iListenActive == 0){
        iListenActive = 1;
        iListenScanHandle = llListen(iListenScanChannel,"",llGetOwner(),"");
        llSetTimerEvent(60.0); 
    }

    
    iListenUntil = llGetUnixTime()+LISTEN_TIME;
                        
    
}

listenStop(){
    llListenRemove(iListenScanHandle);
    iListenActive = 0;
    llSetTimerEvent(0.0); 
}

string messageSerialize(list lItems){
    
        while(llGetListLength(lItems) < 2){
            
                lItems += [""];
                
        }
        
        return llDumpList2String(lItems,MESSAGE_SEPERATOR);
        
}



list messageUnserialize(string sMessage){
    
        return llParseStringKeepNulls(sMessage,[MESSAGE_SEPERATOR],[]);
        
}

default{
    
        link_message(integer iSender, integer iNumber, string sMessage, key kID){
            
                list lMessage = messageUnserialize(sMessage);
            
                if(iNumber == 100000){
                        
                        kScanRequest = kID;
                    
                        listenStart();
                        
                        lScanFolders = [];
                        
                        
                        
                        iScanCounter=0;
    
    
                        iScanCounterTarget = llGetListLength(layers) +llGetListLength(attachmentpoints);
                            
                        integer i;
    
                        for(i = 0;i<llGetListLength(layers);i++){
                            llOwnerSay("@getpathnew:"+llList2String(layers,i)+"="+(string)iListenScanChannel);
                            //llSleep(0.1);
                        }
                        
                        for(i = 0;i<llGetListLength(attachmentpoints);i++){
                            llOwnerSay("@getpathnew:"+llList2String(attachmentpoints,i)+"="+(string)iListenScanChannel);
                            //llSleep(0.1);
                        }
                            
                        //llMessageLinked(LINK_THIS,200000,"",kID);
                        
                }else if (iNumber == 100010){
                        
                        integer i;
                        
                        for(i=2;i<llGetListLength(lMessage); i+= 2){
                                
                                if(llList2Integer(lMessage,i+1) == 1){
                                         llOwnerSay("@attachover:"+llList2String(lMessage,i)+"=force");    
                                   }else if(llList2Integer(lMessage,i+1) == 0){
                                         llOwnerSay("@detach:"+llList2String(lMessage,i)+"=force"); 
                                 }
                                
                        }
                        
                }
            
        }
        
        listen( integer iChannel, string sName, key kId, string sMessage ){
                
                if(iChannel == iListenScanChannel){
                        integer i;
            
                        string sFoundFolder;
                        
                        list lFoundFolders =  llParseString2List(sMessage,[","],[""]); 
                        
                        for(i=0;i<llGetListLength(lFoundFolders);i++){

                                sFoundFolder = llList2String(lFoundFolders,i);
                
                                if(sFoundFolder != "" && llListFindList(lScanFolders,[sFoundFolder]) == -1){ //TODO selfreference
                                    lScanFolders += [sFoundFolder];   
                                }
                            
                        }
                        
                        ++iScanCounter;
                        
                        if(iScanCounter == iScanCounterTarget){
                            llOwnerSay(llDumpList2String(lScanFolders,"\n")); 
                            llMessageLinked(LINK_THIS,5003,messageSerialize(lScanFolders),kScanRequest);  
                        }
                }
            
        }
        
        state_entry(){
                llOwnerSay(llGetScriptName()+" reset");
                iListenScanChannel = intergerRnd(1051,2147483000);    
        }

        timer(){
            
            if (iListenUntil < llGetUnixTime()){
                listenStop();
            }
        }
    
}