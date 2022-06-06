import 'package:mozaik_common/api-common/app_config_info.dart';
import 'package:mozaik_common/api-common/environment.dart';

late AppConfigInfo appConfigInfoInstance;
AppConfigUtil appConfigUtil = AppConfigUtil();

class AppConfigUtil {
  void initialzeAppConfigInfo({Environment env = Environment.Uat}) {
    switch (env) {
      case Environment.Uat:
        appConfigInfoInstance = AppConfigInfo(
            environment: Environment.Uat,
            apiBaseUrl: 'https://apitest.ziraatbank.com.tr/inbound/mobile-approval-api-v2/uat',
            apiBaseOfflineTokenUrl: 'https://apitest.ziraatbank.com.tr/inbound/mobile-approval-api-v2',
            pushApplicationName: 'ZTMobilOnayUat',
            pushApplicationId: 'ea007ddb-af66-48b6-aa86-9d7f0aa640d3',
            apigatewayOnlineClientId: '98d112e1-fb4a-4136-aee3-d68f41848d9c',
            apigatewayOnlineClientSecret: '7713fa1f-7964-4989-8b8f-8fbd08ee3fe9',
            apigatewayOnlineScope: 'inbound-ua2-mobile-approval-v2-scope',
            apigatewayOnlineUsername: 'inbound-ua2-mobile-approval-api-v2-user',
            apigatewayOnlinePassword: '|Jd0gQElum',
            apigatewayOfflineClientId: '713c408c-4c20-4043-9891-26a86aa0494e',
            apigatewayOfflineClientSecret: 'b76b1f14-067b-4621-b9d1-7f15354b3df1',
            apigatewayOfflineUsername: 'mobile-approval-v2-user',
            apigatewayOfflineScope: 'inbound-ua2-mobile-approval-api-v2-offline-scope',
            apigatewayOfflinePassword: 'iXw@gAh#9v');
        break;
      default:
        appConfigInfoInstance = AppConfigInfo(
            environment: Environment.Uat,
            apiBaseUrl: 'https://apitest.ziraatbank.com.tr/inbound/mobile-approval-api-v2/uat',
            apiBaseOfflineTokenUrl: 'https://apitest.ziraatbank.com.tr/inbound/mobile-approval-api-v2',
            pushApplicationName: 'ZTMobilOnayUat',
            pushApplicationId: 'ea007ddb-af66-48b6-aa86-9d7f0aa640d3',
            apigatewayOnlineClientId: '98d112e1-fb4a-4136-aee3-d68f41848d9c',
            apigatewayOnlineClientSecret: '7713fa1f-7964-4989-8b8f-8fbd08ee3fe9',
            apigatewayOnlineScope: 'inbound-ua2-mobile-approval-v2-scope',
            apigatewayOnlineUsername: 'inbound-ua2-mobile-approval-api-v2-user',
            apigatewayOnlinePassword: '|Jd0gQElum',
            apigatewayOfflineClientId: '713c408c-4c20-4043-9891-26a86aa0494e',
            apigatewayOfflineClientSecret: 'b76b1f14-067b-4621-b9d1-7f15354b3df1',
            apigatewayOfflineUsername: 'mobile-approval-v2-user',
            apigatewayOfflineScope: 'inbound-ua2-mobile-approval-api-v2-offline-scope',
            apigatewayOfflinePassword: 'iXw@gAh#9v');
        break;
    }
  }
}
