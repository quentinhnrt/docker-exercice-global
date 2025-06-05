# 🚀 Infrastructure PrestaShop Dockerisée & Supervisée

## 📌 Objectif

Ce projet met en place une infrastructure de type **production** autour d’une instance PrestaShop entièrement conteneurisée, avec reverse proxy sécurisé, monitoring, alertes, CI/CD, backups automatiques, et outils de gestion.

---

## 🐂 Contenu du Projet

```bash
exercice-global/
├── docker-compose.yml
├── Dockerfile 
├── .github/workflows/ 
├── nginx.conf         
├── prometheus.yml        
├── alert.rules         
├── alertmanager.yml        
├── configure_alertmanager.sh 
├── nginx/ssl/     
├── backup/                 
│   ├── Dockerfile
│   ├── backup.sh
│   └── entrypoint.sh
```

---

## 🔀 Architecture Déployée

* `PrestaShop` avec thème personnalisé
* `MySQL` pour base de données
* `phpMyAdmin` pour gestion MySQL
* `NGINX` en reverse proxy HTTPS
* Stack `Prometheus + Grafana + cAdvisor + Node Exporter + Alertmanager`
* Système de `backup MySQL` automatique
* Système d'emails d'alertes via `Mailhog`

---

## ⚙️ Mise en place

### 1. Cloner le projet

```bash
git clone https://github.com/quentinhnrt/docker-exercice-global.git
cd exercice-global
```

### 2. Créer un fichier `.env`

```env
DB_SERVER=db
DB_NAME=prestashop
DB_USER=prestashop
DB_PASSWD=prestashop
MYSQL_ROOT_PASSWORD=root
PS_DOMAIN=localhost
PS_INSTALL_AUTO=1
PS_ENABLE_SSL=1
PS_FOLDER_ADMIN=dashboard
ADMIN_MAIL=email@prestashop.local
ADMIN_PASSWD=motdepasse_test
PS_LANGUAGE=fr
```

### 3. Lancer l’infrastructure

```bash
docker-compose up -d --build
```

---

## 🔐 Accès aux interfaces

| Service      | URL                                            | Identifiants par défaut                                           |
| ------------ | ---------------------------------------------- | ----------------------------------------------------------------- |
| PrestaShop   | [https://localhost](https://localhost)         | email@prestashop.local / motdepasse_test |
| phpMyAdmin   | [http://localhost:8081](http://localhost:8081) | prestashop / prestashop                                           |
| Grafana      | [http://localhost:3000](http://localhost:3000) | admin / admin                                                     |
| Prometheus   | [http://localhost:9090](http://localhost:9090) | —                                                                 |
| Alertmanager | [http://localhost:9093](http://localhost:9093) | —                                                                 |
| Mailhog      | [http://localhost:8025](http://localhost:8025) | —                                                                 |

> 💡 Accès admin PrestaShop via `/dashboard`

---

## 📊 Monitoring

* **Prometheus** : Scrape métriques
* **Grafana** : Dashboards personnalisés
* **cAdvisor** : Monitoring des conteneurs
* **Node Exporter** : Monitoring du système hôte
* **Alertmanager** : Alertes critiques
* **Mailhog** : Réception des alertes email

---

## 🚨 Exemple d’alerte

```yaml
- alert: HighMemoryUsage
  expr: node_memory_MemTotal_bytes - node_memory_MemFree_bytes > node_memory_MemTotal_bytes * 0.9
  for: 5m
  labels:
    severity: critical
  annotations:
    summary: "High memory usage detected"
    description: "Memory usage is above 90% for more than 5 minutes."
```

---

## 💾 Backup automatique

* Sauvegardes toutes les 6 heures via `cron`
* Stockées dans `/backups`
* Rotation automatique : garde les **6 dernières**

---

## 🔁 Pipeline CI/CD

* Déclenché à chaque `push` sur la branche `main`
* Étapes :

    * Build image Docker
    * Push vers Docker Hub

Fichier : `.github/workflows/ci-cd.yml`

---

## 🛡️ Sécurité

* Tous les conteneurs tournent sur un réseau Docker isolé
* Utilisation de certificats SSL auto-signés
* Variables sensibles stockées dans un `.env`
* Accès restreint via reverse proxy HTTPS

---

## 📘️ Captures demandées (non incluses ici)

* Interface PrestaShop
* phpMyAdmin
* Dashboard Grafana (RAM/CPU, uptime)
* Logs Prometheus
* Sauvegardes dans le volume Docker
