using module ..\PsLog\PSLogClasses.psm1
Describe "PSLogCsv" {
    It "Initialize with inline code:" {
        $Levels = @("Information")
        $LogPath = ".\pester.csv"
        $MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [PSLogCSV]::new($LogPath, $MessageTemplate, $Levels)
        $valid = $csv._isValidEndPoint() 
        $valid | Should -Be $true
     
    }

    It "Initialize with config file:" {
        $PathConfig = ".\config.json"

        $csv = [PSLogCSV]::new($PathConfig)   
        $valid = $csv._isValidEndPoint() 
        $valid | Should -Be $true

    }

    It "Generate new csv log:" {
        $Levels = @("Information")
        $LogPath = ".\pester.csv"
        $MessageTemplate = "#DateTime#, #CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        # Remove old 

        $csv = [PSLogCSV]::new($LogPath, $MessageTemplate, $Levels)
        $csv._GenerateCsvIfMissing()

        $exists = [System.IO.File]::Exists(".\pester.csv")
        if ( $exists -eq $true ) {
            $row0 = Get-Content -Path $LogPath
            [System.IO.File]::Delete($LogPath)
            $row0 | Should -Be "DateTime, CallingFile, LineNumber, Level, Message, ErrorCode"            
        }
        else {
            Write-Error -Message "Failed to generate the csv file"
            $exists | Should -Be $true
        }
        
    }

    It "Use Write(Level, Message)" {
        $Levels = @("Information")
        $LogPath = ".\pester2.csv"
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [PSLogCSV]::new($LogPath, $MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing")

        $exists = [System.IO.File]::Exists(".\pester2.csv")
        if ( $exists -eq $true ) {
            $row = Get-Content -Path $LogPath
            [System.IO.File]::Delete($LogPath)
            $row[1] | Should -Be ", , Information, Unit Testing, "
            
        }
        else {
            Write-Error -Message "Failed to generate the csv file"
            $exists | Should -Be $true
        }
    }

    It "Use Write(Level, Message, ErrorCode)" {
        $Levels = @("Information")
        $LogPath = ".\pester3.csv"
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $csv = [PSLogCSV]::new($LogPath, $MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing", 1)

        $exists = [System.IO.File]::Exists($LogPath)
        if ( $exists -eq $true ) {
            $row = Get-Content -Path $LogPath
            [System.IO.File]::Delete($LogPath)
            $row[1] | Should -Be ", , Information, Unit Testing, 1"
            
        }
        else {
            Write-Error -Message "Failed to generate the csv file"
            $exists | Should -Be $true
        }
    }

    <#
    It "Use Write(Level, Message, ErrorCode, CallingFile, LineNumber)" {
        $Levels = @("Information")
        $LogPath = ".\pester4.csv"
        $MessageTemplate = "#CallingFile#, #LineNumber#, #Level#, #Message#, #ErrorCode#"

        $log = [PSLog]::new()
        $FileName = $log.GetCurrentFileName()
        Write-Host $FileName
        $Line = $log.GetCurrentLineNumber()
        Write-Host $Line
        $csv = [PSLogCSV]::new($LogPath, $MessageTemplate, $Levels)
        $csv.Write("Information", "Unit Testing", 1, $FileName, $Line)

        $exists = [System.IO.File]::Exists($LogPath)
        if ( $exists -eq $true ) {
            $row = Get-Content -Path $LogPath
            #[System.IO.File]::Delete($LogPath)
            $row[1] | Should -Be "PSLogCsv.Text.ps1, 95, Information, Unit Testing, 1"
            
        }
        else {
            Write-Error -Message "Failed to generate the csv file"
            $exists | Should -Be $true
        }
    }
    #>
}