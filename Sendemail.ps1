Set-Location C:\PSscripts
$EmailBody=get-content emailbody.txt
$customers=Get-Content test.txt
foreach ($customer in $customers)
{
      $mail=Send-MailMessage -to "$customer"`
                      -From 'info@myivation.com'`
                      -Subject 'Thank you for shopping with DBRoth!'`
                      -Body "$EmailBody"`
                      -SmtpServer 'mail.camarketing.com'`
                      -BodyAsHtml  
}