import 'package:sentry/sentry.dart';

import 'mock_span.dart';

class MockHub implements Hub {
  final breadcrumbs = <Breadcrumb>[];
  final transactions = <MockSpan>[];

  @override
  void addBreadcrumb(Breadcrumb crumb, {Object? hint}) {
    breadcrumbs.add(crumb);
  }

  @override
  void bindClient(SentryClient client) {}

  @override
  Future<SentryId> captureEvent(
    SentryEvent event, {
    Object? stackTrace,
    Object? hint,
    ScopeCallback? withScope,
  }) async =>
      const SentryId.empty();

  @override
  Future<SentryId> captureException(
    Object? throwable, {
    Object? stackTrace,
    Object? hint,
    ScopeCallback? withScope,
  }) async =>
      const SentryId.empty();

  @override
  Future<SentryId> captureMessage(
    String? message, {
    SentryLevel? level,
    String? template,
    List? params,
    Object? hint,
    ScopeCallback? withScope,
  }) async =>
      const SentryId.empty();

  @override
  Future<SentryId> captureTransaction(SentryTransaction transaction) async =>
      const SentryId.empty();

  @override
  Future<void> captureUserFeedback(SentryUserFeedback userFeedback) async {}

  @override
  Hub clone() => this;

  @override
  Future<void> close() async {}

  @override
  void configureScope(ScopeCallback callback) {}

  @override
  ISentrySpan? getSpan() => null;

  @override
  bool get isEnabled => throw UnimplementedError();

  @override
  SentryId get lastEventId => throw UnimplementedError();

  @override
  void setSpanContext(
    Object? throwable,
    ISentrySpan span,
    String transaction,
  ) {}

  @override
  ISentrySpan startTransaction(
    String name,
    String operation, {
    String? description,
    bool? bindToScope,
    Map<String, dynamic>? customSamplingContext,
  }) =>
      startTransactionWithContext(
        SentryTransactionContext(
          name,
          operation,
          description: description,
        ),
        customSamplingContext: customSamplingContext,
        bindToScope: bindToScope,
      );

  @override
  ISentrySpan startTransactionWithContext(
    SentryTransactionContext transactionContext, {
    Map<String, dynamic>? customSamplingContext,
    bool? bindToScope,
  }) {
    final span = MockSpan(
      transactionContext.operation,
      description: transactionContext.description,
      transactionParentSpanId: transactionContext.parentSpanId,
    );
    transactions.add(span);
    return span;
  }
}