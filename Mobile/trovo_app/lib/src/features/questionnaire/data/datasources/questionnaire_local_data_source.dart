import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/questionnaire_response.dart';

class QuestionnaireDraft {
  const QuestionnaireDraft({required this.response, required this.step});

  final QuestionnaireResponse response;
  final int step;
}

abstract class QuestionnaireLocalDataSource {
  Future<void> saveDraft({
    required QuestionnaireResponse response,
    required int step,
  });

  Future<QuestionnaireDraft?> loadDraft();
  Future<void> clearDraft();

  Future<void> saveSubmittedAnswers(QuestionnaireResponse response);
  Future<QuestionnaireResponse?> loadSubmittedAnswers();
  Future<void> clearSubmittedAnswers();
}

class QuestionnaireLocalDataSourceImpl
    implements QuestionnaireLocalDataSource {
  static const String _draftKey = 'questionnaire_draft_v1';
  static const String _stepKey = 'questionnaire_step_v1';
  static const String _submittedKey = 'questionnaire_submitted_v1';

  @override
  Future<void> saveDraft({
    required QuestionnaireResponse response,
    required int step,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_draftKey, jsonEncode(response.toJson()));
    await prefs.setInt(_stepKey, step);
  }

  @override
  Future<QuestionnaireDraft?> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final draft = prefs.getString(_draftKey);
    if (draft == null || draft.isEmpty) return null;
    try {
      final map = jsonDecode(draft) as Map<String, dynamic>;
      final response = QuestionnaireResponse.fromJson(map);
      final step = prefs.getInt(_stepKey) ?? 0;
      return QuestionnaireDraft(response: response, step: step.clamp(0, 5));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftKey);
    await prefs.remove(_stepKey);
  }

  @override
  Future<void> saveSubmittedAnswers(QuestionnaireResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_submittedKey, jsonEncode(response.toJson()));
  }

  @override
  Future<QuestionnaireResponse?> loadSubmittedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_submittedKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return QuestionnaireResponse.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearSubmittedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_submittedKey);
  }
}
