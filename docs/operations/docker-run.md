# Запуск Mago Studio в Docker Compose

## Команды

| Команда | Что делает |
|---------|------------|
| `make up` | Поднять оба сервиса (magostudio + comfiui) |
| `make down` | Остановить и удалить контейнеры |
| `make restart` | Перезапустить контейнеры |
| `make rebuild` | Остановить и собрать заново |
| `make logs` | Показать логи |
| `make status` | Статус контейнеров |

## Сервисы и порты

| Сервис | Порт хоста | Для чего |
|--------|------------|----------|
| magostudio-app | `7008` | Интерфейс Mago Studio |
| magostudio-comfiui | `8188` | ComfyUI Portable (локальная генерация) |
| mock-auth | `9999` | Заглушка аутентификации (без аккаунта Mago Cloud) |

## Рабочая директория и вольюмы

Все вольюмы — хост-пути, данные сохраняются между рестартами:

| Папка хоста | Назначение |
|-------------|------------|
| `./source` | Исходные видео и файлы |
| `./video-output` | Готовое видео / результат |
| `./work` | Рабочие файлы |
| `./data` | Данные приложения |
| `./comfyui-models` | Модели ComfyUI |
| `./comfyui-output` | Выход ComfyUI |

## Локальные модели (без облака)

По умолчанию включены: **MiniMax H3** (видео) + **Qwen3-VL 4B** (подписи).

Чтобы добавить модель:
1. Скачайте файл модели (ссылки и SHA-256 — в `docs-public/manual-setup.md`).
2. Положите в `./comfyui-models/<папка>/`:
   - `models/diffusion_models/` — диффузионные модели
   - `models/loras/` — LoRA
   - `models/vae/` — VAE
   - `models/text_encoders/` — текстовые энкодеры
   - `models/clip_vision/` — CLIP vision
3. `make restart comfiui`
4. В приложении: **Settings → Set up local rendering → I already have ComfyUI**

## Сценарий → видео (Mago Director)

1. Откройте `http://localhost:7008`.
2. Левая панель → **Mago Director** → создать проект.
3. Вставьте текст сценария в поле **Script**.
4. **Cast** — сценарий разобьётся на сцены (shots).
5. **Assets** — референсные изображения (Qwen Image / Flux Image).
6. **Shots** — видео для каждой сцены через MiniMax H3.
7. **Timeline** — скорректируйте порядок и выберите лучшие takes.
8. **Render / Export** — готовое видео в `./video-output`.

## Сценарий → видео (Video to Video)

1. Главная → **Video to Video**.
2. Загрузите исходное видео.
3. Выберите модель (MiniMax H3) и LoRA/VFX при необходимости.
4. **Render** — результат в `./video-output`.

## Проблемы

| Симптом | Действие |
|---------|----------|
| Страница обновляется по кругу / `api-key-error` | Hard refresh браузера (`Ctrl+Shift+R`) |
| Контейнер не запускается | `make rebuild` |
| Только интерфейс, нет ComfyUI | `make comfiui` |

<!-- обновлено: 2026-11-03 -->
