package model;

import io.micronaut.core.annotation.Introspected;

@Introspected
public class SlackWebhookBody {

  private final String text;

  public SlackWebhookBody(String text) {
    this.text = text;
  }

  public String getText() {
    return text;
  }
}
