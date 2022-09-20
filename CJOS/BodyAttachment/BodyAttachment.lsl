integer iChannel = -83313382;

default
{

    touch_start(integer total_number)
    {
        key kAvatar = llDetectedKey(0);
        llRegionSayTo(llGetOwner(),iChannel, "CJOS_REMOTE#1#"+(string)kAvatar);
    }
}