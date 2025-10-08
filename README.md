<h1>
  <p align="center">
    🪣 Laboratorio DevOps: Bucket S3 Seguro en AWS con Terraform 🪣
  </p>
</h1>

<p align="center">
  <a href="https://www.linkedin.com/in/jorge-garagorry-a6078652/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
  </a>
  <a href="https://github.com/jgaragorry" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Badge">
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS Badge">
  <img src="https://img.shields.io/badge/DevSecOps-0A0A0A?style=for-the-badge&logo=security&logoColor=white" alt="DevSecOps Badge">
  <img src="https://img.shields.io/badge/SRE-0052CC?style=for-the-badge&logo=datadog&logoColor=white" alt="SRE Badge">
  <img src="https://img.shields.io/badge/FinOps-28A745?style=for-the-badge&logo=dollar-sign&logoColor=white" alt="FinOps Badge">
</p>

---

## 📋 Tabla de Contenidos

1. [🎯 Objetivo del Workshop](#-objetivo-del-workshop)  
2. [✨ Buenas Prácticas Demostradas](#-buenas-prácticas-demostradas)  
3. [⚙️ Prerrequisitos](#️-prerrequisitos)  
4. [🚀 Guía de Ejecución Detallada](#-guía-de-ejecución-detallada)  
5. [📁 Estructura de Archivos](#-estructura-de-archivos)  
6. [🤝 Contribuciones y Contacto](#-contribuciones-y-contacto)  
7. [🧪 Pruebas Avanzadas: Versionado y Limpieza](#-pruebas-avanzadas-versionado-y-limpieza)

---

## 🎯 Objetivo del Workshop

Este laboratorio demuestra cómo desplegar un **bucket de Amazon S3** de nivel profesional utilizando **Terraform**. El objetivo es ir más allá de una simple creación de recursos y aplicar un conjunto robusto de mejores prácticas de seguridad, confiabilidad y automatización, simulando un flujo de trabajo DevOps del mundo real.

---

## ✨ Buenas Prácticas Demostradas

- **🛡️ DevSecOps:**
  - Bloqueo de todo acceso público por defecto.
  - Encriptación de datos en reposo (SSE-S3).
  - Política de bucket para forzar conexiones seguras (HTTPS).
- **🔄 SRE / SysOps:**
  - Habilitación de versionado para prevenir la pérdida de datos y permitir recuperaciones.
  - Configuración de logging de acceso para auditoría y observabilidad.
- **💰 FinOps:**
  - Etiquetado (`Tagging`) consistente de todos los recursos para el seguimiento de costos.
  - Ciclo de vida completo con scripts de destrucción para garantizar que no queden recursos generando facturación.
- **🤖 DevOps:**
  - Infraestructura como Código (IaC) con Terraform para despliegues repetibles y consistentes.
  - Uso de un backend remoto (S3/DynamoDB) para la gestión segura del estado.
  - Flujo de trabajo automatizado mediante scripts de shell.

---

## ⚙️ Prerrequisitos

- **WSL Ubuntu 24.04 LTS** (o cualquier terminal Linux/macOS).  
- **AWS CLI** instalado y configurado con credenciales de IAM.  
- **Terraform** instalado.  
- **Git** instalado.  

---

## 🚀 Guía de Ejecución Detallada

### Fase 1: Preparación del Entorno

```bash
git clone https://github.com/jgaragorry/Bucket-S3-Seguro-en-AWS.git
cd Bucket-S3-Seguro-en-AWS
```

```hcl
# terraform.tfvars
bucket_name_suffix = "tus-iniciales-fecha" # ej: "jg-20251008"
```

```bash
chmod +x scripts/*.sh
```

---

### Fase 2: Despliegue de la Infraestructura

```bash
./scripts/01-setup-backend.sh
./scripts/02-initialize-project.sh
./scripts/03-deploy-infrastructure.sh
```

---

### Fase 3: Verificación de Funcionalidad

- Revisa en AWS S3:
  - **Properties:** Versioning, Encryption y Logging habilitados.  
  - **Permissions:** Block public access en "On".

---

### Fase 4: Limpieza Final y Control de Costos

```bash
./scripts/05-destroy-resources.sh
./scripts/cleanup-backend.sh
```

---

## 📁 Estructura de Archivos

- `main.tf`: Define los recursos de AWS.  
- `variables.tf`: Declara las variables de entrada.  
- `terraform.tfvars`: Asigna valores a las variables.  
- `outputs.tf`: Define los datos de salida.  
- `backend.tf`: Configura el estado remoto.  
- `scripts/`: Scripts para automatizar el flujo de trabajo.

---

## 🤝 Contribuciones y Contacto

Las contribuciones son bienvenidas. Si encuentras un problema o tienes una sugerencia, por favor abre un issue. Para contacto directo, puedes encontrarme en mis redes:

<p align="center">
  <a href="https://www.linkedin.com/in/jorge-garagorry-a6078652/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
  </a>
  <a href="https://github.com/jgaragorry" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
  </a>
</p>

---

## 🧪 Pruebas Avanzadas: Versionado y Limpieza

<p align="center">
  <img src="https://img.shields.io/badge/SRE-Test-0052CC?style=for-the-badge&logo=datadog&logoColor=white" alt="SRE Badge">
  <img src="https://img.shields.io/badge/AWS-S3-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white" alt="AWS S3 Badge">
  <img src="https://img.shields.io/badge/Cleanup-Automation-28A745?style=for-the-badge&logo=power-shell&logoColor=white" alt="Cleanup Badge">
</p>

**Propósito:** Verificar el versionado del bucket S3 y aplicar una limpieza avanzada para evitar el error `BucketNotEmpty`.

**Prerrequisito:** Haber ejecutado:

```bash
./scripts/03-deploy-infrastructure.sh
```

### Parte 1: Prueba del Versionado

```bash
echo "Esta es la versión 1 del archivo." > mi-documento.txt
aws s3 cp mi-documento.txt s3://tu-bucket-principal/

echo "Esta es la versión 2, con contenido actualizado." > mi-documento.txt
aws s3 cp mi-documento.txt s3://tu-bucket-principal/

aws s3api list-object-versions --bucket tu-bucket-principal --prefix mi-documento.txt

aws s3 rm s3://tu-bucket-principal/mi-documento.txt

aws s3api list-object-versions --bucket tu-bucket-principal --prefix mi-documento.txt
```

### Parte 2: Limpieza Definitiva

```bash
MAIN_BUCKET="tu-bucket-principal"
LOG_BUCKET="tu-bucket-principal-logs"

aws s3api delete-objects --bucket $MAIN_BUCKET --delete "$(aws s3api list-object-versions --bucket $MAIN_BUCKET --query='{Objects: concat(Versions, DeleteMarkers)[].{Key:Key,VersionId:VersionId}}')" > /dev/null

aws s3 rb s3://$MAIN_BUCKET
aws s3 rb s3://$LOG_BUCKET --force

./scripts/cleanup-backend.sh
```

✅ ¡Listo! Has validado
