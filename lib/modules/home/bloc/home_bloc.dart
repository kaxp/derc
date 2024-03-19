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

  final HomeRepo _homeRepo = Modular.get<HomeRepo>();

  /// [fetchEvents] method is used for fetching the event data
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
      _handleError(error);
    }
  }

  /// [loadNextPage] method is used for fetching the next available
  /// pagination data when user scroll to the bottom of screen.
  Future<void> loadNextPage(String? searchString) async {
    if (state.hasReachedEnd || state is! HomeLoaded || state is HomeLoadMore) {
      return;
    }

    try {
      emit(
        HomeLoadMore(
          events: state.events,
          hasReachedEnd: state.hasReachedEnd,
          page: state.page,
          totalPage: state.totalPage,
        ),
      );

      final response = await _homeRepo.fetchEventsData(
        searchString: searchString!,
        page: state.page + 1,
      );

      emit(
        HomeLoaded(
          events: state.events + response.events,
          page: response.meta.page,
          hasReachedEnd: response.meta.total - 10 <=
              0, // when (total_result - 10 <= 0) == true, means we are at last page.
          totalPage: state.totalPage -
              10, // Reduce the total result count by 10 with each pagination API call.
        ),
      );
    } on DioException catch (error) {
      _handleError(error);
    }
  }

  void _handleError(DioException error) {
    emit(HomeError(
      errorMessage: error.errorMessage(),
      events: state.events,
      hasReachedEnd: state.hasReachedEnd,
      page: state.page,
      totalPage: state.totalPage,
    ));
  }

  /// Open the search stack view when state of the
  /// page is not [HomeError]
  void onSeachTap() {
    if (state is! HomeError) {
      emit(HomeSearchEnabled(
        events: state.events,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalPage: state.totalPage,
      ));
    }
  }

  /// Close the search stack view and land the user
  /// on home page.
  void onStackDismissed() => emit(HomeLoaded(
        events: state.events,
        page: state.page,
        hasReachedEnd: state.hasReachedEnd,
        totalPage: state.totalPage,
      ));
}
