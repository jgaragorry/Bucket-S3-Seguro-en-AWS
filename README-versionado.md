# 🧪 Guía de Pruebas Avanzadas: Versionado en S3 y Limpieza Robusta

**Propósito:** Este documento detalla los pasos para verificar la funcionalidad de versionado del bucket S3 y el procedimiento de limpieza correcto a seguir después de haber añadido objetos, lo que previene el error `BucketNotEmpty` durante la destrucción.

**Prerrequisito:** Haber desplegado con éxito la infraestructura del Workshop 2 con el script:

```bash
./scripts/03-deploy-infrastructure.sh
```

---

## 🧩 Parte 1: Prueba Práctica del Versionado (SRE)

**Objetivo:** Demostrar que el bucket está guardando un historial de los cambios en un archivo, en lugar de sobrescribirlo.

### Paso 1: Sube la Primera Versión de un Archivo

```bash
echo "Esta es la versión 1 del archivo." > mi-documento.txt
aws s3 cp mi-documento.txt s3://tu-bucket-principal/
```

> Crea un archivo de prueba y lo sube al bucket principal.

### Paso 2: Sube una Nueva Versión del Mismo Archivo

```bash
echo "Esta es la versión 2, con contenido actualizado." > mi-documento.txt
aws s3 cp mi-documento.txt s3://tu-bucket-principal/
```

> Modifica el archivo local y lo vuelve a subir con el mismo nombre. Gracias al versionado, no sobrescribe el original.

### Paso 3: Verifica el Historial de Versiones

```bash
aws s3api list-object-versions --bucket tu-bucket-principal --prefix mi-documento.txt
```

> Verás una salida en formato JSON con dos objetos para `mi-documento.txt`, cada uno con un `VersionId` distinto. El que tiene `"IsLatest": true` es la versión 2.

### Paso 4 (Opcional): "Borra" el Archivo

```bash
aws s3 rm s3://tu-bucket-principal/mi-documento.txt
```

> En un bucket con versionado, esto no borra los datos. Crea un "marcador de borrado" (`DeleteMarker`) que oculta las versiones anteriores.

### Paso 5: Vuelve a Verificar el Historial

```bash
aws s3api list-object-versions --bucket tu-bucket-principal --prefix mi-documento.txt
```

> Verás una nueva entrada en la lista llamada `"DeleteMarkers"`. Esto confirma que tus datos antiguos están a salvo y pueden ser recuperados.

---

## 🧹 Parte 2: Limpieza Definitiva Post-Prueba

**Objetivo:** Eliminar de forma segura y completa toda la infraestructura, incluyendo los objetos, versiones y marcadores de borrado que creamos en la prueba.

**Por qué es necesario:** Ahora que el bucket contiene objetos, el script `05-destroy-resources.sh` fallará con el error `BucketNotEmpty`. Por eso, debemos usar un método de limpieza más potente con la AWS CLI antes de limpiar el backend.

### Paso 1: Define el Nombre de tus Buckets

```bash
MAIN_BUCKET="tu-bucket-principal"
LOG_BUCKET="tu-bucket-principal-logs"
```

### Paso 2: Vacía y Elimina el Bucket Principal

```bash
aws s3api delete-objects --bucket $MAIN_BUCKET --delete "$(aws s3api list-object-versions --bucket $MAIN_BUCKET --query='{Objects: concat(Versions, DeleteMarkers)[].{Key:Key,VersionId:VersionId}}')" > /dev/null

aws s3 rb s3://$MAIN_BUCKET
```

> Elimina todas las versiones y marcadores de borrado, luego borra el bucket vacío.

### Paso 3: Elimina el Bucket de Logs

```bash
aws s3 rb s3://$LOG_BUCKET --force
```

> Elimina el bucket de logs. Como probablemente esté vacío, no requiere pasos adicionales.

### Paso 4: Limpia el Backend

```bash
./scripts/cleanup-backend.sh
```

> Elimina el bucket de estado y la tabla DynamoDB usados por Terraform.

---

✅ ¡Listo! Con este proceso, has probado una funcionalidad avanzada de SRE y has aplicado un procedimiento de limpieza robusto para dejar tu cuenta de AWS completamente limpia.

