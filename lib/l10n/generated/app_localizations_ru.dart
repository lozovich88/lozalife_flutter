// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'LozaLife';

  @override
  String get boardsTitle => 'Доски';

  @override
  String get createBoardTooltip => 'Создать доску';

  @override
  String get noBoardsYet => 'Досок пока нет.\nНажмите +, чтобы создать.';

  @override
  String failedToLoadBoards(String error) {
    return 'Не удалось загрузить доски: $error';
  }

  @override
  String boardTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count задачи',
      many: '$count задач',
      few: '$count задачи',
      one: '$count задача',
    );
    return '$_temp0';
  }

  @override
  String get newBoardTitle => 'Новая доска';

  @override
  String get renameBoardTitle => 'Переименовать доску';

  @override
  String get createAction => 'Создать';

  @override
  String get saveAction => 'Сохранить';

  @override
  String get deleteAction => 'Удалить';

  @override
  String get cancelAction => 'Отмена';

  @override
  String get pinAction => 'Закрепить';

  @override
  String get unpinAction => 'Открепить';

  @override
  String get renameAction => 'Переименовать';

  @override
  String get nameLabel => 'Название';

  @override
  String deleteBoardQuestion(String name) {
    return 'Удалить «$name»?';
  }

  @override
  String get deleteBoardWarning => 'Доска и все её задачи будут удалены.';

  @override
  String get selectBoardHint => 'Выберите доску или создайте новую';

  @override
  String get archiveTooltip => 'Архив (скоро)';

  @override
  String get searchTasksHint => 'Поиск задач';

  @override
  String get noTasksFound => 'Задачи не найдены';

  @override
  String failedToLoadColumns(String error) {
    return 'Не удалось загрузить колонки: $error';
  }

  @override
  String get addColumnAction => 'Добавить колонку';

  @override
  String get newColumnTitle => 'Новая колонка';

  @override
  String get renameColumnTitle => 'Переименовать колонку';

  @override
  String deleteColumnQuestion(String name) {
    return 'Удалить «$name»?';
  }

  @override
  String columnContainsTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'В колонке $count задачи.',
      many: 'В колонке $count задач.',
      few: 'В колонке $count задачи.',
      one: 'В колонке $count задача.',
    );
    return '$_temp0';
  }

  @override
  String get moveTasksAction => 'Переместить задачи';

  @override
  String get deleteWithTasksAction => 'Удалить вместе с задачами';

  @override
  String get moveTasksToTitle => 'Переместить задачи в';

  @override
  String get addTaskAction => 'Добавить задачу';

  @override
  String get newTaskTitle => 'Новая задача';

  @override
  String get titleLabel => 'Название';

  @override
  String get descriptionLabel => 'Описание';

  @override
  String get deadlineLabel => 'Дедлайн';

  @override
  String get columnLabel => 'Колонка';

  @override
  String get taskScreenTitle => 'Задача';

  @override
  String get deleteTaskTooltip => 'Удалить задачу';

  @override
  String failedToLoadTask(String error) {
    return 'Не удалось загрузить задачу: $error';
  }

  @override
  String get taskNotFound => 'Задача не найдена';

  @override
  String get setDeadlineAction => 'Указать дедлайн';

  @override
  String get clearDeadlineTooltip => 'Очистить дедлайн';

  @override
  String get moveToBoard => 'Переместить на доску…';
}
