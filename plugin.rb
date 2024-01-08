# frozen_string_literal: true

# name: discourse-copy-email-to-custom-field
# about: Sync email address to user custom field of same name
# meta_topic_id: TODO
# version: 0.0.1
# authors: pfaffman
# url: https://github.com/pfaffman/discourse-copy-email-to-custom-field
# required_version: 2.7.0

enabled_site_setting :copy_email_to_custom_field_enabled

module ::SyncUserEmailModule
  PLUGIN_NAME = "discourse-copy-email-to-custom-field"
end

require_relative "lib/copy_email_to_custom_field_module/engine"

after_initialize do
  EMAIL_CUSTOM_FIELD_RECORD ||= UserField.find_by(name: "Email")
  EMAIL_CUSTOM_FIELD ||= EMAIL_CUSTOM_FIELD_RECORD ? "user_field_#{EMAIL_CUSTOM_FIELD_RECORD.id}" : nil
  # Code which should run after Rails has finished booting
  add_model_callback(User, :before_save) do
    user=self
    next if user.email==user.custom_fields[EMAIL_CUSTOM_FIELD]
    user.custom_fields[EMAIL_CUSTOM_FIELD]=user.email
  end
end
