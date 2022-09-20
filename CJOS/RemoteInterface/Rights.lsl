string MESSAGE_SEPERATOR = "#";

integer listenHandle;

integer iChannel = -83313382;
integer iOwnerDialogChannel = 83313382;
integer iOwnerDialogHandle;
integer iOwnerDialogTil = -1;

integer iOperatorChannel = 83313383;
integer iOperatorDialogHandle;
integer iOperatorDialogTil = -1;

integer MODE_OPEN = 2;
integer MODE_ASK = 1;
integer MODE_FRIENDS = 0;
integer MODE_CLOSED = -1;

integer iMode = 0;

integer RIGHT_ADMIN = 2;
integer RIGHT_OPERATOR = 1;
integer RIGHT_NONE = 0;
integer RIGHT_BANNED = -1;

list lFriends = [];
list lTemp = [];
list lBanned = [];
list lTempBanned = [];

integer iTempTime = 10; // Default: 3600

integer iTimerTime = 2; // Default: 300

key kRequestingAvatar;

list lFolders;


interaction(key kAvatar){
    string sName = llGetUsername(kAvatar);
    string sNameShorthand = llGetSubString(sName,0,10);
    integer iRights = rights(kAvatar);
    if(iRights == RIGHT_NONE){
        
        kRequestingAvatar = kAvatar;
        
        llListenRemove(iOwnerDialogHandle);
        iOwnerDialogHandle = llListen(iOwnerDialogChannel,"",llGetOwner(),"");
        iOwnerDialogTil = llGetUnixTime() + 600;
        
        llDialog(llGetOwner(),sName+" requests access",["Ban (Temp)   "+sNameShorthand," ","Ban (Perm)   "+sNameShorthand,"Add (Temp)   "+sNameShorthand," ","Add (Perm)   "+sNameShorthand],iOwnerDialogChannel);
    }else if(iRights == RIGHT_ADMIN || iRights == RIGHT_OPERATOR){
        sendRemoteDialog(kAvatar);
    }

}

openOperatorListen(){
    llListenRemove(iOperatorDialogHandle);
    iOperatorDialogHandle = llListen(iOperatorChannel,"",NULL_KEY,"");
    iOperatorDialogTil = llGetUnixTime() + 600;
}

integer rights(key kAvatar){
    if(kAvatar == llGetOwner()){
        return RIGHT_ADMIN;
    }
    
    if(llListFindList(lBanned,[kAvatar]) > -1){
        return RIGHT_BANNED;
    }
    
    integer iTempPositionBanned = llListFindList(lTempBanned,[kAvatar]);
    if(iTempPositionBanned > -1){
        if(llGetUnixTime() <= llList2Integer(lTempBanned,iTempPositionBanned + 1)){
            return RIGHT_BANNED;
        }
        else
        {
            lTempBanned = llDeleteSubList(lTempBanned,iTempPositionBanned,iTempPositionBanned+1);
        }
    }
    
    if(llListFindList(lFriends,[kAvatar]) > -1){
        return RIGHT_OPERATOR;
    }
    
    integer iTempPosition = llListFindList(lTemp,[kAvatar]);
    if(iTempPosition > -1){
        if(llGetUnixTime() <= llList2Integer(lTemp,iTempPosition + 1)){
            return RIGHT_OPERATOR;
        }
        else
        {
            lTemp = llDeleteSubList(lTemp,iTempPosition,iTempPosition+1);
        }
    }
    
    return RIGHT_NONE;
}

sendRemoteDialog(key kTarget){
    kRequestingAvatar = kTarget;
    llRegionSayTo(llGetOwner(),iChannel, "CJOS_REMOTE#1000");
}

showRemoteDialog(){
    string sCaption = "Select a compilation to apply:\n";
    list lButtons = [];
    
    integer i;
    
    for(i=0; i < llGetListLength(lFolders);i++){
        sCaption += (string)(i+1)+": "+llList2String(lFolders,i)+"\n";
        lButtons += [ (string)(i+1) ];
    }
    openOperatorListen();
    llDialog(kRequestingAvatar,sCaption,lButtons,iOperatorChannel);
}

default
{
    
    state_entry()
    {
        llSetTimerEvent(iTimerTime);
        listenHandle = llListen(iChannel, "",NULL_KEY, "");
    }
    
    listen( integer channel, string name, key id, string message )
    {
        if(channel == iChannel){
            list cmd = llParseString2List(message,["#"],[""]);
            string sCommandId = llList2String(cmd,0);
            integer iResponseCode = llList2Integer(cmd,1);
                        
            if(iResponseCode == 2000){
                lFolders = llList2List(cmd,2,-1);
                showRemoteDialog();
            }
            else if(iResponseCode == 1){
                key kRequestingAvatar = llList2Key(cmd, 2);
                interaction(kRequestingAvatar);
            }
        }
        else if(channel == iOperatorChannel)
        {
            key kAvatar = id;
            integer iRights = rights(kAvatar);
            llOwnerSay("Rights:"+(string)iRights);
            if(iRights == RIGHT_ADMIN || iRights == RIGHT_OPERATOR){
                list lCommands = llParseString2List(message,[":"],[""]);
                
                integer index = llList2Integer(lCommands,0) - 1;
                
                llRegionSayTo(llGetOwner(),iChannel, "CJOS_REMOTE#1101#-#"+(string)index);
            }
        }
        else if(channel == iOwnerDialogChannel)
        {
            list cmd = llParseString2List(message,[" "],[""]);
            string sCommand = llList2String(cmd,0);
            string sTime = llList2String(cmd,1);
            string sId = llList2String(cmd,2);
            
            string sName = llGetUsername(kRequestingAvatar);
            string sNameShorthand = llGetSubString(sName,0,10);
            
            if(sId == sNameShorthand){
                if(sCommand == "Add"){
                    if(sTime == "(Perm)"){
                        lFriends += [kRequestingAvatar];
                    }else if(sTime == "(Temp)"){
                        lTemp += [kRequestingAvatar, llGetUnixTime() + iTempTime];
                        llOwnerSay("asdasd");
                    }
                    sendRemoteDialog(kRequestingAvatar);
                }else if(sCommand == "Ban"){
                    if(sTime == "(Perm)"){
                        lBanned += [kRequestingAvatar];
                    }else if(sTime == "(Temp)"){
                        lTempBanned += [kRequestingAvatar, llGetUnixTime() + iTempTime];
                    }
                }
            }
        }
    }
    
    timer(){
        integer iNow = llGetUnixTime();
        // Remove listeners
        if(iOwnerDialogTil > 0 && iNow > iOwnerDialogTil){
            llListenRemove(iOwnerDialogHandle);
            iOwnerDialogTil = -1;
        }
        if(iOperatorDialogTil > 0 && iNow > iOperatorDialogTil){
            llListenRemove(iOperatorDialogHandle);
            iOperatorDialogTil = -1;
        }
        // Remove temp entries
        if(llGetListLength(lTempBanned) > 0 && iNow > llList2Integer(lTempBanned,1)){
            lTempBanned = llDeleteSubList(lTempBanned,0,1); 
        }
        if(llGetListLength(lTemp) > 0 && iNow > llList2Integer(lTemp,1)){
            lTemp = llDeleteSubList(lTemp,0,1); 
        }
    }

    touch_start(integer total_number)
    {
        key kAvatar = llDetectedKey(0);
        interaction(kAvatar);
    }
}
