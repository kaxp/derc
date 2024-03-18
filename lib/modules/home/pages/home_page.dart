import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kapil_sahu_cred/components/atoms/buttons/default_elevated_button.dart';
import 'package:kapil_sahu_cred/components/molecules/app_bar/custom_appbar.dart';
import 'package:kapil_sahu_cred/components/molecules/loading_overlay/loading_overlay.dart';
import 'package:kapil_sahu_cred/components/molecules/snackbar/custom_snackbar.dart';
import 'package:kapil_sahu_cred/components/organisms/list_views/search_result_list_view.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_colors.dart';
import 'package:kapil_sahu_cred/config/themes/assets/app_images.dart';
import 'package:kapil_sahu_cred/constants/spacing_constants.dart';
import 'package:kapil_sahu_cred/modules/home/bloc/home_bloc.dart';
import 'package:kapil_sahu_cred/modules/home/widgets/home_empty_view.dart';
import 'package:kapil_sahu_cred/modules/home/widgets/home_initial_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kapil_sahu_cred/modules/home/widgets/home_paging_loading_view.dart';
import 'package:kapil_sahu_cred/modules/home/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = Modular.get<HomeBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeBloc.fetchEvents('');
    _scrollController.addListener(_onEventListScrolledListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: Center(
          child: AppImages.icAppLogo(
            height: kSpacingXLarge,
            widget: kSpacingXLarge,
          ),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar(
                message: state.errorMessage,
                duration: const Duration(seconds: 5),
              ),
            );
          } else if (state is HomeSearchEnabled) {
            SearchPage().showSearchView(
              context: context,
              onStackDismissed: _homeBloc.onStackDismissed,
              totalStackCount: 4,
            );
          }
        },
        builder: (context, state) {
          if (state is HomeInitial) {
            return const HomeInitialView();
          } else if (state is HomeEmpty) {
            return const HomeEmptyView();
          }

          return LoadingOverlay(
            isLoading: state is HomeLoading,
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                state.events.isNotEmpty
                    ? SearchResultListView(
                        events: state.events,
                        onTap: (event) {
                          SearchPage().showSearchView(
                            context: context,
                            onStackDismissed: _homeBloc.onStackDismissed,
                            totalStackCount: 2,
                            selectedEvent: event,
                          );
                        },
                      )
                    : const HomeInitialView(),

                // Pagination loader
                if (state is HomeLoadingMore) const HomePagingLoadingView(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryColor,
              blurRadius: 10,
              offset: Offset(0.0, 10.0),
            )
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: DefaultElevatedButton(
          title: 'Search the best events around you',
          onPressed: () {
            _homeBloc.onSeachTap();
          },
        ),
      ),
    );
  }

  void _onEventListScrolledListener() {
    if (_scrollController.position.pixels <=
        _scrollController.position.maxScrollExtent * 0.8) {
      _homeBloc.loadNextPage(_homeBloc.searchQuery ?? '');

      // // When textinput is empty we don't want to call paging API
      // if (_searchInputController.text.length > 0) {
      //   _homeBloc.loadNextPage(_homeBloc.searchQuery);
      // }
    }
  }
}
