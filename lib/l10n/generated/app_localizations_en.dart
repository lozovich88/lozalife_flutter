// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'LozaLife';

  @override
  String get boardsTitle => 'Boards';

  @override
  String get createBoardTooltip => 'Create board';

  @override
  String get noBoardsYet => 'No boards yet.\nTap + to create one.';

  @override
  String failedToLoadBoards(String error) {
    return 'Failed to load boards: $error';
  }

  @override
  String boardTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
    );
    return '$_temp0';
  }

  @override
  String get newBoardTitle => 'New board';

  @override
  String get renameBoardTitle => 'Rename board';

  @override
  String get createAction => 'Create';

  @override
  String get saveAction => 'Save';

  @override
  String get deleteAction => 'Delete';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get pinAction => 'Pin';

  @override
  String get unpinAction => 'Unpin';

  @override
  String get renameAction => 'Rename';

  @override
  String get nameLabel => 'Name';

  @override
  String deleteBoardQuestion(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get deleteBoardWarning =>
      'The board and all its tasks will be removed.';

  @override
  String get selectBoardHint => 'Select a board or create a new one';

  @override
  String get archiveTooltip => 'Archive (coming soon)';

  @override
  String get searchTasksHint => 'Search tasks';

  @override
  String get noTasksFound => 'No tasks found';

  @override
  String failedToLoadColumns(String error) {
    return 'Failed to load columns: $error';
  }

  @override
  String get addColumnAction => 'Add column';

  @override
  String get newColumnTitle => 'New column';

  @override
  String get renameColumnTitle => 'Rename column';

  @override
  String deleteColumnQuestion(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String columnContainsTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'The column contains $count tasks.',
      one: 'The column contains 1 task.',
    );
    return '$_temp0';
  }

  @override
  String get moveTasksAction => 'Move tasks';

  @override
  String get deleteWithTasksAction => 'Delete with tasks';

  @override
  String get moveTasksToTitle => 'Move tasks to';

  @override
  String get addTaskAction => 'Add task';

  @override
  String get newTaskTitle => 'New task';

  @override
  String get titleLabel => 'Title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get deadlineLabel => 'Deadline';

  @override
  String get columnLabel => 'Column';

  @override
  String get taskScreenTitle => 'Task';

  @override
  String get deleteTaskTooltip => 'Delete task';

  @override
  String failedToLoadTask(String error) {
    return 'Failed to load task: $error';
  }

  @override
  String get taskNotFound => 'Task not found';

  @override
  String get setDeadlineAction => 'Set deadline';

  @override
  String get clearDeadlineTooltip => 'Clear deadline';

  @override
  String get moveToBoard => 'Move to board…';
}
