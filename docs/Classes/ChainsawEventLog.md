# ChainsawEventLog

## Help Documentation

## Synopsis

This target will write to the Windows Event Log.

## Description

Config Template:
{
    "Chainsaw" : {
        "EventLog" : {
            "Levels" : [
                "Warning",
                "Error"
            ],
            "LogName" : "Application",
            "Source" : "Chainsaw"
        }
    }
}
In order to use this target you will need to initalize the log as an administrator ahead of time.  To do so 

## Example

```PowerShell
$LogName = "Application"

$Source = "Chainsaw"

$Levels = @("Information", "Warning", "Error", "Debug")

$eventlog = [ChainsawEventLog]::new()

$eventlog.LogName = $LogName

$eventlog.Source = $Source

$eventlog.Levels = $Levels

[ChainsawEventLog]::new($Levels, $LogName, $Source)

[ChainsawEventLog]::new(".\config.json")

```

## Class Documentation

### Constructors

```PowerShell
ChainsawEventLog()
ChainsawEventLog([string[]] $Levels, [string] $LogName, [string] $Source)
ChainsawEventLog([string] $PathConfig )
```

### Properties

```PowerShell
[string[]] $Levels
[string] $LogName
[string] $Source
```

### Methods

```PowerShell
[void] Write([string] $Level, [string] $Message )
[void] Write([string] $Level, [string] $Message, [int] $ErrorCode)
[void] Write([string] $Level, [string] $Message, [int] $ErrorCode, [string] $CallingFile, [int] $CallingLine)
[bool] InitializeLog()
```

Generated by [PowerDoc](https://github.com/luther38/PowerDoc)
Last updated: 2/18/2019