output "bff_ip" {
  value = aws_instance.bff_postgress.public_ip
}

output "bff_dns" {
  value = aws_instance.bff_postgress.public_dns
}

output "servilinea_ip" {
  value = aws_instance.servilinea_reclutadores.public_ip
}

output "servilinea_dns" {
  value = aws_instance.servilinea_reclutadores.public_dns
}

output "dialogflow_ip" {
  value = aws_instance.dialogflow.public_ip
}

output "dialogflow_dns" {
  value = "este es el dns de dialogflow ${aws_instance.dialogflow.public_dns}"
}

output "ip_private" {
  value = "Esta es la ip de servicio_postulante y reclutadores --> ${aws_instance.servilinea_reclutadores.private_ip} \n esta es la ip de bff y db ${aws_instance.bff_postgress.private_ip} \n esta la ip dialogflow ${aws_instance.dialogflow.private_ip}" 
  
}