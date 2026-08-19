---
title: "مرجع مخزن آینه Docker"
slug: "docker-repositories"
description: "مرجع کامل تمام مخازن تصاویر Docker موجود در رجیستری آینه Docker ایران در docker.repo.mirrory.ir"
date: 2026-08-19T00:00:00Z
draft: false
weight: 10
toc: true
params:
  math: false
  seo:
    title: "مخازن آینه Docker — مرجع کامل"
    description: "فهرست تمام مخازن Docker Hub موجود در رجیستری آینه docker.repo.mirrory.ir"
---

## نمای کلی

این مرجع تمام مخازن تصاویر Docker در دسترس را از طریق رجیستری آینه Docker ایران در `docker.repo.mirrory.ir` فهرست می‌کند. تمام تصاویر از Docker Hub کش می‌شوند و با دسترسی صفر‌تاخیری در دسترس هستند.

**آدرس رجیستری:** `docker.repo.mirrory.ir`

## تصاویر کتابخانه رسمی

بنیاد containerization Docker. تمام تصاویر توسط Docker و سازمان‌های متن‌باز رسمی نگهداری می‌شوند.

### سیستم عامل‌های پایه

- **ubuntu** — توزیع Ubuntu Linux کنونیکال
- **debian** — Debian GNU/Linux
- **alpine** — توزیع Linux سبک
- **centos** — توزیع Linux متن‌باز
- **rockylinux** — توزیع Linux سازگار RHEL
- **fedora** — توزیع Linux پیشرفته
- **busybox** — جعبه ابزار Unix سبک

### رانتایم‌های توسعه

- **python** — مفسر Python (3.12، 3.11، 3.10 و غیره)
- **node** — Node.js JavaScript runtime
- **golang** — زبان برنامه‌نویسی Go
- **rust** — زبان برنامه‌نویسی Rust
- **openjdk** — کیت توسعه Java متن‌باز
- **php** — زبان اسکریپت PHP
- **ruby** — زبان برنامه‌نویسی Ruby
- **perl** — زبان برنامه‌نویسی Perl
- **dotnet** — رانتایم .NET
- **gradle** — سیستم ساخت Gradle
- **maven** — سیستم ساخت Maven

### وب سرور و پروکسی

- **nginx** — وب سرور کارایی بالا و پروکسی معکوس
- **apache2** — Apache HTTP Server
- **httpd** — Apache HTTP Server (جایگزین)
- **traefik** — پروکسی معکوس و موازنه بار مدرن
- **caddy** — چاقوی سوئیسی وب سرور

### پایگاه داده

- **postgres** — پایگاه داده رابطه‌ای PostgreSQL
- **mysql** — پایگاه داده رابطه‌ای MySQL
- **mariadb** — پایگاه داده سازگار MySQL
- **mongodb** — پایگاه داده سند NoSQL
- **redis** — ذخیره‌سازی ساختار داده در حافظه
- **cassandra** — پایگاه داده NoSQL توزیع شده
- **elasticsearch** — موتور جستجو و تجزیه و تحلیل
- **influxdb** — پایگاه داده سری‌های زمانی
- **couchdb** — پایگاه داده سند‌محور NoSQL
- **memcached** — کش حافظه توزیع شده
- **neo4j** — پایگاه داده نمودار

### صف‌های پیام و جریان

- **rabbitmq** — دلال پیام متن‌باز
- **kafka** — پلتفرم جریان رویداد توزیع شده
- **nats** — سیستم پیام cloud-native
- **redis** — همچنین برای پیام‌های pub/sub
- **activemq** — دلال پیام متن‌باز

### آرکسترشن کانتینر و Cloud Native

- **kubernetes** — آرکسترشن Kubernetes (نسخه‌های مختلف)
- **etcd** — ذخیره‌سازی کلید-مقدار توزیع شده برای Kubernetes
- **consul** — service mesh و service discovery
- **vault** — مدیریت اسرار

### نظارت و مشاهده

- **prometheus** — معیارها و هشدارها
- **grafana** — تجسم و داشبورد
- **influxdb** — پایگاه داده سری‌های زمانی برای معیارها
- **telegraf** — عامل جمع‌آوری معیارها
- **jaeger** — ردیابی توزیع شده
- **logstash** — خط لوله پردازش داده
- **kibana** — تجسم Elasticsearch
- **fluentd** — جمع‌کننده داده برای ثبت‌ورود متحد

### ابزارهای CI/CD

- **jenkins** — سرور خودکارسازی
- **gitlab-runner** — رونده GitLab CI/CD
- **gitea** — سرویس Git خود‌میزبان
- **drone** — پلتفرم توصیل مداوم
- **nexus** — مدیر مخزن

### آزمایش و QA

- **selenium** — خودکارسازی مرورگر وب
- **chromium** — chromium بدون سر برای آزمایش
- **cypress** — چارچوب آزمایش end-to-end

### ذخیره‌سازی و سیستم‌های فایل

- **minio** — سرور ذخیره‌سازی شی (S3-compatible)
- **ceph** — سیستم ذخیره‌سازی توزیع شده
- **glusterfs** — ذخیره‌سازی مقیاسی

### امنیت

- **vault** — مدیریت اسرار
- **openldap** — سرویس دایرکتوری LDAP
- **keycloak** — مدیریت هویت و دسترسی

## ناشران تأیید‌شده

تصاویر منتخب از سازمان‌های تأیید شده Docker.

- **mongo** — MongoDB رسمی
- **mysql** — MySQL رسمی
- **postgres** — PostgreSQL رسمی
- **redis** — Redis رسمی
- **nginx** — Nginx رسمی
- **rabbitmq** — RabbitMQ رسمی
- **elasticsearch** — Elasticsearch رسمی
- **kafka** — Kafka کنفلوئنت
- **consul** — HashiCorp Consul
- **vault** — HashiCorp Vault
- **prom/prometheus** — پروژه Prometheus
- **grafana/grafana** — Grafana لب‌ها Grafana
- **circleci/circleci-docs** — اسناد CircleCI
- **microsoft/dotnet** — تصاویر .NET مایکروسافت

## تصاویر جامعه

میلیون‌ها تصویر نگهدارندگان جامعه. دسته‌های مشترک:

### چارچوب و سرورهای برنامه

- **django** — چارچوب وب Python
- **flask** — چارچوب وب Python سبک
- **express** — چارچوب وب Node.js
- **spring** — چارچوب برنامه Java
- **rails** — چارچوب وب Ruby
- **laravel** — چارچوب وب PHP
- **asp.net** — چارچوب وب .NET
- **tomcat** — سرور برنامه Java
- **jetty** — سرور وب Java
- **jboss** — سرور برنامه سازمانی

### یادگیری ماشین و علم داده

- **tensorflow** — چارچوب یادگیری عمیق
- **pytorch** — چارچوب یادگیری عمیق
- **jupyter** — محاسبات تعاملی
- **anaconda** — پلتفرم علم داده Python
- **r-base** — محاسبات آماری R

### بهره‌وری و ابزارها

- **wordpress** — پلتفرم وب‌سایت
- **nextcloud** — سنکرونایز و اشتراک فایل
- **gitlab** — پلتفرم مخزن Git
- **gitea** — سرویس Git سبک
- **mattermost** — ارتباطات تیم
- **rocket.chat** — گفتگوی متن‌باز
- **zulip** — گفتگوی تیم متن‌باز
- **discourse** — پلتفرم بحث جامعه

### رسانه و محتوا

- **jellyfin** — سرور رسانه
- **plex** — سرور رسانه
- **pihole** — مسدود‌کننده تبلیغات سطح DNS
- **sonarr** — خودکارسازی نمایش تلویزیونی
- **radarr** — خودکارسازی فیلم
- **lidarr** — خودکارسازی موسیقی

## بکشیدن تصاویر

### بکشیدن اساسی

```bash
docker pull docker.repo.mirrory.ir/library/nginx:latest
```

### بکشیدن تصویر جامعه

```bash
docker pull docker.repo.mirrory.ir/tensorflow/tensorflow:latest
```

### نسخه خاص

```bash
docker pull docker.repo.mirrory.ir/library/postgres:15-alpine
```

## نام‌گذاری تصویر

تمام تصاویر به نام‌گذاری Docker Hub پیروی می‌کنند:

- **تصاویر رسمی:** `docker.repo.mirrory.ir/library/IMAGE:tag`
- **ناشر تأیید‌شده:** `docker.repo.mirrory.ir/PUBLISHER/IMAGE:tag`
- **تصاویر جامعه:** `docker.repo.mirrory.ir/USERNAME/IMAGE:tag`

## معماری‌های پشتیبانی‌شده

تمام تصاویر در معماری‌های متعدد در دسترس هستند:

- `amd64` — Intel/AMD 64-bit (رایج‌ترین)
- `arm64` — ARM 64-bit (Apple Silicon، Android مدرن، RPi جدید)
- `arm/v7` — ARM 32-bit (Raspberry Pi قدیم، برخی IoT)
- `ppc64le` — PowerPC 64-bit little-endian
- `s390x` — معماری IBM System z

انتخاب معماری خودکار است — Docker نسخه صحیح را برای سیستم شما بکشد.

## کش‌کردن و به‌روزرسانی

**تصاویر جدید:** اگر تصویری در کش ما نیست، آن را به طور خودکار از Docker Hub می‌بریم و برای کش‌های آینده کش می‌کنیم.

**تصاویر فرسوده:** ما تمام تصاویر کش‌شده را با Docker Hub بروز نگه می‌داریم. به‌روزرسانی‌ها هر ساعت هماهنگ می‌شوند.

**تایید تصویر:** تمام تصاویر برای اطمینان از صحت بر اساس Docker Hub تأیید می‌شوند.

## آینه‌ها برای رجیستری‌های دیگر

فراتر از Docker Hub، ما همچنین آینه‌سازی می‌کنیم:

- **GitHub Container Registry (GHCR)** — `ghcr.repo.mirrory.ir`
- **Google Container Registry (GCR)** — `gcr.repo.mirrory.ir`
- **Amazon ECR Public** — `ecr.repo.mirrory.ir`

مرجع مکمل رجیستری را برای تمام آینه‌های در دسترس [مشاهده کنید](/docs/reference/mirror-registries/).

## کارایی

اوقات بکشیدن معمول:

- **بکشیدن اول (cache miss):** 30-120 ثانیه (بسته به اندازه تصویر)
- **بکشیدن بعدی (cache hit):** 5-30 ثانیه
- **Bandwidth:** بدون محدود‌کردن نرخ

برای تصاویر بسیار بزرگ (1GB+)، بکشیدن ممکن است زمان‌بر باشد اما هنوز هم سریع‌تر از لینک‌های بین‌المللی است.

## محدودیت‌ها و ملاحظات

- **تصاویر باید عمومی باشند** — تصاویر Docker Hub خصوصی آینه‌سازی نمی‌شوند
- **سازگاری لایه** — تمام لایه‌ها از منبع کش می‌شوند؛ لایه‌های حذف‌شده در دسترس نیست
- **تغییر‌پذیری برچسب** — اگر نویسنده تصویر محتوای برچسب را تغییر دهد، کش ما در نهایت منعکس می‌شود (در 24 ساعت)

## گزارش مسائل

تصویری گم شده یافتید؟ خرابی تصویر؟ مسئله کارایی؟

[یک مسئله را در GitHub باز کنید](https://github.com/iran-mirror/mirrory/issues) با:
- نام و برچسب تصویر
- پیام خطا یا رفتار
- جزئیات سیستم شما (سیستم عامل، نسخه Docker، معماری)

ما در 24 ساعت بررسی و حل خواهیم کرد.

## چه آن‌چه می‌آید

- **آینه‌های منطقه‌ای** — آینه‌های جداگانه برای ISP‌های متفاوت
- **آمار استفاده** — ببینید کدام تصاویر محبوب‌ترین هستند
- **احراز هویت آینه** — دسترسی اختیاری بر اساس توکن
- **پشتیبانی Webhook** — اطلاعیه‌های زمانی که تصاویر به‌روزرسانی شوند

---

**آخرین به‌روزرسانی:** 2026-08-19

تمام تصاویر در این صفحه در `docker.repo.mirrory.ir` در دسترس هستند. امروز شروع به استفاده کنید.
