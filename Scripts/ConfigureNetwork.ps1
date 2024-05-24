# Importation du module NetAdapter
Import-Module -Name NetAdapter

# Lire le fichier de configuration 
$ConfigPath = "C:\ConfigScripts\ServerCoreConfig.csv" 

# Lecture du ficher config
$Config = Import-Csv -Path $ConfigPath -Delimiter "," -Header "ServerName","IPAddress","Gateway","DNS","DomainName","DomainAdmin","DomainPassword" | Select-Object -Skip 1


  # Variable du Brésil
  $NomServeur = $Config.ServerName
  $AdresseIP = $Config.IPAddress
  $Passerelle = $Config.Gateway
  $DNS = $Config.DNS
  $Domaine = $Config.DomainName
  $User = $Config.DomainAdmin
  $Password = $Config.DomainPassword

# Configurer les paramètres réseau
$Interface = (Get-NetAdapter).ifIndex
New-NetIPAddress -InterfaceIndex $Interface -IPAddress $AdresseIP -PrefixLength 24 -DefaultGateway $Passerelle

# Configurer le serveur DNS 
Set-DnsClientServerAddress -InterfaceIndex $Interface -ServerAddresses $DNS

# Renommer l'ordinateur
Rename-Computer -NewName $NomServeur -Force

# Installer le rôle AD-DS
Add-WindowsFeature -Name "RSAT-AD-Tools" -IncludeManagementTools -IncludeAllSubFeature
Add-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature

# Ajout d'une ligne de confirmation
Write-Host "Configuration OK pour le serveur $NomServeur"


# Rejoindre le domaine
$Pass= ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PScredential ("$User@$Domaine", $Pass)
Add-Computer -DomainName $Domaine -credential $Credential
