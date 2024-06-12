Get-ADUser -Filter * -SearchBase "OU=BillU-Users,DC=BILLU,DC=LAN" | Remove-ADUser -Confirm
