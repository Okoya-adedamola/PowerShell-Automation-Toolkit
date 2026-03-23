<#
.SYNOPSIS
    Professional System & Network Diagnostic Tool
    .DESCRIPTION
        Performs a health check on local hardware and network connectivity.
            Ideal for remote system management and industrial IT audits.
            .AUTHOR
                Okoya Adedamola
                #>
                
                Write-Host "--- Starting System Diagnostic Audit ---" -ForegroundColor Cyan
                
                # 1. Check Disk Space
                Write-Host "[*] Checking Disk Health..." -NoNewline
                $Disks = Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
                foreach ($Disk in $Disks) {
                    $FreeGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
                        $SizeGB = [math]::Round($Disk.Size / 1GB, 2)
                            Write-Host " Drive $($Disk.DeviceID) has $FreeGB GB free out of $SizeGB GB." -ForegroundColor Yellow
                            }
                            
                            # 2. Check Memory (RAM) Usage
                            Write-Host "[*] Checking Memory Usage..." -NoNewline
                            $OS = Get-CimInstance Win32_OperatingSystem
                            $FreeRAM = [math]::Round($OS.FreePhysicalMemory / 1MB, 2)
                            $TotalRAM = [math]::Round($OS.TotalVisibleMemorySize / 1MB, 2)
                            Write-Host " $FreeRAM GB RAM available out of $TotalRAM GB total." -ForegroundColor Yellow
                            
                            # 3. Network Connectivity Test (Ping)
                            $Target = "8.8.8.8" # Google DNS
                            Write-Host "[*] Testing Network Connectivity to $Target..." -NoNewline
                            if (Test-Connection -ComputerName $Target -Count 2 -Quiet) {
                                Write-Host " SUCCESS: Internet is reachable." -ForegroundColor Green
                                } else {
                                    Write-Host " FAILED: Check local gateway or ISP." -ForegroundColor Red
                                    }
                                    
                                    # 4. Export Report to File
                                    $ReportPath = "$HOME\Desktop\Audit_Report.txt"
                                    "Diagnostic Audit Performed on: $(Get-Date)" | Out-File -FilePath $ReportPath
                                    $Disks | Select-Object DeviceID, FreeSpace, Size | Out-File -FilePath $ReportPath -Append
                                    
                                    Write-Host "--- Audit Complete. Report saved to Desktop. ---" -ForegroundColor Cyan
                                    #>