import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'LozaLife'**
  String get appTitle;

  /// No description provided for @boardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Boards'**
  String get boardsTitle;

  /// No description provided for @createBoardTooltip.
  ///
  /// In en, this message translates to:
  /// **'Create board'**
  String get createBoardTooltip;

  /// No description provided for @noBoardsYet.
  ///
  /// In en, this message translates to:
  /// **'No boards yet.\nTap + to create one.'**
  String get noBoardsYet;

  /// No description provided for @failedToLoadBoards.
  ///
  /// In en, this message translates to:
  /// **'Failed to load boards: {error}'**
  String failedToLoadBoards(String error);

  /// No description provided for @boardTaskCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 task} other{{count} tasks}}'**
  String boardTaskCount(int count);

  /// No description provided for @newBoardTitle.
  ///
  /// In en, this message translates to:
  /// **'New board'**
  String get newBoardTitle;

  /// No description provided for @renameBoardTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename board'**
  String get renameBoardTitle;

  /// No description provided for @createAction.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createAction;

  /// No description provided for @saveAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @pinAction.
  ///
  /// In en, this message translates to:
  /// **'Pin'**
  String get pinAction;

  /// No description provided for @unpinAction.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get unpinAction;

  /// No description provided for @renameAction.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get renameAction;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @deleteBoardQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String deleteBoardQuestion(String name);

  /// No description provided for @deleteBoardWarning.
  ///
  /// In en, this message translates to:
  /// **'The board and all its tasks will be removed.'**
  String get deleteBoardWarning;

  /// No description provided for @selectBoardHint.
  ///
  /// In en, this message translates to:
  /// **'Select a board or create a new one'**
  String get selectBoardHint;

  /// No description provided for @archiveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Archive (coming soon)'**
  String get archiveTooltip;

  /// No description provided for @searchTasksHint.
  ///
  /// In en, this message translates to:
  /// **'Search tasks'**
  String get searchTasksHint;

  /// No description provided for @noTasksFound.
  ///
  /// In en, this message translates to:
  /// **'No tasks found'**
  String get noTasksFound;

  /// No description provided for @failedToLoadColumns.
  ///
  /// In en, this message translates to:
  /// **'Failed to load columns: {error}'**
  String failedToLoadColumns(String error);

  /// No description provided for @addColumnAction.
  ///
  /// In en, this message translates to:
  /// **'Add column'**
  String get addColumnAction;

  /// No description provided for @newColumnTitle.
  ///
  /// In en, this message translates to:
  /// **'New column'**
  String get newColumnTitle;

  /// No description provided for @renameColumnTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename column'**
  String get renameColumnTitle;

  /// No description provided for @deleteColumnQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String deleteColumnQuestion(String name);

  /// No description provided for @columnContainsTasks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{The column contains 1 task.} other{The column contains {count} tasks.}}'**
  String columnContainsTasks(int count);

  /// No description provided for @moveTasksAction.
  ///
  /// In en, this message translates to:
  /// **'Move tasks'**
  String get moveTasksAction;

  /// No description provided for @deleteWithTasksAction.
  ///
  /// In en, this message translates to:
  /// **'Delete with tasks'**
  String get deleteWithTasksAction;

  /// No description provided for @moveTasksToTitle.
  ///
  /// In en, this message translates to:
  /// **'Move tasks to'**
  String get moveTasksToTitle;

  /// No description provided for @addTaskAction.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addTaskAction;

  /// No description provided for @newTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'New task'**
  String get newTaskTitle;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @deadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadlineLabel;

  /// No description provided for @columnLabel.
  ///
  /// In en, this message translates to:
  /// **'Column'**
  String get columnLabel;

  /// No description provided for @taskScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get taskScreenTitle;

  /// No description provided for @deleteTaskTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get deleteTaskTooltip;

  /// No description provided for @failedToLoadTask.
  ///
  /// In en, this message translates to:
  /// **'Failed to load task: {error}'**
  String failedToLoadTask(String error);

  /// No description provided for @taskNotFound.
  ///
  /// In en, this message translates to:
  /// **'Task not found'**
  String get taskNotFound;

  /// No description provided for @setDeadlineAction.
  ///
  /// In en, this message translates to:
  /// **'Set deadline'**
  String get setDeadlineAction;

  /// No description provided for @clearDeadlineTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear deadline'**
  String get clearDeadlineTooltip;

  /// No description provided for @moveToBoard.
  ///
  /// In en, this message translates to:
  /// **'Move to board…'**
  String get moveToBoard;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
