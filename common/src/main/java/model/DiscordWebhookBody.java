package model;

import io.micronaut.core.annotation.Introspected;
import io.micronaut.core.annotation.NonNull;

@Introspected
public class DiscordWebhookBody {

  private final String username;

  @NonNull
  private final String content;

  private final String avatarUrl;

  public DiscordWebhookBody(String username, @NonNull String content, String avatarUrl) {
    this.username = username;
    this.content = content;
    this.avatarUrl = avatarUrl;
  }

  public String getUsername() {
    return username;
  }

  @NonNull
  public String getContent() {
    return content;
  }

  public String getAvatarUrl() {
    return avatarUrl;
  }
}
