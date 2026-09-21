$logPath = ".\logs\cloud_api_activity.json"
$startTime = (Get-Date).AddHours(-2)
$events = @()

# 1. Generar 2,000 eventos legítimos iniciales (Lecturas de infraestructura)
for ($i = 1; $i -le 2000; $i++) {
    $startTime = $startTime.AddSeconds(2)
    $events += [PSCustomObject]@{
        Timestamp = $startTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
        EventID   = [Guid]::NewGuid().ToString()
        UserIdentity = "svc-kubernetes-cluster@cloud.internal"
        EventName = "DescribeInstances"
        SourceIP  = "10.0.4.15"
        Status    = "Success"
    }
}

# 2. EVENTO OFENSIVO (T1070.002): El atacante deshabilita el logging
$startTime = $startTime.AddSeconds(2)
$events += [PSCustomObject]@{
    Timestamp = $startTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
    EventID   = [Guid]::NewGuid().ToString()
    UserIdentity = "admin-compromised@company.com"
    EventName = "UpdateTrail" # O StopLogging dependiendo del proveedor
    SourceIP  = "198.51.100.45" # IP Atacante (Anómala)
    Status    = "Success"
}

# 3. EL SALTO TEMPORAL (API Log Tampering): El atacante borra los siguientes 45 minutos de logs
# Simulamos esto adelantando el reloj abruptamente en el feed
$startTime = $startTime.AddMinutes(45)

# 4. Generar 1,500 eventos legítimos posteriores tras la supuesta reactivación o persistencia
for ($i = 1; $i -le 1500; $i++) {
    $startTime = $startTime.AddSeconds(2)
    $events += [PSCustomObject]@{
        Timestamp = $startTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
        EventID   = [Guid]::NewGuid().ToString()
        UserIdentity = "svc-kubernetes-cluster@cloud.internal"
        EventName = "DescribeInstances"
        SourceIP  = "10.0.4.15"
        Status    = "Success"
    }
}

# Exportar el feed a formato JSON
$events | ConvertTo-Json -Depth 3 | Out-File -FilePath $logPath -Encoding utf8
Write-Host "[!] Feed de CloudTrail simulado con éxito en: $logPath" -ForegroundColor Cyan
Write-Host "[!] Ataque T1070.002 oculto e inyectado con un salto temporal de 45 minutos." -ForegroundColor Yellow
