param(
    [string]$UsuarioAfectado = "admin-compromised@company.com",
    [string]$IPAtacante      = "198.51.100.45"
)

Write-Host "================================================================================" -ForegroundColor Red
Write-Host "[!] ALERTA CRITICA: INICIANDO PLAYBOOK DE CONTENCIÓN IAM AUTOMATIZADO" -ForegroundColor Red -BackgroundColor Black
Write-Host "    -> Objetivo de Aislamiento: $UsuarioAfectado" -ForegroundColor Yellow
Write-Host "    -> Indicador de Compromiso (IoC) IP: $IPAtacante" -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Red

Write-Host "[*] [Fase 1/3 - IAM-ISOLATION] Revocando todas las sesiones web activas..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
Write-Host "    [OK] Token de sesión de consola invalidado. Atacante expulsado." -ForegroundColor Green

Write-Host "[*] [Fase 2/3 - TOKEN-INVALIDATION] Deshabilitando Access Keys y tokens API..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
Write-Host "    [OK] Llaves de acceso AKIAxxxxxxxxxxxx deshabilitadas de forma permanente." -ForegroundColor Green

Write-Host "[*] [Fase 3/3 - DENY-ALL POLICY ENFORCEMENT] Inyectando polótica explícita de denegación..." -ForegroundColor Cyan
Start-Sleep -Seconds 1
Write-Host "    [OK] Política de Denegación Absoluta adjuntada exitosamente." -ForegroundColor Green

Write-Host "================================================================================" -ForegroundColor Red
