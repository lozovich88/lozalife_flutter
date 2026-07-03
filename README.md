# LozaLife

Flutter-приложение — аналог Trello. Offline First: локальная база данных является единственным источником истины для интерфейса, а сервер (Этап 2) выступает как источник последовательности изменений — архитектура, максимально приближенная к Telegram.

## Запуск

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Тесты:

```bash
flutter test
```

Целевые платформы MVP: iOS, Android, macOS. Для Web требуется дополнительная настройка Drift (sqlite3.wasm + drift_worker.js).

## Структура проекта

```
lib/
  core/
    database/       # Drift: таблицы, DAO, seed, миграции
    design_system/  # переиспользуемые UI-компоненты (кнопки, поля, шиты, диалоги, состояния)
    localization/   # extension context.l10n + экспорт сгенерированных локализаций
    network/        # модели Update/Session (Этап 2)
    router/         # GoRouter
    sync/           # интерфейсы синхронизации (Этап 2)
    theme/          # тема Material 3, константы размеров и таймингов
    utils/          # логгер
  l10n/             # ARB-ресурсы (en, ru) и сгенерированные классы
  features/
    boards/       # data / domain / presentation
    columns/      # data / domain / presentation
    tasks/        # data / domain / presentation
```

Каждая feature разбита на слои Clean Architecture:

- `data/` — datasource (мапперы Drift → domain), реализации репозиториев;
- `domain/` — Freezed-модели, интерфейсы репозиториев;
- `presentation/` — screens, widgets, providers, state, actions.

## Ключевые решения

- **Единственный источник истины** — SQLite (Drift). UI работает только через Drift Streams (`watchBoards`, `watchColumns(boardId)`, `watchTasksByBoard(boardId, searchQuery)`), без ручного обновления состояния.
- **Repository не хранит состояние** — только изменяет БД; экраны обновляются реактивно.
- **Один адаптивный экран** (`AdaptiveBoardShell`): при ширине ≥ 900 dp слева постоянная панель досок (300 dp), справа открытая доска; на узких экранах панель досок скрыта в NavigationDrawer (бургер-меню), после выбора доски drawer закрывается.
- **Поиск задач** — по названию внутри текущей доски, без учёта регистра, частичное совпадение; debounce 300 ms; фильтрация через SQL `LIKE` в SQLite, а не в памяти; колонки без совпадений скрываются.
- **Drag & Drop** — перенос задач внутри колонки и между колонками; после drop обновляются `order` и `columnId`.
- **Дизайн-система** (`core/design_system`) — все UI-элементы собраны в переиспользуемые компоненты: `AppPrimaryButton`, `AppOutlinedIconButton`, `AppTextIconButton`, `AppTextField`, `AppDropdownField`, `AppDatePickerButton`, `AppCard`, `AppDeadlineChip`, `AppSearchField`, `AppSheetLayout`/`showAppSheet`, `showAppNameSheet`, `showAppActionsSheet`, диалоги (`showAppConfirmDialog`, `showAppNameDialog`, `showAppChoiceDialog`, `showAppDecisionDialog`), состояния (`AppLoadingState`, `AppErrorState`, `AppEmptyState`). Feature-виджеты не используют «сырые» Material-компоненты для форм, шитов и диалогов.
- **Локализация** — все строки UI вынесены в ARB-ресурсы (`lib/l10n/app_en.arb`, `app_ru.arb`), классы генерируются `flutter gen-l10n` в `lib/l10n/generated`. Поддерживаются английский и русский (включая плюрализацию счётчиков задач); доступ через `context.l10n`. Даты форматируются локализованно через `MaterialLocalizations`.
- **Перенос задачи на другую доску** — drag&drop карточки на плитку доски в боковой панели (широкие экраны) или пункт «Переместить на доску…» на экране задачи (мобильная альтернатива). Задача попадает в первую колонку целевой доски.
- **Soft delete** (`deletedAt`) — подготовка к серверной синхронизации.
- **`core/sync`** — интерфейсы `SyncManager`, `UpdatesReceiver`, `UpdatesApplier`, `PendingOperationsRepository`, `SnapshotDownloader`, `ConnectivityObserver`, `SyncRepository`; в репозиториях отмечены точки постановки операций в очередь (TODO(sync)).

---

# Техническое задание

## Проект

**LozaLife** (рабочее название) — Flutter-приложение, аналог Trello.

Основной принцип:

- несколько досок;
- каждая доска состоит из колонок;
- каждая колонка содержит задачи;
- вся архитектура сразу проектируется под последующую синхронизацию с сервером.

## Цели MVP (Этап 1)

Реализовать полностью оффлайн-приложение. Источник данных — SQLite (Drift). В дальнейшем источник данных не меняется — сервер лишь присылает изменения, которые применяются к локальной БД (как у Telegram).

## Стек

| Область | Технология |
|---|---|
| Framework | Flutter 3.x, Material 3 |
| State Management | Riverpod 3 |
| Навигация | GoRouter |
| Локальная БД | Drift + sqlite3 |
| DI | Riverpod Provider |
| Immutable модели | Freezed |
| JSON | json_serializable |
| Логирование | logger |

## Архитектура

Clean Architecture, Feature First, Repository Pattern.

```
lib/
  core/
    database/
    network/
    sync/
    theme/
    utils/
  features/
    boards/
    columns/
    tasks/
  shared/
```

Каждая feature содержит `data/` (datasource, repository), `domain/` (models, repository), `presentation/` (screens, widgets, providers, state, actions).

## Модели

Все поля обязательны, даже если на первом этапе не используются.

**Board:** id, name, color, isPinned, order, createdAt, updatedAt, deletedAt

**Column:** id, boardId, name, order, createdAt, updatedAt, deletedAt

**Task:** id, boardId, columnId, title, description, deadline, order, parentTaskId, isArchived, createdAt, updatedAt, deletedAt

## Экран списка досок

- AppBar, список досок, кнопка добавления.
- Карточка доски: название, количество задач.
- Действия: создать, удалить, переименовать, закрепить.
- Swipe влево: закрепить / удалить.
- Закреплённые доски всегда сверху, внутри группы сортировка по `order`.
- Создание доски — BottomSheet (название + кнопка «Создать»); после создания — переход на доску; автоматически создаётся колонка **To Do**.

## Экран доски

- AppBar: название доски; иконка архива присутствует, но функционал отключён.
- Поле поиска под AppBar.
- Горизонтальный список колонок, каждая — фиксированной ширины.
- Минимум одна колонка.

### Адаптивный интерфейс

- **Широкие экраны (≥ 900 dp)** — экран делится на две части: слева постоянная панель со списком досок (300 dp), справа текущая открытая доска. Список досок всегда виден.
- **Узкие экраны (телефоны)** — панель досок скрывается; доступ через NavigationDrawer (бургер-меню) в AppBar. Drawer содержит список досок и кнопку создания. После выбора доски drawer автоматически закрывается.
- Не должно существовать двух разных экранов — один адаптивный экран.

### Поиск задач

- Только внутри текущей доски.
- По названию задачи, без учёта регистра, по частичному совпадению.
- Debounce 300 ms; не выполнять запрос после каждого rebuild.
- Через Drift SQL `LIKE`, а не фильтрацией списка в памяти.
- Во время поиска отображаются только подходящие задачи; колонки без найденных задач скрываются; после очистки — обычная доска.

### Колонки

- Название, количество задач, список задач, кнопка «+».
- Создание (кнопка «+» справа), переименование, удаление.
- Удаление непустой колонки — диалог: «Удалить вместе с задачами» или «Переместить задачи» (с выбором целевой колонки).

### Задачи

- Карточка: название, описание (максимум 3 строки), дедлайн.
- Нажатие открывает экран задачи (название, описание, дедлайн; изменения сохраняются автоматически). Пока без подзадач и комментариев.
- Создание — BottomSheet: название, описание, дата, колонка. После сохранения добавляется в выбранную колонку.

### Drag & Drop

- Изменение порядка задач внутри колонки.
- Перетаскивание задач между колонками.
- После окончания drag обновляются `order` и `columnId`.

## Локальная БД

- Все данные сохраняются сразу.
- UI работает исключительно через Drift Streams.
- Repository никогда не хранит состояние.
- Потоки: `watchBoards()`, `watchColumns(boardId)`, `watchTasks(columnId)`, поиск задач.

## Производительность

- Не использовать `setState` для бизнес-логики — только Riverpod, Streams, Drift.
- Все списки — lazy builders.
- Не допускать полного rebuild всей доски при изменении одной задачи.

## Этап 2 — Серверная синхронизация

Главная идея — не делать REST-запрос каждые 5 секунд, а использовать механизм обновлений как у Telegram.

```
Flutter → Local Database ← Sync Service ← Updates API ← Server
```

UI никогда не работает напрямую с сетью.

**После запуска:** авторизация → получение session → получение state → открытие канала Updates.

**Updates API:** сервер хранит `pts`/`version`; каждое изменение имеет `updateId`, `entity`, `operation`, `payload` (например TaskCreated, TaskUpdated, TaskDeleted, BoardUpdated, ColumnUpdated). Flutter хранит `lastUpdateId` и после подключения вызывает `getUpdates(lastUpdateId)`. Каждый update применяется к локальной БД; UI обновляется автоматически через Drift Streams.

**Оффлайн:** после открытия — `getUpdates(lastUpdateId)`, получаем все пропущенные изменения. Если изменений слишком много, сервер отвечает `needFullSync=true` → `downloadSnapshot()` полностью заменяет локальную БД и сохраняет новый `lastUpdateId`.

**Локальные изменения:** Repository сохраняет локально и добавляет операцию в очередь синхронизации (CreateTask, DeleteTask, MoveTask, RenameTask, …). SyncService отправляет очередь `POST /updates`; после подтверждения удаляет операции.

**Конфликты:** приоритет — Server wins. Позже: optimistic locking, version, merge.

**Архитектура Sync:**

```
SyncManager
├── UpdatesReceiver
├── UpdatesApplier
├── PendingOperations
├── SnapshotDownloader
├── ConnectivityObserver
└── SyncRepository
```

## Основные требования к коду

- Offline First — приложение полноценно работает без сети.
- UI зависит только от локальной базы данных, а не от сетевых запросов.
- Все изменения сначала применяются к локальной БД, затем синхронизируются с сервером.
- Все экраны используют реактивные потоки (Stream) из Drift, без ручного обновления состояния после операций.
- Архитектура расширяемая: архивы, вложенные задачи, комментарии, пользователи и совместная работа не требуют переработки существующих слоёв.
- SOLID, DRY, KISS; виджеты не длиннее 250 строк, классы не длиннее 400 строк; без магических чисел.

## План развития

**Этап 1 — MVP:** управление досками, колонками, задачами; drag & drop между колонками; локальное хранение (Drift); полностью офлайн-работа.

**Этап 2 — Синхронизация:** авторизация; очередь локальных операций; инкрементальные обновления `getUpdates(lastUpdateId)`; применение обновлений к локальной БД; полная синхронизация (snapshot) при необходимости; фоновая синхронизация и восстановление после офлайн-режима.

**Этап 3 — Расширение:** архив задач, подзадачи, метки, вложения, комментарии, совместная работа в реальном времени, push-уведомления.
