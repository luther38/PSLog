
# Import the new class file we built
using module .\PsLog\PSLogClasses.psm1

# Import the functions
Import-Module .\PsLog\PsLog.psm1

# Import Pester to run our tests
Import-Module Pester

Write-Verbose -Message "Starting tests on Classes"
. .\Tests\Classes\PSLogCsv.Test.ps1
. .\Tests\Classes\PSLogConsole.Text.ps1

Write-Verbose -Message "Starting tests on Functions."
