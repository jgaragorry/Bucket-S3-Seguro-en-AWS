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

Este laboratorio demuestra cómo desplegar un **bucket de Amazon S3** de nivel profesional utilizando **Terraform**. El objetivo es aplicar buenas prácticas de seguridad, confiabilidad y automatización, simulando un flujo DevOps real.

---

## ✨ Buenas Prácticas Demostradas

- **🛡️ DevSecOps:**  
  - Bloqueo de acceso público  
  - Encriptación SSE-S3  
  - Política para forzar HTTPS  
- **🔄 SRE / SysOps:**  
  - Versionado habilitado  
  - Logging de acceso  
- **💰 FinOps:**  
  - Etiquetado consistente  
  - Scripts de destrucción  
- **🤖 DevOps:**  
  - IaC con Terraform  
  - Backend remoto  
  - Automatización con scripts

---

## ⚙️ Prerrequisitos

- WSL Ubuntu 24.04 LTS o terminal Linux/macOS  
- AWS CLI configurado  
- Terraform instalado  
- Git instalado  

---

## 🚀 Guía de Ejecución Detallada

### Fase 1: Preparación

```bash
git clone https://github.com/jgaragorry/Bucket-S3-Seguro-en-AWS.git
cd Bucket-S3-Seguro-en-AWS
chmod +x scripts/*.sh
```

Edita `terraform.tfvars`:

```hcl
bucket_name_suffix = "tus-iniciales-fecha" # ej: "jg-20251008"
```

---

### Fase 2: Despliegue

```bash
./scripts/01-setup-backend.sh
./scripts/02-initialize-project.sh
./scripts/03-deploy-infrastructure.sh
```

---

### Fase 3: Verificación

- En AWS S3:  
  - Versioning, Encryption, Logging habilitados  
  - Block public access activado

---

### Fase 4: Limpieza

```bash
./scripts/05-destroy-resources.sh
./scripts/cleanup-backend.sh
```

---

## 📁 Estructura de Archivos

- `main.tf` – Recursos de AWS  
- `variables.tf` – Variables de entrada  
- `terraform.tfvars` – Valores personalizados  
- `outputs.tf` – Resultados del despliegue  
- `backend.tf` – Estado remoto  
- `scripts/` – Automatización

---

## 🤝 Contribuciones y Contacto

Las contribuciones son bienvenidas. Para contacto directo:

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

**Prerrequisito:** Haber ejecutado:

```bash
./scripts/03-deploy-infrastructure.sh
```

### Parte 1: Prueba de Versionado

```bash
echo "Versión 1" > mi-documento.txt
aws s3 cp mi-documento.txt s3://tu-bucket-principal/

echo "Versión 2 actualizada" > mi-documento.txt
aws s3 cp mi-documento.txt s3://tu-bucket-principal/

aws s3api list-object-versions --bucket tu-bucket-principal --prefix mi-documento.txt

aws s3 rm s3://tu-bucket-principal/mi-documento.txt

aws s3api list-object-versions --bucket tu-bucket-principal --prefix mi-documento.txt
```

### Parte 2: ✅ Solución: Separar los Comandos

Ejecuta esta secuencia de comandos corregida. Funcionará con tu versión de la AWS CLI.

#### Define el nombre del bucket

```bash
MAIN_BUCKET="secure-assets-dev-jg-workshop-final"
```

#### Paso 1: Elimina todas las versiones de objetos

```bash
aws s3api delete-objects --bucket $MAIN_BUCKET --delete "$(aws s3api list-object-versions --bucket $MAIN_BUCKET --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')"
```

#### Paso 2: Elimina todos los marcadores de borrado

```bash
aws s3api delete-objects --bucket $MAIN_BUCKET --delete "$(aws s3api list-object-versions --bucket $MAIN_BUCKET --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')"
```

#### Paso 3: Elimina el bucket vacío

```bash
aws s3 rb s3://$MAIN_BUCKET
```

✅ ¡Infraestructura validada, versionado comprobado y limpieza completa aplicada!

