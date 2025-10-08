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
   * [Fase 1: Preparación del Entorno](#fase-1-preparación-del-entorno)
   * [Fase 2: Despliegue de la Infraestructura](#fase-2-despliegue-de-la-infraestructura)
   * [Fase 3: Verificación de Funcionalidad](#fase-3-verificación-de-funcionalidad)
   * [Fase 4: Limpieza Final y Control de Costos](#fase-4-limpieza-final-y-control-de-costos)
5. [📁 Estructura de Archivos](#-estructura-de-archivos)
6. [🤝 Contribuciones y Contacto](#-contribuciones-y-contacto)

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

#### 1. Clonar el Repositorio

```bash
git clone https://github.com/jgaragorry/Bucket-S3-Seguro-en-AWS.git
cd Bucket-S3-Seguro-en-AWS
```

> Qué hace: Descarga una copia local del proyecto.  
> Por qué: Para tener todos los archivos de código y scripts en tu máquina.

#### 2. Configurar el Nombre Único del Bucket

```hcl
# terraform.tfvars
bucket_name_suffix = "tus-iniciales-fecha" # ej: "jg-20251008"
```

> Qué hace: Define un sufijo único.  
> Por qué es importante: Los nombres de los buckets S3 deben ser únicos a nivel mundial.

#### 3. Dar Permisos a los Scripts

```bash
chmod +x scripts/*.sh
```

> Qué hace: Permite que la terminal ejecute los archivos de script.  
> Por qué es importante: Por defecto, los archivos descargados no tienen permisos de ejecución.

---

### Fase 2: Despliegue de la Infraestructura

#### 1. Configurar el Backend

```bash
./scripts/01-setup-backend.sh
```

#### 2. Planificar la Infraestructura

```bash
./scripts/02-initialize-project.sh
```

#### 3. Desplegar la Infraestructura

```bash
./scripts/03-deploy-infrastructure.sh
```

---

### Fase 3: Verificación de Funcionalidad

Acción: Ve a la Consola de AWS → S3 y haz clic en tu bucket principal.

#### Qué verificar:

- **Properties:** Versioning, Encryption y Logging habilitados.
- **Permissions:** Block public access en "On".

---

### Fase 4: Limpieza Final y Control de Costos

#### 1. Destruir la Infraestructura Principal

```bash
./scripts/05-destroy-resources.sh
```

#### 2. Limpiar el Backend

```bash
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

