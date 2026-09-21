$logPath = "C:\Users\Ruth\Documents\AE-HSLA\Cloud_Security\logs\cloud_api_activity.json"

if (-not (Test-Path $logPath)) {
    Write-Error "[!] No se encontró el archivo de logs en la ruta especificada."
    return
}

Write-Host "[*] Leyendo y parseando el feed de telemetría de la nube..." -ForegroundColor Cyan
$logs = Get-Content -Raw -Path $logPath | ConvertFrom-Json

$orderedLogs = $logs | Sort-Object { [DateTime]$_.Timestamp }

Write-Host "[*] Analizando marcas de tiempo en búsqueda de saltos temporales sospechosos (Time-Gaps)..." -ForegroundColor Cyan
Write-Host "--------------------------------------------------------------------------------"

$umbralMinutos = 5

for ($i = 0; $i -lt ($orderedLogs.Count - 1); $i++) {
    $currentEvent = $orderedLogs[$i]
    $nextEvent    = $orderedLogs[$i + 1]
    
    $currentTime = [DateTime]$currentEvent.Timestamp
    $nextTime    = [DateTime]$nextEvent.Timestamp
    
    $timeDiff = $nextTime - $currentTime
    
    if ($timeDiff.TotalMinutes -ge $umbralMinutos) {
        Write-Host "[ALERT] ¡MANIPULACIÓN DE LOGS DETECTADA (Time-Gap Accidental)!" -ForegroundColor Red -BackgroundColor Black
        Write-Host " -> Brecha de tiempo detectada: $($timeDiff.TotalMinutes) minutos." -ForegroundColor Yellow
        Write-Host " -> Último evento registrado antes del apagón:" -ForegroundColor White
        Write-Host "    - Hora: $($currentEvent.Timestamp)"
        Write-Host "    - Usuario: $($currentEvent.UserIdentity)"
        Write-Host "    - Acción: $($currentEvent.EventName)"
        Write-Host "    - IP de Origen: $($currentEvent.SourceIP)" -ForegroundColor Red
        Write-Host " -> Primer evento tras la restauración de telemetría:" -ForegroundColor White
        Write-Host "    - Hora: $($nextEvent.Timestamp)"
        Write-Host "    - Acción: $($nextEvent.EventName)"
        Write-Host "--------------------------------------------------------------------------------"

        Write-Host "[*] Activando Playbook de Respuesta a Incidentes inmediatamente..." -ForegroundColor Yellow
        
        & "C:\Users\Ruth\Documents\AE-HSLA\Cloud_Security\playbooks\incident_response_iam.ps1" -UsuarioAfectado $currentEvent.UserIdentity -IPAtacante $currentEvent.SourceIP
        
        break
    }
}
