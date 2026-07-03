import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lozalife/core/design_system/app_async_states.dart';
import 'package:lozalife/core/design_system/app_date_picker_button.dart';
import 'package:lozalife/core/design_system/app_dialogs.dart';
import 'package:lozalife/core/design_system/app_text_field.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/core/theme/app_durations.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/presentation/providers/board_providers.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/presentation/providers/task_providers.dart';

/// Task details screen. All edits are saved automatically: text fields are
/// debounced, the deadline is saved right after picking.
class TaskScreen extends ConsumerStatefulWidget {
  final String taskId;

  const TaskScreen({super.key, required this.taskId});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  static const int _descriptionFieldLines = 6;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Timer? _autosaveTimer;
  DateTime? _deadline;
  bool _initialized = false;

  @override
  void dispose() {
    _autosaveTimer?.cancel();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _populateOnce(TaskModel task) {
    if (_initialized) {
      return;
    }
    _initialized = true;
    _titleController.text = task.title;
    _descriptionController.text = task.description ?? '';
    _deadline = task.deadline;
  }

  void _scheduleAutosave() {
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(AppDurations.autosaveDebounce, _save);
  }

  Future<void> _save() async {
    final String title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    }
    final String description = _descriptionController.text.trim();
    await ref.read(taskRepositoryProvider).updateTask(
          taskId: widget.taskId,
          title: title,
          description: description.isEmpty ? null : description,
          deadline: _deadline,
        );
  }

  Future<void> _setDeadline(DateTime? deadline) async {
    setState(() => _deadline = deadline);
    await _save();
  }

  Future<void> _delete() async {
    await ref.read(taskRepositoryProvider).deleteTask(widget.taskId);
    if (mounted) {
      context.pop();
    }
  }

  /// Mobile-friendly alternative to dragging a card onto the boards panel:
  /// pick a target board from a dialog and move the task there.
  Future<void> _moveToBoard(TaskModel task) async {
    final List<BoardModel> boards =
        await ref.read(boardRepositoryProvider).watchBoardsStream().first;
    final List<BoardModel> otherBoards = boards
        .where((candidate) => candidate.id != task.boardId)
        .toList();
    if (otherBoards.isEmpty || !mounted) {
      return;
    }
    final String? targetBoardId = await showAppChoiceDialog<String>(
      context,
      title: context.l10n.moveToBoard,
      options: otherBoards
          .map(
            (candidate) => AppChoiceOption(
              value: candidate.id,
              label: candidate.name,
            ),
          )
          .toList(),
    );
    if (targetBoardId == null) {
      return;
    }
    await ref.read(taskRepositoryProvider).moveTaskToBoard(
          taskId: task.id,
          targetBoardId: targetBoardId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<TaskModel?> taskValue =
        ref.watch(taskStreamProvider(widget.taskId));

    final TaskModel? task = taskValue.value;
    final bool isTaskAlive = task != null && task.deletedAt == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.taskScreenTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.moveToBoard,
            icon: const Icon(Icons.drive_file_move_outlined),
            onPressed: isTaskAlive ? () => _moveToBoard(task) : null,
          ),
          IconButton(
            tooltip: context.l10n.deleteTaskTooltip,
            icon: const Icon(Icons.delete_outline),
            onPressed: isTaskAlive ? _delete : null,
          ),
        ],
      ),
      body: taskValue.when(
        loading: () => const AppLoadingState(),
        error: (error, stackTrace) => AppErrorState(
          message: context.l10n.failedToLoadTask('$error'),
        ),
        data: (loadedTask) {
          if (loadedTask == null || loadedTask.deletedAt != null) {
            return AppEmptyState(message: context.l10n.taskNotFound);
          }
          _populateOnce(loadedTask);
          return _buildForm(context);
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimens.size16),
      children: [
        AppTextField(
          controller: _titleController,
          label: context.l10n.titleLabel,
          onChanged: (value) => _scheduleAutosave(),
        ),
        const SizedBox(height: AppDimens.size16),
        AppTextField(
          controller: _descriptionController,
          label: context.l10n.descriptionLabel,
          maxLines: _descriptionFieldLines,
          onChanged: (value) => _scheduleAutosave(),
        ),
        const SizedBox(height: AppDimens.size16),
        Row(
          children: [
            Expanded(
              child: AppDatePickerButton(
                value: _deadline,
                placeholder: context.l10n.setDeadlineAction,
                onPicked: _setDeadline,
              ),
            ),
            if (_deadline != null)
              IconButton(
                tooltip: context.l10n.clearDeadlineTooltip,
                icon: const Icon(Icons.close),
                onPressed: () => _setDeadline(null),
              ),
          ],
        ),
      ],
    );
  }
}
