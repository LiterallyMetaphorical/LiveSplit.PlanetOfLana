state("Planet of Lana")
{
    int loading: "UnityPlayer.dll", 0x19B2260;
}

startup
  {
    vars.startTimeOffset = -41.50f;

		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Planet of Lana",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

init
{
    vars.setStartTime = false;
}

onStart
{
    vars.setStartTime = true;
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

isLoading
{
    return current.loading == 1;
}

gameTime 
{
    if(vars.setStartTime)
    {
        vars.setStartTime = false;
        return TimeSpan.FromSeconds(vars.startTimeOffset);
    }
}  

start
{
    return old.loading == 1 && current.loading == 2;
}

exit
{
	timer.IsGameTimePaused = true;
}

update
{
//DEBUG CODE 
//print(current.loading.ToString()); 
//print(current.pauseStatus.ToString()); 
//print("Current Mission is " + current.mission.ToString());
//print(modules.First().ModuleMemorySize.ToString());
}