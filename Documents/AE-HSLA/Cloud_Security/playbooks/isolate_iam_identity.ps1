Write-Host "================================================================================" -ForegroundColor Red
Write-Host "[!] INICIANDO PLAYBOOK DE RESPUESTA INTERNA: CONTENCIÓN IAM DE EMERGENCIA" -ForegroundColor Red -BackgroundColor Black
Write-Host "================================================================================" -ForegroundColor Red

$compromisedUser = "admin-compromised@company.com"
$attackerIP      = "198.51.100.45"

Write-Host "[*] Objetivo a aislar: $compromisedUser" -ForegroundColor Cyan
Write-Host "[*] Dirección IP detectada: $attackerIP" -ForegroundColor Cyan
Write-Host "--------------------------------------------------------------------------------"

# Paso 1: Revocación de sesiones activas (Simulación de llamadas CLI en la nube)
Write-Host "[+] [IAM-ISOLATION] Revocando todas las sesiones web activas y cookies de inicio de sesión..." -ForegroundColor Yellow
Start-Sleep -Seconds 1
Write-Host "    -> Estado: ÉXITO (Sesiones invalidadas globalmente)" -ForegroundColor Green

# Paso 2: Eliminación / Desactivación de Access Keys y Tokens API activos
Write-Host "[+] [TOKEN-INVALIDATION] Desactivando Access Keys vigentes (Programmatic Access Keys)..." -ForegroundColor Yellow
Start-Sleep -Seconds 1
Write-Host "    -> Estado: ÉXITO (Llaves de acceso marcadas como inactivas)" -ForegroundColor Green

# Paso 3: Aplicar Política de Denegación Total Explícita (Inline Deny Policy)
Write-Host "[+] [POLICY-ENFORCEMENT] Adjuntando política 'DenyAll' temporal al ARN del usuario..." -ForegroundColor Yellow
Start-Sleep -Seconds 1
Write-Host "    -> Estado: ÉXITO (El usuario ya no puede realizar ninguna API Call en la nube)" -ForegroundColor Green

Write-Host "--------------------------------------------------------------------------------"
Write-Host "[SUCCESS] Identidad comprometida contenida con éxito. Alertas enviadas al SOC." -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Red
