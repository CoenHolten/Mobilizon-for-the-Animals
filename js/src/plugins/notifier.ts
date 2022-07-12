import { App } from "vue";

export class Notifier {
  private app: App;

  constructor(app: App) {
    this.app = app;
  }

  success(message: string): void {
    this.notification(message, "is-success");
  }

  error(message: string): void {
    this.notification(message, "is-danger");
  }

  info(message: string): void {
    this.notification(message, "is-info");
  }

  private notification(message: string, type: string) {
    this.app.config.globalProperties.$oruga.notification.open({
      message,
      duration: 5000,
      position: "is-bottom-right",
      type,
      hasIcon: true,
    });
  }
}

export const notifierPlugin = {
  install(app: App) {
    const notifier = new Notifier(app);
    app.config.globalProperties.$notifier = notifier;
    app.provide("notifier", notifier);
  },
};
