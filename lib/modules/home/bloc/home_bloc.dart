import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kapil_sahu_cred/modules/home/models/events_response.dart';
import 'package:kapil_sahu_cred/modules/home/repositories/home_repo.dart';
import 'package:kapil_sahu_cred/utils/dio_error_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitial());
  final _homeRepo = Modular.get<HomeRepo>();
  String? searchQuery;

  // HomeState getters

  HomeState get _loadingMoreStateWithExistingAvailableData => HomeLoadingMore(
        events: state.events,
        searchQuery: state.searchQuery!,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalPage: state.totalPage,
      );

  void _emitErrorStateWithExistingAvailableData({
    required String errorMessage,
    required String? searchQuery,
  }) {
    emit(
      HomeError(
        errorMessage: errorMessage,
        events: state.events,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalPage: state.totalPage,
        searchQuery: searchQuery!,
      ),
    );
  }

  /// [fetchEvents] method is used for fetching the event data
  /// on user search.
  Future<void> fetchEvents(String? searchString) async {
    try {
      emit(HomeLoading());
      final response = await _homeRepo.fetchEventsData(
        searchString: searchString ?? '',
        page: state.page,
      );

      if (response.events.isNotEmpty) {
        emit(
          HomeLoaded(
            events: response.events,
            searchQuery: searchString ?? '',
            page: response.meta.page,
            hasReachedEnd: response.meta.total - 10 <=
                0, // when (total_result_count - 10 <= 0) == true, means we are at last page.
            totalPage: response.meta.total,
          ),
        );
      } else {
        emit(HomeEmpty());
      }
    } on DioException catch (error) {
      _emitErrorStateWithExistingAvailableData(
        errorMessage: error.errorMessage(),
        searchQuery: searchString,
      );
    }
  }

  /// [loadNextPage] method is used for fetching the next available
  /// pagination data when user scroll to the bottom of screen.
  Future<void> loadNextPage(String? searchString) async {
    if (state.hasReachedEnd ||
        state is! HomeLoaded ||
        state is HomeLoadingMore) {
      return;
    }

    try {
      emit(_loadingMoreStateWithExistingAvailableData);

      final response = await _homeRepo.fetchEventsData(
        searchString: searchString!,
        page: state.page + 1,
      );

      emit(
        HomeLoaded(
          events: state.events + response.events,
          searchQuery: searchString,
          page: response.meta.page,
          hasReachedEnd: response.meta.total - 10 <=
              0, // when (total_result - 10 <= 0) == true, means we are at last page.
          totalPage: state.totalPage -
              10, // Reduce the total result count by 10 with each pagination API call.
        ),
      );
    } on DioException catch (error) {
      _emitErrorStateWithExistingAvailableData(
        errorMessage: error.errorMessage(),
        searchQuery: searchString,
      );
    }
  }

  void onSeachTap() {
    emit(HomeSearchEnabled(
      events: state.events,
      searchQuery: state.searchQuery!,
      hasReachedEnd: state.hasReachedEnd,
      page: state.page,
      totalPage: state.totalPage,
    ));
  }

  void onStackDismissed() {
    emit(HomeLoaded(
      events: state.events,
      searchQuery: state.searchQuery!,
      page: state.page,
      hasReachedEnd: state.hasReachedEnd,
      totalPage: state.totalPage,
    ));
  }
}
