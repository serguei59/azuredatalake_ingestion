# azuredatalake_ingestion
brief azure data lake 1 data engineer simplon: Ingestion avancée : déclencheurs, récurrence, incrémentielle (Data Factory)

# Azure Data Ingestion Project

Ce projet configure une ingestion programmée de données de **Blob Storage** vers **Data Lake** en utilisant **Azure Data Factory** et **AzCopy**.

## Structure

- `.env` : Fichier contenant les variables d'environnement.
- `scripts/` : Dossier contenant tous les scripts de configuration et de déploiement.

## Instructions

### 1. Configurer les Variables d’Environnement

Modifiez `.env` avec vos paramètres Azure.

### 2. Créer le Groupe de Ressources

```bash
./scripts/create_resource_group.sh
```

### 3. Créer les ressources Azure

```bash
./scripts/create_blob_storage_account.sh
```

```bash
./scripts/create_data_lake.sh
```

```bash
./scripts/create_data_factory.sh
```

### 4. Téléchargez les données Sample

### 5. Générer les SAS Tokens

```bash
./scripts/generate_sas_token.sh
```

### 6. Transférer les données locales vers le Blob Storage

### 7. Déployer le Pipeline



