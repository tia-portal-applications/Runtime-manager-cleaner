# Runtime Manager Cleaner
This tool is intended to **remove** all projects entries in the **WinCC Unified Runtime Manager** automatically. It is not meant to be a faster process, but more that it does it for you so you don't have to manually do all that work. The source code is available in the **sources** folder, so that you can change the tool to your specific needs.

# How to use
**Option #1** - Execute the **\build\RTMngr_Cleaner.exe** file in admin mode.
**Option #2** - Use source script **\sources\RTMngr_Cleaner.bat** and run it in admin mode.

## Requirements and limitations
 - Must be executed in administrator mode
 - Default installation of WinCC Unified (otherwise you have to change references in the source script)
 - Cannot make distinciton between entries type project & simulation

## Principle of operation
This script will **only use existing functions** of the **Runtime Manager CLI*** do acheive this process. It will generate a text file for all the entries of the RT Manager, then transform the content of it into a temporary file. Finally, from this last one,  we can loop through all of the iterations available and send commands to the RT Manager CLI in order to remove the project from the list.

> **Tip:** You can find all available commands of the RT Manager over CLI in the **[manual](https://cache.industry.siemens.com/dl/files/308/109813308/att_1122197/v1/WinCC_VisualizingProcessesUnified_enUS_en-US.pdf#page=7511)** in section 17.4.17.

### Disclaimer
> The examples are non-committal and do not lay any claim to
> completeness with regard to configuration and equipment as well as any
> eventualities. The examples do not represent any custom-designed
> solutions but shall offer only support at typical tasks. 
> 
> You are accountable for the proper mode of the described products
> yourself. These examples do not  discharge you from the obligation to
> safe dealing for application, installation, business and maintenance.
> By use of these examples you appreciate that the author cannot be made
> liable for possible damages beyond the provisions regarding described
> above. 
> 
> We reserve us the right to carry out changes at these examples without
> announcement at any time. The contents of the other documentation have
> priority at deviations between the suggestions in these examples.
