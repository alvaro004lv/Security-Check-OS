# 1. Comprobar Actualizaciones del Sistema
Write-Host "Verificando actualizaciones del sistema..."
$updates = Get-WmiObject -Class "win32_quickfixengineering"

if ($updates.Count -eq 0) {
    Write-Host "El sistema no tiene actualizaciones recientes. Es recomendable actualizar." -ForegroundColor Yellow
} else {
    Write-Host "El sistema esta actualizado." -ForegroundColor Green
}

# 2. Comprobar BitLocker
Write-Host "`nVerificando el estado de BitLocker..."
$bitlockerVolumes = Get-BitLockerVolume

$encryptedVolumes = $bitlockerVolumes | Where-Object { $_.ProtectionStatus -eq 'On' }
$unprotectedVolumes = $bitlockerVolumes | Where-Object { $_.ProtectionStatus -eq 'Off' }

if ($encryptedVolumes.Count -gt 0 -and $unprotectedVolumes.Count -gt 0) {
    Write-Host "Algunos discos estan encriptados y otros no:" -ForegroundColor Yellow
    foreach ($volume in $encryptedVolumes) {
        Write-Host " - $($volume.MountPoint): Encriptado"
    }
    foreach ($volume in $unprotectedVolumes) {
        Write-Host " - $($volume.MountPoint): No encriptado"
    }
} elseif ($encryptedVolumes.Count -gt 0) {
    Write-Host "Todos los discos estan encriptados:" -ForegroundColor Green
    foreach ($volume in $encryptedVolumes) {
        Write-Host " - $($volume.MountPoint): Encriptado"
    }
} elseif ($unprotectedVolumes.Count -gt 0) {
    Write-Host "No hay discos encriptados:" -ForegroundColor Yellow
    foreach ($volume in $unprotectedVolumes) {
        Write-Host " - $($volume.MountPoint): No encriptado"
    }
} else {
    Write-Host "No se encontraron discos para verificar." -ForegroundColor Red
}

# 3. Comprobar el Cortafuegos
Write-Host "`nVerificando el estado del cortafuegos..."
$firewallStatus = Get-NetFirewallProfile | Where-Object { $_.Enabled -eq $false }

if ($firewallStatus) {
    Write-Host "El cortafuegos no esta activado en uno o mas perfiles de red. Es recomendable habilitar el cortafuegos." -ForegroundColor Yellow
} else {
    Write-Host "El cortafuegos esta correctamente configurado." -ForegroundColor Green
}

# 4. Deteccion de Software Obsoleto
Write-Host "`nVerificando software obsoleto..."
$software = Get-WmiObject -Class Win32_Product | Where-Object { $_.Version -lt '1.0' } # Cambiar la version segun tus necesidades

if ($software.Count -gt 0) {
    Write-Host "Se ha detectado software obsoleto. A continuacion, se lista la ruta:" -ForegroundColor Yellow
    foreach ($app in $software) {
        if ($app.InstallLocation) {
            Write-Host "$($app.Name) - $($app.InstallLocation)"
        } else {
            Write-Host "$($app.Name) - No se encontró ruta de instalación."
        }
    }
    Write-Host "Es recomendable eliminar o actualizar este software." -ForegroundColor Yellow
} else {
    Write-Host "No se ha detectado software obsoleto." -ForegroundColor Green
}


# 5. Comprobar el estado de Windows Defender
Write-Host "`nVerificando el estado de Windows Defender..."
$defenderStatus = Get-MpComputerStatus

if ($defenderStatus.AntivirusEnabled -eq $false) {
    Write-Host "Windows Defender esta desactivado. Es recomendable activarlo." -ForegroundColor Yellow
} else {
    Write-Host "Windows Defender esta activado." -ForegroundColor Green
}

