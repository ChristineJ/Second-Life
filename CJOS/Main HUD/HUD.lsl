string MESSAGE_SEPERATOR     = "#";

vector BUTTON_SIZE            = <0.2,0.03,0.05>;

key kIDMainMenu;
key kIDDressCompilation;
key kIDEditCompilation;

integer iListenChannel = 123;

integer modeEdit;
integer modeShow = 1;

integer editOutfitID;

integer editCompilationID;

integer editMode;

vector buttonSize        = <0.25,0.03,0.05>;
vector buttonOffset        = <0,-0.032,0>;
vector buttonPosStart    = <-0.05,0,0>;

vector buttonColor        = <1,1,1>;

vector captionOffset    = <0,-0.022,-1>;
vector captionColor        = <0,0,0>;

vector editOffset        = <-0.25,0,0>;

integer iDetached;

list lPrimsShown;

vector buttonPosition(integer index){
    return <-0.05,-0.035*(index),0>;
}

clearButton(integer id){
    
        
        primHide(id+10);
        primHide(id+30);
        primHide(id+50);
        
        /*llSetLinkPrimitiveParamsFast(id+10,[
                                                PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                PRIM_POS_LOCAL,    <0,0,-1>,
                                                PRIM_SIZE,        <0.005,0.005,0.005>,
                                                PRIM_TEXT,        "",        <0,0,0>,    0
                                        ]);
                                        
        llSetLinkPrimitiveParamsFast(id+30,[
                                                PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                PRIM_POS_LOCAL,    <0,0,-1>,
                                                PRIM_SIZE,        <0.005,0.005,0.005>,
                                                PRIM_TEXT,        "",        <0,0,0>,    0
                                        ]);
                                        
                                        
        llSetLinkPrimitiveParamsFast(id+50,[
                                                PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                PRIM_POS_LOCAL,    <0,0,-1>,
                                                PRIM_SIZE,        <0.005,0.005,0.005>,
                                                PRIM_TEXT,        "",        <0,0,0>,    0
                                        ]);*/
    
}




drawMainMenu(list lItems){
        
        integer i;
        
        
        
        vector position;
        
        position = buttonPosStart;
        
        /*llSetLinkPrimitiveParamsFast(4,[
                                                PRIM_COLOR,            ALL_SIDES,    buttonColor,    1,
                                                PRIM_POS_LOCAL,       position,
                                                PRIM_SIZE,            buttonSize    ,
                                                PRIM_TEXTURE,        ALL_SIDES,    TEXTURE_BLANK, <1,1,1>, <0,0,0>,0
                                        ]);
                                        
                                        
        llSetLinkPrimitiveParamsFast(5,[
                                        PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    1,
                                        PRIM_POS_LOCAL,    position+captionOffset,
                                        PRIM_SIZE,        <0.005,0.005,0.005>,
                                        PRIM_TEXT,        "VVV",        captionColor,    1
                                ]);*/
                                
        if(modeShow == 0){                   
            llSetLinkPrimitiveParamsFast(5,[
                                            PRIM_TEXT,        "VVV",        captionColor,    1
                                    ]);  
        }else{
            llSetLinkPrimitiveParamsFast(5,[
                                            PRIM_TEXT,        "^^^",        captionColor,    1
                                    ]); 
        }       
        
        
        for(i=0; i<20; i++){
                   
                   if(i< llGetListLength(lItems) && modeShow == 1){
                   
                        position = buttonPosStart + buttonOffset*(i+1);
                        
                        if(modeEdit == 1){
                                primShow(i+50);
                                llSetLinkPrimitiveParamsFast(i+50,[
                                                            PRIM_COLOR,        ALL_SIDES,     <1,1,1>,    1,
                                                            PRIM_POS_LOCAL,    position,
                                                            PRIM_SIZE,        buttonSize,
                                                            PRIM_TEXTURE,        ALL_SIDES, "7b9720b5-7d6e-ef93-5819-2223d0ce3be2", <1,1,1>, <0,0,0>, 0 
                                                    ]);    
                            
                                position += editOffset;
                        }else{
                                primHide(i+50);    
                        }
                        
                        primShow(i+10);
                        llSetLinkPrimitiveParamsFast(i+10,[
                                                        PRIM_COLOR,            ALL_SIDES,    buttonColor,    1,
                                                        PRIM_POS_LOCAL,       position,
                                                        PRIM_SIZE,            buttonSize    ,
                                                        PRIM_TEXTURE,        ALL_SIDES,    TEXTURE_BLANK, <1,1,1>, <0,0,0>,0
                                                ]);
                                                
                        primShow(i+30);                                                
                        llSetLinkPrimitiveParamsFast(i+30,[
                                                        PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                        PRIM_POS_LOCAL,    position+captionOffset,
                                                        PRIM_SIZE,        <0.005,0.005,0.005>,
                                                        PRIM_TEXT,        llList2String(lItems,i),        captionColor,    1
                                                ]);
                //7b9720b5-7d6e-ef93-5819-2223d0ce3be2
                
                    
                                                
                   }else{
                           primHide(i+10);
                           primHide(i+30);
                           primHide(i+50);
                           //clearButton(i);    
                   }
            
        }
        
        position = buttonPosStart + buttonOffset*(llGetListLength(lItems)+1);
        
        if(modeShow == 1){
                if(modeEdit == 1){
                        
                        primShow(8);
                        llSetLinkPrimitiveParamsFast(8,[
                                                        PRIM_COLOR,            ALL_SIDES,    buttonColor,    1,
                                                        PRIM_POS_LOCAL,       position,
                                                        PRIM_SIZE,            buttonSize    ,
                                                        PRIM_TEXTURE,        ALL_SIDES,    TEXTURE_BLANK, <1,1,1>, <0,0,0>,0
                                                ]);
                                                
                             
                        primShow(9);                   
                        llSetLinkPrimitiveParamsFast(9,[
                                                        PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                        PRIM_POS_LOCAL,    position+captionOffset,
                                                        PRIM_SIZE,        <0.005,0.005,0.005>,
                                                        PRIM_TEXT,        "+",        captionColor,    1
                                                ]);
                                                
                         position += buttonOffset;  
                         
                         primShow(6);
                         llSetLinkPrimitiveParamsFast(6,[
                                                        PRIM_COLOR,            ALL_SIDES,    <1,0,0>,    1,
                                                        PRIM_POS_LOCAL,       position,
                                                        PRIM_SIZE,            buttonSize    ,
                                                        PRIM_TEXTURE,        ALL_SIDES,    TEXTURE_BLANK, <1,1,1>, <0,0,0>,0
                                                ]);
                                                
                              
                        primShow(7);                  
                        llSetLinkPrimitiveParamsFast(7,[
                                                        PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                        PRIM_POS_LOCAL,    position+captionOffset,
                                                        PRIM_SIZE,        <0.005,0.005,0.005>,
                                                        PRIM_TEXT,        "Edit",        captionColor,    1
                                                ]);                         
                                                
                }else{
                    primShow(6);
                    llSetLinkPrimitiveParamsFast(6,[
                                                        PRIM_COLOR,            ALL_SIDES,    <1,1,1>,    1,
                                                        PRIM_POS_LOCAL,       position,
                                                        PRIM_SIZE,            buttonSize    ,
                                                        PRIM_TEXTURE,        ALL_SIDES,    TEXTURE_BLANK, <1,1,1>, <0,0,0>,0
                                                ]);
                                                
                    
                    primShow(7);                            
                    llSetLinkPrimitiveParamsFast(7,[
                                                    PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                    PRIM_POS_LOCAL,    position+captionOffset,
                                                    PRIM_SIZE,        <0.005,0.005,0.005>,
                                                    PRIM_TEXT,        "Edit",        captionColor,    1
                                            ]); 
                                            
                     primHide(8);
                     primHide(9);                      
                      
                
                }
        }else{
                primHide(6);
                primHide(7); 
                primHide(8);
                primHide(9); 
        }
        //drawButton(160,buttonPosition(llGetListLength(lItems)),BUTTON_SIZE,<1,1,0>,"+",<0,0,0>);
        
}

primHide(integer id){
        
        integer iPos = llListFindList(lPrimsShown,[id]);
        
        if(iPos >= 0){
    
                llSetLinkPrimitiveParamsFast(id,[
                                                        PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                        PRIM_POS_LOCAL,    <0,0,-1>,
                                                        PRIM_SIZE,        <0.005,0.005,0.005>,
                                                        PRIM_TEXT,        "",        <0,0,0>,    0
                                                ]);    
                                                
                lPrimsShown = llDeleteSubList(lPrimsShown,iPos,iPos);
                                                
        }
}

primShow(integer id){
        
        integer iPos = llListFindList(lPrimsShown,[id]);
        
        if(iPos == -1){
            
                lPrimsShown +=  [id];    
            
        }
        
}


string messageSerialize(list lItems){
    
        while(llGetListLength(lItems) < 2){
            
                lItems += [""];
                
        }
        
        return llDumpList2String(lItems,MESSAGE_SEPERATOR);
        
}



list messageUnserialize(string sMessage){
        list l = llParseStringKeepNulls(sMessage,[MESSAGE_SEPERATOR],[]);
        if(llList2String(l,0) == ""){
            return [];
        }
        return l;
        
}



key request(integer iCode,list lParameter){
    
        key kKey = llGenerateKey();
        llMessageLinked(LINK_THIS,iCode,messageSerialize(lParameter),kKey);
        return kKey;
        
}

integer intergerRnd(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));
}

default{
    
    attach(key id){
        if(id == NULL_KEY){
                iDetached = 1;    
        }else{
                if(iDetached == 1){
                        kIDDressCompilation = request(1101,["",0]);
                }
                iDetached = 0;
        }
    }
    
    changed(integer iChange){
        
        if (iChange & CHANGED_OWNER)
        {
            llResetScript();
        }
    
    }
    
    
    listen( integer iChannel, string sName, key kId, string sMessage ){
            
            
            if(iChannel == iListenChannel){
                    if(editMode == 1){
                        request(3001,["Unnamed","",sMessage]);
                    }else if(editMode == 2){
                        request(3001,["",editOutfitID,sMessage]);
                    }else if(editMode == 6){
                            if(sMessage == "DELETE"){
                                    request(3002,["",editOutfitID]);
                            }    
                    }
                    
            }
            
            
    }
    
    
    link_message(integer iSender, integer iNumber, string sMessage, key kID){
        
            
            
        
            list lMessage = messageUnserialize(sMessage);
            
            if(iNumber == 2000){
                
                    if(kID == kIDMainMenu){
                        
                            drawMainMenu(lMessage);        
                        
                    }
                
            }else if(iNumber == 2100){
                    //folderlist for edititing
                    
                    integer i;
                    vector position;
                    
                    for(i=0;i<llGetListLength(lMessage);i++){
                        
                        position = buttonPosStart + buttonOffset*(i+1)+editOffset*2+<-0.05,0,0>;
                        
                        if(i>=20){
                            position = buttonPosStart + buttonOffset*(i-19)+editOffset*3+<-0.10,0,0>;
                        }
                        
                        primShow(i+70);
                        llSetLinkPrimitiveParamsFast(i+70,[
                                                            PRIM_COLOR,            ALL_SIDES,    buttonColor,    1,
                                                            PRIM_POS_LOCAL,       position,
                                                            PRIM_SIZE,            buttonSize    ,
                                                            PRIM_TEXTURE,        ALL_SIDES,    TEXTURE_BLANK, <1,1,1>, <0,0,0>,0
                                                    ]);
                                                    
                                
                        primShow(i+110);                    
                        llSetLinkPrimitiveParamsFast(i+110,[
                                                        PRIM_COLOR,        ALL_SIDES,     <0,0,0>,    0,
                                                        PRIM_POS_LOCAL,    position+captionOffset,
                                                        PRIM_SIZE,        <0.005,0.005,0.005>,
                                                        PRIM_TEXT,        llList2String(llParseString2List(llList2String(lMessage,i),["/"],[]),-1),        captionColor,    1
                                                ]);
                                                
                                                
                        primShow(i+150);                          
                        llSetLinkPrimitiveParamsFast(i+150,[
                                                            PRIM_COLOR,        ALL_SIDES,     <1,1,1>,    1,
                                                            PRIM_POS_LOCAL,    position+<buttonSize.x*0.60,0,0>,
                                                            PRIM_SIZE,        <buttonSize.x/5,buttonSize.y,buttonSize.z>,
                                                            PRIM_TEXTURE,        ALL_SIDES, "7b9720b5-7d6e-ef93-5819-2223d0ce3be2", <0.17000,1,1>, <0.40999,0,0>, 0 
                                                    ]);    
                    
                    }
                    for(i=llGetListLength(lMessage);i<40;i++){
                            primHide(i+70);
                            primHide(i+110);
                            primHide(i+150);
                    }
            }else if(iNumber == 2101){
                    //llOwnerSay(llDumpList2String(lMessage,"\n"));
                    
                    if(kID == kIDDressCompilation){
                            request(100010,lMessage);
                    }else if(kID == kIDEditCompilation){
                            integer i;
                            vector color;
                            for(i=1;i*2<llGetListLength(lMessage);i++){ //don't start with 0 since 0 and 1 describe the compilation
                                    
                                    if(llList2Integer(lMessage,i*2+1) == 0){
                                            color = <1,0,0>;
                                                    
                                    }else if(llList2Integer(lMessage,i*2+1) == 1){
                                            color = <0,1,0>;
                                    }else{
                                            color = <0,0,1>;
                                    }
                                    
                                    llSetLinkPrimitiveParamsFast(i+69,[
                                                            PRIM_COLOR,            ALL_SIDES,    color,    1
                                                    ]);
                                    
                            }
                    }
            }else if(iNumber == 4001){
                    //Rename Success, request new menu or 
                    kIDMainMenu = request(1000,[]);
                    request(1100,[]);
            }else if(iNumber == 4002 || iNumber == 4003){
                    //delete success or reorder success
                    kIDMainMenu = request(1000,[]);
            }else if(iNumber == 6002){
                    request(1100,[]);
            }else if(iNumber == 6003){
                    
                    //Request for renaming a compilation
                    
                    //kIDMainMenu = request(1000,[]);
                    editMode = 1;
                    llTextBox(llGetOwner(),"Please enter a name for the new compilation",iListenChannel);
            }else if(iNumber == 6004){
                    kIDEditCompilation = request(1101,["",editCompilationID]);
            }
             
    }
        
    
    state_entry(){
            iListenChannel = intergerRnd(1051,2147483000);
        
            llOwnerSay(llGetScriptName()+" reset");
            
            
            kIDMainMenu = request(1000,[]);
            
            
            llListen(iListenChannel,"",llGetOwner(),"");
                   
    }
    
    touch_start(integer det){
        //drawMainMenu(["Test","Test2"]);
        integer iPrim = llDetectedLinkNumber(0);
           
        if(iPrim == 8){
                //Add compilation
                request(100000,[]);
                
        }else if(iPrim >= 10 && iPrim <30){
                
                if(modeEdit == 0){
                
                        kIDDressCompilation = request(1101,["",iPrim-10]);
                        
                        llSetLinkPrimitiveParamsFast(llDetectedLinkNumber(0),[
                                                        PRIM_COLOR,        ALL_SIDES,    <0,1,0>,    1]);
                                                        
                        llSleep(0.3);
                                                                
                        llSetLinkPrimitiveParamsFast(llDetectedLinkNumber(0),[
                                                                PRIM_COLOR,        ALL_SIDES,    <1,1,1>,    1]);
                }else{
                        editCompilationID = iPrim-10;
                        kIDEditCompilation = request(1101,["",editCompilationID]);
                }
        }else if(iPrim >= 50 && iPrim <70){
                vector tPos = llDetectedTouchUV(0);
                
                editOutfitID = iPrim -50;
                
                if(tPos.x <0.2){
                    llTextBox(llGetOwner(),"Please enter a new name for this outfit",iListenChannel);
                    
                    editMode = 2;
                }else if(tPos.x >= 0.2 && tPos.x <0.4){
                    llOwnerSay("Refresh");
                }else if(tPos.x >= 0.4 && tPos.x <0.6){
                    request(3003,["",iPrim-50,"",iPrim-49]);
                }else if(tPos.x >= 0.6 && tPos.x <0.8){
                    if(iPrim > 50){
                        request(3003,["",iPrim-51,"",iPrim-50]);
                    }
                }else if(tPos.x >= 0.8){
                    //Delete
                    llDialog(llGetOwner(),"Are you sure you want to delete this outfit?",["DELETE","Cancel"],iListenChannel);
                    editMode = 6;
                }
                
                
        }else if(iPrim == 4){
            modeShow = !modeShow;
            kIDMainMenu = request(1000,[]);
            if(modeEdit == 1){
                    modeEdit = 0;
                    integer i;
                    for(i = 70;i<110;i++){
                        primHide(i);
                        primHide(i+40);
                        primHide(i+80);
                }    
            }
        }else if(iPrim == 6){
            modeEdit = !modeEdit;
            kIDMainMenu = request(1000,[]);
            if(modeEdit == 1){
                request(1100,[]);
            }else{
                integer i;
                for(i = 70;i<110;i++){
                        primHide(i);
                        primHide(i+40);
                        primHide(i+80);
                }    
            }
        }else if(iPrim >= 70 && iPrim <110){
                
                request(5004,["",iPrim-70,"",editCompilationID]);
                
        }else if(iPrim >= 150 && iPrim <190){
                request(5002,["",iPrim-150]);
            
        }
        
        
    }
    
        
}