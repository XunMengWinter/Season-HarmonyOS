import common from '@ohos.app.ability.common';
import { Want } from '@kit.AbilityKit';
import { BusinessError } from '@ohos.base';

class BrowserUtil {
  static startBrowsableAbility(context: common.UIAbilityContext, myurl: string): void {
    let want: Want = {
      action: 'ohos.want.action.viewData',
      entities: ['entity.system.browsable'],
      uri: myurl
    };
    context.startAbility(want).then(() => {
      console.log('success')
    }).catch((err: BusinessError) => {
      console.error(`Failed to startAbility. Code: ${err.code}, message: ${err.message}`);
    });
  }
}

export default BrowserUtil;