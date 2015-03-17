<?php

/**
 * @file
 * Hooks provided by the Raven authentication module.
 */

/**
 * @addtogroup hooks
 * @{
 */

/**
 * Alter the Raven user when registering.
 *
 * This is called when the user does not exist with Drupal but is logging in with Raven.
 *
 * @param array $edit
 *   Edits to be made.
 * @param StdClass $account
 *   User account. As this is a new user, this is almost empty.
 *
 * @see hook_raven_migrate_alter()
 * @see hook_raven_login_alter()
 */
function hook_raven_register_alter(&$edit, $account) {
  // Change the email address
  $edit['mail'] = 'example@example.com';
}

/**
 * Alter the Raven user when migrating.
 *
 * This is called when the user exists in Drupal and is logging in with Raven for the first time.
 *
 * @param array $edit
 *   Edits to be made.
 * @param StdClass $account
 *   User account.
 *
 * @see hook_raven_register_alter()
 * @see hook_raven_login_alter()
 */
function hook_raven_migrate_alter(&$edit, $account) {
  // Change the email address
  $edit['mail'] = 'example@example.com';
}

/**
 * Alter the Raven user when logging in.
 *
 * This is called when the user exists in Drupal and has logged in with Raven before.
 *
 * @param array $edit
 *   Edits to be made.
 * @param StdClass $account
 *   User account.
 *
 * @see hook_raven_register_alter()
 * @see hook_raven_migrate_alter()
 */
function hook_raven_login_alter(&$edit, $account) {
  // Change the email address
  $edit['mail'] = 'example@example.com';
}

/**
 * Allow modules to execute custom code after a user logs in with Raven.
 *
 * This is called after a user has logged in using Raven.
 *
 * @param StdClass $account
 *   User account.
 */
function hook_raven_post_login($account) {
  // Display a custom message
  drupal_set_message(t('Welcome to our website, @name', array('@name' => $account->name)));
}

/**
 * @} End of "addtogroup hooks".
 */
