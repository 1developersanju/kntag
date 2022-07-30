import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeMap, initial: true),
    // MaterialRoute(page: SelectionPanelMainView),
    // MaterialRoute(page: VerifyPhoneView),
    // MaterialRoute(page: VerifyOtpView),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    Singleton(classType: BottomSheetService),
    Singleton(classType: DialogService),
    Singleton(classType: SnackbarService),
    // Singleton(classType: ImagePickerService),
    // LazySingleton(classType: AuthenticationAPI),
    // LazySingleton(classType: ChatAPI),
    // Singleton(classType: AuthenticationService),
    // Singleton(classType: SocketService),
    // Singleton(classType: BottomNavBarService),
    // LazySingleton(classType: GroupChatService),
    // LazySingleton(classType: VouchersAPI),
    // Singleton(classType: UrlLauncherService),
    // LazySingleton(classType: MediaUploadAPI),
    // Presolve(
    //     classType: LocalStorageService,
    //     presolveUsing: LocalStorageService.getInstance)
  ],
  logger: StackedLogger(),
)
class App {}
