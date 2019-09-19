
$server = Get-Content "F:\Scripts\Replace_DNS_IP\server.txt"

$regex = ‘\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b’

    $_DNSList= @()
    
    #Get the input from the user
    $_DNSList = New-Object System.Net.IPAddress(0x1521A8C0)
        $_DNSList = READ-HOST "Enter the DNS Servers IP address(use , comma for addditional IPs )"
    
    #splitting the list of input as array by Comma & Empty Space
    $_DNSList = $_DNSList.Split(',').Split(' ')


    $_ReplaceDNSList= @()
    $_ReplaceDNSList = New-Object System.Net.IPAddress(0x1521A8C0)
    
    #Get the input from the user
    $_ReplaceDNSList= READ-HOST "Enter the Replace DNS Servers IP address(use , comma for addditional IPs )"
    
    #splitting the list of input as array by Comma & Empty Space
    $_ReplaceDNSList = $_ReplaceDNSList.Split(',').Split(' ')

foreach($input in $server)
{
   
    $LogPath = Get-Item "F:\Scripts\Replace_DNS_IP\PSD Backup\$input.psd1"
   
    $Lines =  Get-Content $LogPath | Where-Object {$_ -match "DNSServerAddress"}

    Foreach ($Line in $Lines) 
    
     {
          
        $IPs = ($Line  |  Select-String -Pattern $regex -AllMatches).Matches.Value
       
        foreach($IP in $IPs)
        
         {

            if(($IP -match $_DNSList[0]) -and ($_ReplaceDNSList[0] -ne $null))
                {
                    Write-Host "Replacing $IP DNS Address to $_ReplaceDNSList[0] Address "
                    (Get-Content -Path $LogPath).Replace($IP,$_ReplaceDNSList[0]) | Set-Content -Path $LogPath
                }
            elseif(($IP -match $_DNSList[1]) -and ($_ReplaceDNSList[1] -ne $null))
                {
                    Write-Host "Replacing $IP DNS Address to $_ReplaceDNSList[1] Address"
                    (Get-Content -Path $LogPath).Replace($IP,$_ReplaceDNSList[1]) | Set-Content -Path $LogPath
                }
            elseif(($IP -match $_DNSList[2]) -and ($_ReplaceDNSList[2] -ne $null))
                {
                   Write-Host "Replacing $IP DNS Address to $_ReplaceDNSList[2] Address"
                   (Get-Content -Path $LogPath).Replace($IP,$_ReplaceDNSList[2]) | Set-Content -Path $LogPath
                }
            elseif(($IP -match $_DNSList[3]) -and ($_ReplaceDNSList[3] -ne $null))
                {
                   Write-Host "Replacing $IP DNS Address to $_ReplaceDNSList[3] Address "
                    (Get-Content -Path $LogPath).Replace($IP,$_ReplaceDNSList[3]) | Set-Content -Path $LogPath
                }
            else
                {
                    Write-Host "DNS IP address is not Matching with provided Input"
                }
        }
                           
                           
     }
 }