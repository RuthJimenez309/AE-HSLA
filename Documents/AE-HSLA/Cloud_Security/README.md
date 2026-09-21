# Cloud Security & API Log Tampering Detection

## Objetivos de la Sesión
Este laboratorio práctico aborda el análisis forense y la emulación de adversarios enfocados en la infraestructura de la nube, simulando técnicas tácticas avanzadas de evasión de defensas y la posterior respuesta automatizada de contención (Incident Response).

---

## Fase Ofensiva (Adversary Emulation)
*   **Técnica Mitre ATT&CK:** **T1070.002 - Clear Cloud Logs**
*   **Mecanismo de Manipulación (API Log Tampering):** Se simuló el compromiso de una identidad con privilegios de administración (`admin-compromised@company.com`). Tras ejecutar comandos para deshabilitar los flujos de auditoría (`UpdateTrail`), el adversario eliminó un segmento consecutivo de la telemetría, generando una ventana de invisibilidad de **45 minutos** dentro de un feed de más de 3,500 eventos legítimos.

---

## Fase Defensiva (Threat Hunting & Incident Response)
*   **Detección Basada en Comportamiento Cronológico (Time-Gap Analysis):** Debido a que los atacantes borran las huellas directas del borrado de logs, se programó lógica en PowerShell para analizar correlaciones estadísticas entre las marcas de tiempo (`Timestamps`) secuenciales. El script identificó con éxito una brecha anómala superior al umbral crítico permitido (5 minutos), aislando la IP origen del atacante (`198.51.100.45`).
*   **Playbook de Contención IAM Automatizado:** Implementación del flujo de respuesta inmediata para aislar la identidad del atacante. El protocolo ejecutó tres barreras críticas de seguridad:
    1. Revocación global e inmediata de sesiones web activas (`IAM-ISOLATION`).
    2. Invalidación y marcado inactivo de llaves de acceso programático (`TOKEN-INVALIDATION`).
    3. Inyección de una política explícita de denegación absoluta (`DenyAll Policy Enforcement`) para anular cualquier llamada API posterior.

---

## Tecnologías Empleadas
*   **PowerShell 7 / Core**: Engine principal para el procesamiento, ordenamiento forense y parseo de colecciones de datos JSON complejos.
*   **Modelado de Objetos Personalizados ([PSCustomObject])**: Estructuración idéntica de esquemas JSON compatibles con formatos nativos de proveedores cloud (AWS CloudTrail / Azure Activity Logs).
