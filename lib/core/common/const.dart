class GlobalValue {
  static bool showNoInternetDialog = false;
  static bool isDeviceConnected = false;
  static bool isAlertSet = false;
  static int maxFileSized = 15728640;
}

class CustomText {
  static String ok = "Ok";
  static String imgEndPoint =
      "http://dev.gokidu.com/api/v1/common/file/stream?key=";
}

class EventLogScreen {
  //RECIPIENT
  //--------home---------

  static String recipient_home = "recipient_home_tab";
  static String recipient_donor_preferences = "recipient_donor_preferences";

  // static String recipient_legal_guidance = "recipient_legal_guidance";
  // static String recipient_id_verification = "recipient_identity_verification";
  // static String recipient_rate_review = "recipient_rate_review";
  // static String recipient_notification = "recipient_notification";

  // //--------chat---------
  // static String recipient_chat = "recipient_chat_tab";
  // static String recipient_chat_new_request = "recipient_chat_new_request_tab";
  // static String recipient_donor_details = "recipient_donor_details";
  // static String recipient_chat_page = "recipient_chat_page";

  //--------explorer_donors---------
  static String recipient_donor = "recipient_donor_tab";
  static String recipient_donor_filter = "recipient_donor_preference_filter";

  //--------action---------
  // static String recipient_action_liked_me = "recipient_action_liked_me_tab";
  // static String recipient_action_i_liked = "recipient_action_i_liked_tab";
  // static String recipient_action_maybe = "recipient_action_maybe_tab";
  // static String recipient_action_dislike = "recipient_action_dislike_tab";

  //--------profile---------
  static String recipient_profile = "recipient_profile_tab";
  static String recipient_edit_profile = "recipient_edit_profile";

  //--------setting---------
  // static String recipient_setting = "recipient_setting_page";
  // static String recipient_change_password = "recipient_change_password";
  // static String recipient_forgot_password = "recipient_forgot_password";

  //COMMON

  static String legal_guidance = "legal_guidance";
  static String id_verification = "identity_verification";
  static String rate_review = "rate_review";
  static String notification = "notification";

  static String chat_tab = "chat_tab";
  static String chat_new_request = "chat_new_request_tab";
  static String recipient_donor_details = "recipient_donor_details";
  static String donor_recipient_details = "donor_recipient_details";
  static String chat_page = "chat_page";

  static String action_tab = "action_tab";
  // static String action_i_liked = "action_i_liked_tab";
  // static String action_maybe = "action_maybe_tab";
  // static String action_dislike = "action_dislike_tab";

  static String setting = "setting_page";
  static String change_password = "change_password";
  static String forgot_password = "forgot_password";

  //DONOR

  //--------home---------
  static String donor_home = "donor_home_tab";
  // static String donor_legal_guidance = "donor_legal_guidance";
  // static String donor_id_verification = "donor_identity_verification";
  // static String donor_rate_review = "donor_rate_review";
  // static String donor_notification = "donor_notification";

  //--------chat---------
  static String donor_chat = "donor_chat_tab";
  // static String donor_chat_new_request = "donor_chat_new_request_tab";
  // static String donor_recipient_details = "donor_recipient_details";
  // static String donor_chat_page = "donor_chat_page";

  //--------explorer_donors---------
  static String donor_donor = "donor_recipient_tab";
  // static String donor_donor_filter = "donor_Donor_preference_filter";

  //--------action---------
  // static String donor_action_liked_me = "donor_action_liked_me_tab";
  // static String donor_action_i_liked = "donor_action_i_liked_tab";
  // static String donor_action_maybe = "donor_action_maybe_tab";
  // static String donor_action_dislike = "donor_action_dislike_tab";

  //--------profile---------
  static String donor_profile = "donor_profile_tab";
  static String donor_edit_profile = "donor_edit_profile";
  static String donor_view_profile = "donor_view_profile";
  static String donor_add_bank_account = "donor_add_bank_account";

  //--------setting---------
  // static String donor_setting = "donor_setting_page";
  // static String donor_change_password = "donor_change_password";
  // static String donor_forgot_password = "donor_forgot_password";
  static String donor_view_bank_details = "donor_view_bank_details";
}
