# 📌 SSHFS Mount in Docker (Alpine)
Easily mount an **SFTP folder** inside a **Docker container** on your **Synology NAS** (or any Linux system) using **Alpine Linux + SSHFS**.

---

## 🚀 Features
✅ **Lightweight**: Uses Alpine Linux (minimal footprint).  
✅ **Persistent SFTP Mount**: Auto-mounts SFTP when the container starts.  
✅ **Secure**: Uses **SSH key authentication** (optional).  
✅ **Synology NAS Compatible**: Works without modifying DSM.  
✅ **Docker Compose Support**: Easy to deploy and manage.

---

## 📂 Folder Structure
```
/your-project-folder
│── Dockerfile
│── docker-compose.yml
│── ssh_keys/       # Stores SSH keys for authentication (optional)
│── README.md
```

---

## 🛠️ Setup Guide

### 1️⃣ Prerequisites
- **Docker** installed (Synology users: install via **Package Center**).
- **Docker Compose** installed.
- An **SFTP server** you can connect to.

---

### 2️⃣ Clone This Repository
```sh
git clone https://github.com/yourusername/sshfs-docker.git
cd sshfs-docker
```

---

### 3️⃣ Generate an SSH Key (Optional)
If your SFTP server requires **SSH key authentication**, generate a key on your NAS:
```sh
ssh-keygen -t rsa -b 4096 -f ./ssh_keys/id_rsa
```
Then, **add the public key** to your **SFTP server**:
```sh
ssh-copy-id -i ./ssh_keys/id_rsa.pub user@sftp-server
```

---

### 4️⃣ Navigate to the Project Folder
After cloning the repository, move into the project directory:

```sh
cd sshfs-docker
```
This folder already contains:
- `Dockerfile` (Alpine-based SSHFS setup)
- `docker-compose.yml` (Defines the SSHFS service)

---

### 5️⃣ Update Configuration Variables
Before running the container, update the relevant variables in `docker-compose.yml`:
- **SFTP Credentials:** Update `user@sftp-server` with your SFTP login details.
- **Remote Path:** Modify `/remote/path` to the correct SFTP folder.
- **Local Mount Path:** Ensure `/volume1/remote_sftp` points to your desired NAS folder.
- **SSH Key Path (Optional):** If using key authentication, ensure `./ssh_keys/id_rsa` exists and is correctly referenced.

---

### 6️⃣ Build & Run the Container
```sh
docker-compose up -d
```
This will:
✅ **Build the image**  
✅ **Start the SSHFS container**  
✅ **Mount the SFTP folder to `/volume1/remote_sftp`**  

---

### 7️⃣ Verify the Mount
Check if the folder is accessible on your **NAS**:
```sh
ls /volume1/remote_sftp
```

---

## 🔄 Managing the Container
- **Stop the container**:
  ```sh
  docker-compose down
  ```
- **Restart the container**:
  ```sh
  docker-compose up -d
  ```
- **Rebuild the container (if you change the Dockerfile)**:
  ```sh
  docker-compose build
  docker-compose up -d
  ```

---

## 🛠️ Troubleshooting
**Issue**: "Permission denied" when accessing the SFTP folder.  
✅ **Fix**: Ensure correct SSH key permissions inside the container:
```sh
chmod 600 ssh_keys/id_rsa
```

**Issue**: "Read-only file system" inside the mount folder.  
✅ **Fix**: Add `-o idmap=user` to the `sshfs` command in `docker-compose.yml`.

**Issue**: "Connection refused" when mounting SFTP.  
✅ **Fix**: Ensure your **SFTP server** allows SSHFS connections.
