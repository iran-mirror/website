---
title: "نحوه استفاده از Docker Registry Mirrors در Linux"
slug: "docker-mirror-linux"
description: "یاد بگیرید چگونه Docker را برای استفاده از registry mirrors پیکربندی کنید تا pull image ها سریع‌تر و مصرف پهنای باند کمتر شود"
date: 2026-08-19
draft: false
weight: 10
toc: true
categories: ["Docker", "Container Registry"]
tags: ["Docker", "mirrors", "Linux", "پیکربندی"]
contributors: []
params:
  math: false
  seo:
    title: "پیکربندی Docker Registry Mirrors در Linux"
    description: "راهنمای گام‌به‌گام برای راه‌اندازی Docker registry mirrors در Linux جهت pull سریع‌تر و پایایی بیشتر"
    canonical: ""
    robots: ""
---

## نمای کلی

Docker registry mirrors سرعت pull image ها را با ذخیره‌سازی layers در نزدیکی زیرساخت خود افزایش می‌دهند، هزینه‌های پهنای باند را کاهش می‌دهند و تحمل به قطعی‌های upstream registry بهبود می‌بخشند. این راهنما مراحل پیکربندی Docker برای استفاده از mirror registries در سیستم‌های Linux را شرح می‌دهد.

در پایان، خواهید توانست:
- نحوه کار Docker در یافتن و استفاده از mirror registries را درک کنید
- Docker daemon را برای استفاده از یک یا چند mirror پیکربندی کنید
- اتصال mirror را تأیید کنید و pull image ها را آزمایش کنید
- مسائل مرتبط با mirror را حل کنید

## پیش‌نیازها

- Docker نصب شده و در حال اجرا روی سیستم Linux (Ubuntu, Debian, CentOS, Fedora و غیره)
- دسترسی root یا sudo برای تغییر تنظیمات Docker
- آشنایی اولیه با فایل‌های پیکربندی JSON
- دسترسی شبکه‌ای به Docker Hub و mirror registries شما

## گام 1: درک پیکربندی Docker Mirror

Docker mirrors در فایل پیکربندی daemon در `/etc/docker/daemon.json` پیکربندی می‌شوند. وقتی که mirror برای یک registry مشخص کنید، Docker ابتدا سعی می‌کند image ها را از mirror بکشد و اگر نیاز باشد، به registry اصلی برمی‌گردد.

**مفاهیم کلیدی:**
- **Registry اصلی**: منبع پیش‌فرض (مثلاً Docker Hub برای image هایی مانند `nginx:latest`)
- **Mirror registry**: منبع جایگزینی که layers را از registry اصلی ذخیره می‌کند
- **رفتار بازگشت**: Docker به‌طور خودکار اگر mirror ناموفق باشد، به registry اصلی مراجعه می‌کند

## گام 2: ایجاد یا ویرایش فایل پیکربندی Docker Daemon

اگر فایل `/etc/docker/daemon.json` وجود ندارد، آن را ایجاد کنید:

```bash
sudo touch /etc/docker/daemon.json
```

فایل را با ویرایشگر مورد نظر خود باز کنید:

```bash
sudo nano /etc/docker/daemon.json
```

یا

```bash
sudo vim /etc/docker/daemon.json
```

## گام 3: پیکربندی یک Mirror منفرد

ساده‌ترین پیکربندی از یک mirror برای Docker Hub استفاده می‌کند. کلید `"registry-mirrors"` را اضافه یا بروزرسانی کنید:

```json
{
  "registry-mirrors": ["https://docker.repo.mirrory.ir"]
}
```

اگر فایل شامل تنظیمات دیگری است، کلید `registry-mirrors` را ادغام کنید:

```json
{
  "debug": false,
  "storage-driver": "overlay2",
  "registry-mirrors": ["https://docker.repo.mirrory.ir"]
}
```

## گام 4: پیکربندی چندین Mirror (اولویت بازگشت)

برای مشخص کردن چندین mirror، Docker آن‌ها را به ترتیب امتحان می‌کند. اولین mirror در دسترس استفاده می‌شود؛ اگر ناموفق باشد، Docker به ترتیب دوباره تلاش می‌کند:

```json
{
  "registry-mirrors": [
    "https://docker.repo.mirrory.ir",
    "https://docker-mirror.backup.local"
  ]
}
```

Docker mirrors را به ترتیب فهرست امتحان می‌کند. این برای تکرار و توزیع بار استفاده شود.

## گام 5: پیکربندی Mirrors برای Registries خاص

برای registries دیگر (مثلاً GitHub Container Registry، Google Container Registry)، از `"registry-mirrors"` به عنوان کلید زیر هر registry در شیء `"registries"` استفاده کنید:

```json
{
  "registry-mirrors": ["https://docker.repo.mirrory.ir"],
  "registries": {
    "ghcr.io": {
      "mirrors": ["https://ghcr.repo.mirrory.ir"]
    },
    "gcr.io": {
      "mirrors": ["https://gcr.repo.mirrory.ir"]
    }
  }
}
```

این پیکربندی:
- برای Docker Hub images از `docker.repo.mirrory.ir` استفاده می‌کند
- برای GitHub Container Registry (`ghcr.io`) از `ghcr.repo.mirrory.ir` استفاده می‌کند
- برای Google Container Registry (`gcr.io`) از `gcr.repo.mirrory.ir` استفاده می‌کند

## گام 6: بارگذاری Docker Daemon و تأیید پیکربندی

فایل پیکربندی را ذخیره کنید و Docker daemon را بارگذاری کنید:

```bash
sudo systemctl reload docker
```

اگر Docker از systemd استفاده نمی‌کند:

```bash
sudo service docker restart
```

تأیید کنید که پیکربندی بارگذاری شده است:

```bash
docker info | grep -A 5 "Registry Mirrors"
```

خروجی باید mirror registry شما را نشان دهد:

```
Registry Mirrors:
 https://docker.repo.mirrory.ir/
```

## گام 7: آزمایش اتصال Mirror

یک image آزمایشی بکشید تا تأیید کنید mirror کار می‌کند:

```bash
docker pull nginx:latest
```

pull را نظارت کنید تا تأیید کنید mirror استفاده می‌شود. برای رویدادهای مرتبط با mirror، لاگ‌های Docker را بررسی کنید:

```bash
sudo journalctl -u docker --since "5 min ago" | grep -i mirror
```

یا در سیستم‌هایی که از logging داخلی Docker استفاده می‌کنند:

```bash
docker events --filter type=image &
docker pull nginx:latest
```

## گام 8: تأیید Cache و عملکرد

برای تأیید اینکه mirror layers را ذخیره می‌کند، همان image را دوباره بکشید. باید سریع‌تر تکمیل شود:

```bash
docker pull nginx:latest
# دومین pull باید در چند ثانیه تکمیل شود، که cache hits را نشان می‌دهد
```

تاریخ pull را با خروجی مفصل بررسی کنید:

```bash
docker pull --verbose nginx:latest 2>&1 | grep -E "Pulling|Downloaded|Pull complete"
```

## گام 9: مدیریت احراز هویت (اگر لازم باشد)

اگر mirror registry شما به احراز هویت نیاز دارد، اعتبارات را در `~/.docker/config.json` پیکربندی کنید:

```bash
docker login docker.repo.mirrory.ir
```

این اعتبارات رمزگذاری شده را ذخیره می‌کند که Docker هنگام pull از mirror به‌طور خودکار استفاده می‌کند.

تأیید کنید اعتبارات ذخیره شده‌اند:

```bash
cat ~/.docker/config.json | jq '.auths'
```

## گام 10: حل مسائل متداول

### Mirror قابل دسترس نیست

اتصال شبکه‌ای به mirror را بررسی کنید:

```bash
curl -I https://docker.repo.mirrory.ir/v2/
```

پاسخ مورد انتظار: `200 OK` یا `401 Unauthorized` (اگر احراز هویت لازم باشد).

### Docker به جای استفاده از mirror، به registry اصلی برمی‌گردد

لاگ‌های daemon را بررسی کنید:

```bash
sudo journalctl -u docker -n 50
```

به دنبال خطاهایی مثل `connection refused` یا `certificate verify failed` باشید.

تأیید کنید URL mirror در `daemon.json` صحیح است و daemon بارگذاری شده است.

### Pull موفق است اما pull های بعدی کند هستند

mirror ممکن است layers را به درستی ذخیره نکند. تأیید کنید:

1. ذخیره‌سازی mirror دارای فضای کافی است
2. سرویس mirror در حال اجرا است (اگر mirror containerized است `docker ps`)
3. تأخیر شبکه بین Docker host و mirror کم است (`ping mirror.example.com`)

### خطاهای گواهینامه ("x509: certificate signed by unknown authority")

اگر از گواهینامه خودتوقیع استفاده می‌کنید، تأیید TLS را غیرفعال کنید (برای production توصیه نمی‌شود):

```json
{
  "insecure-registries": ["docker.repo.mirrory.ir"],
  "registry-mirrors": ["https://docker.repo.mirrory.ir"]
}
```

راه‌حل بهتر: گواهینامه CA mirror را به ذخیره‌سازی اعتماد سیستم خود اضافه کنید:

```bash
sudo cp docker-repo-mirrory-ir-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
sudo systemctl reload docker
```

## بهترین روش‌ها

1. **از HTTPS استفاده کنید**: همیشه برای URL mirror در production از `https://` استفاده کنید تا از حملات man-in-the-middle جلوگیری شود.
2. **موجودی mirror را نظارت کنید**: برای تکرار، چندین mirror را شامل کنید؛ Docker به‌طور خودکار failover می‌کند.
3. **منظم آزمایش کنید**: هر‌چند وقت یکبار image بکشید تا اطمینان حاصل کنید mirror کار می‌کند.
4. **mirrors را به‌روز نگه دارید**: اطمینان حاصل کنید mirror registry نسخه اخیر و امن را اجرا می‌کند.
5. **راه‌اندازی خود را مستند کنید**: `daemon.json` را با نظرات توضیح دهنده چرایی پیکربندی mirrors شرح‌حال کنید.
6. **تأثیر را اندازه‌گیری کنید**: زمان pull و مصرف پهنای باند را قبل و بعد از فعال کردن mirrors مقایسه کنید.

## گام‌های بعدی

- **درباره پروتکل‌های mirror یاد بگیرید**: Docker Registry V2 API و نحوه پیاده‌سازی mirror را درک کنید
- **mirror خود را راه‌اندازی کنید**: یک mirror registry خصوصی برای محیط‌های air-gapped یا offline استقرار دهید
- **سلامت mirror را نظارت کنید**: برای عدم دسترسی mirror یا عملکرد ضعیف، هشدار را راه‌اندازی کنید
- **caching layer را بهینه کنید**: ذخیره‌سازی mirror و سیاست‌های garbage collection را پیکربندی کنید

## خلاصه

Docker registry mirrors روش قدرتمندی برای بهبود عملکرد pull image و کاهش پهنای باند است. با مراحل پیکربندی بالا، شما می‌توانید:

- ✓ یک یا چند mirror را پیکربندی کنید
- ✓ mirror را برای registry های خاص تعیین کنید
- ✓ عملکرد mirror را تأیید کنید
- ✓ مسائل متداول را حل کنید
- ✓ بهترین روش‌های امنیتی و پایایی را اعمال کنید

برای جزئیات بیشتر، [اسناد Docker در مورد registry mirrors](https://docs.docker.com/docker-hub/mirror/) و راهنمای پیکربندی provider mirror خود را مراجعه کنید.
