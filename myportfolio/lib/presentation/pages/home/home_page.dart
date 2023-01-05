import '/core/layout/adaptive.dart';
import '/core/utils/functions.dart';
import '/presentation/pages/home/widgets/home_page_header.dart';
import '/presentation/pages/home/widgets/loading_page.dart';
import '/presentation/pages/widgets/animated_footer.dart';
import '/presentation/pages/works/works_page.dart';
import '/presentation/widgets/animated_positioned_text.dart';
import '/presentation/widgets/animated_slide_transtion.dart';
import '/presentation/widgets/animated_text_slide_box_transition.dart';
import '/presentation/widgets/custom_spacer.dart';
import '/presentation/widgets/page_wrapper.dart';
import '/presentation/widgets/project_item.dart';
import '/presentation/widgets/spaces.dart';
import 'package:flutter/material.dart';
import '/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  static const String homePageRoute = StringConst.HOME_PAGE;

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  ScrollController _scrollController = ScrollController();
  late AnimationController _viewProjectsController;
  late AnimationController _recentWorksController;
  late AnimationController _slideTextController;
  late NavigationArguments _arguments;

  @override
  void initState() {
    _arguments = NavigationArguments();
    _viewProjectsController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideTextController = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationLong,
    );
    _recentWorksController = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationLong,
    );
   
    super.initState();
  }

  void getArguments() {
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    // if page is being loaded for the first time, args will be null.
    // if args is null, I set boolean values to run the appropriate animation
    // In this case, if null run loading animation, if not null run the unveil animation
    if (args == null) {
      _arguments.showUnVeilPageAnimation = false;
    } else {
      _arguments = args as NavigationArguments;
    }
  }

  @override
  void dispose() {
    _viewProjectsController.dispose();
    _slideTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getArguments();
    double projectItemHeight = assignHeight(context, 0.4);
    double subHeight = (3 / 4) * projectItemHeight;
    double extra = projectItemHeight - subHeight;
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? textButtonStyle = textTheme.headline4?.copyWith(
      color: AppColors.black,
      fontSize: responsiveSize(context, 30, 40, md: 36, sm: 32),
      height: 2.0,
    );
    EdgeInsets margin = EdgeInsets.only(
      left: responsiveSize(
        context,
        assignWidth(context, 0.10),
        assignWidth(context, 0.15),
        sm: assignWidth(context, 0.15),
      ),
    );
    return PageWrapper(
      selectedRoute: HomePage.homePageRoute,
      selectedPageName: StringConst.HOME,
      navBarAnimationController: _slideTextController,
      hasSideTitle: false,
      hasUnveilPageAnimation: _arguments.showUnVeilPageAnimation,
      onLoadingAnimationDone: () {
        _slideTextController.forward();
      },
      customLoadingAnimation: LoadingHomePageAnimation(
        text: StringConst.DEV_NAME,
        style: textTheme.headline4!.copyWith(color: AppColors.white),
        onLoadingDone: () {
          _slideTextController.forward();
        },
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          
          HomePageHeader(
            controller: _slideTextController,
            scrollToWorksKey: key,
          ),
          CustomSpacer(heightFactor: 0.1),
          VisibilityDetector(
            key: Key('recent-projects'),
            onVisibilityChanged: (visibilityInfo) {
              double visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage > 45) {
                _recentWorksController.forward();
              }
            },
            child: Container(
              key: key,
              margin: margin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedTextSlideBoxTransition(
                    controller: _recentWorksController,
                    text: StringConst.CRAFTED_WITH_LOVE,
                    textStyle: textTheme.headline4?.copyWith(
                      color: AppColors.black,
                      fontSize: responsiveSize(context, 30, 48, md: 40, sm: 36),
                      height: 2.0,
                    ),
                  ),
                  // SpaceH16(),
                
                ],
              ),
            ),
          ),
          CustomSpacer(heightFactor: 0.1),
        ],
      ),
    );
  }
}
