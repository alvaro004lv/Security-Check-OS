# Security Check OS

Security Check OS es una herramienta en PowerShell que realiza un análisis de seguridad en sistemas operativos Windows. Este script comprueba actualizaciones del sistema, estado de BitLocker, cortafuegos y más.

## Requisitos

- Windows 10 o superior
- PowerShell 5.1 o superior
- Privilegios de Administrador

## Características

- Verificación de actualizaciones del sistema.
- Detección del estado de BitLocker en los discos.
- Comprobación del estado del cortafuegos.
- Detección de software obsoleto.
- Estado de Windows Defender.

## Instalación

1. Clona este repositorio en tu máquina local:
   ```bash
   git clone https://github.com/alvaro004lv/Security-Check-OS.git

## Uso

1. Entra en una terminal de PowerShell como administrador y navega al directorio donde se clonó ell repositorio:
    ```bash
    cd Security-Check-OS
2. Si la ejecución de scripts está deshabilitada, habilítala con el siguiente comando (ejecutar como administrador):
    ```bash 
    Set-ExecutionPolicy RemoteSigned
3. Ejecuta el script en PowerShell:
    ```bash
    .\SCOS-Win64.ps1
