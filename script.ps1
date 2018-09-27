# PowerShell script to check the system performance 

$startTime = Get-Date

$filePath = '.\ServerMonitor.csv'

if (!(Test-Path $filePath -PathType Leaf))
{
$table=@"
Server Name,Timestamp,Memory Usage (in %),CPU Usage (in %),(C:/) Total Capacity,(C:/) Used Capacity (in %),(C:/)Free Capacity (in %),(E:/) Total Capacity,(E:/) Used Capacity (in %),(E:/)Free Capacity (in %),(F:/) Total Capacity,(F:/) Used Capacity (in %),(F:/)Free Capacity (in %)
"@
} 

$result = ""

$RAM = Get-WmiObject -ClassWin32_OperatingSystem -ErrorAction Stop
if (-not$?)
  	{
      	throw $_
    }
[int]$RAMtotal =$RAM.TotalVisibleMemorySize
$RAMAvail =$RAM.FreePhysicalMemory
$RAMpercent =[Math]::Round(($RAMtotal- $RAMAvail) * 100/$RAMtotal)

$CPU = Get-WmiObject win32_processor| Measure-Object-property LoadPercentage-Average -ErrorActionStop |Select Average
if (-not$?)
{
   	throw $_
}
$CPUAverage =$CPU.Average

$resultStr =$resultStr +$env:COMPUTERNAME+","+$startTime+","+$RAMpercent+","+$CPUAverage

Add-Content $filePath $result

	
