<?php

/**
 * @file
 * Administration form for the Raven authentication module.
 */

/**
 * Implements hook_form().
 */
function raven_settings_form($form, &$form_state) {
  global $base_url;

  $user1 = user_load(1);

  // Let the user override the standard login pages (user, user/login, ?q=user, ?q=user/login)
  $form['raven_login_override'] = array(
    '#type' => 'checkbox',
    '#title' => t('Enable Raven login override'),
    '#default_value' => variable_get('raven_login_override'),
    '#description' => t('Override the normal login paths so that users can only log in using Raven.'),
  );

  $form['raven_backdoor_login'] = array(
    '#type' => 'checkbox',
    '#title' => t('Enable non-Raven backdoor login'),
    '#default_value' => variable_get('raven_backdoor_login'),
    '#states' => array(
      // Hide the settings when the cancel notify checkbox is disabled.
      'invisible' => array(
        ':input[name="raven_login_override"]' => array('checked' => FALSE),
      ),
    ),
    '#description' => t('Open a hidden path (\'@raven_backdoor_login_path\') to still allow normal Drupal logins. This mean that site-created users such as \'@user1\' will still be able to log in.<br /><i>Warning: Disabling this without having an administrator able to log in with Raven will lock you out of your site.</i>', array(
      '@raven_backdoor_login_path' => RAVEN_BACKDOOR_LOGIN_PATH,
      // user 1 should always exist, but just in case
      '@user1' => $user1 ? $user1->name : 'admin',
    )),
  );

  // Log users out when closing the browser?
  $form['raven_logout_on_browser_close'] = array(
    '#type' => 'checkbox',
    '#title' => t('Log out Raven users when closing the browser'),
    '#default_value' => variable_get('raven_logout_on_browser_close'),
    '#description' => t('Drupal, by default, does not log the user out when closing the browser (the session is kept active for over 23 days). Raven applications, however, are usually expected to do so. This option logs out users who have logged in through Raven when the browser is closed.<br /><i>Note: Enabling this will not affect existing sessions, users will need to log out manually first.</i>'),
  );

  // Site description for Raven Login page
  $form['raven_website_description'] = array(
    '#type' => 'textfield',
    '#title' => t('Your website description'),
    '#default_value' => variable_get('raven_website_description'),
    // Get custom description, otherwise the site name, otherwise the site url
    '#description' => t('When Raven prompts the user to log in it will display a message with the text <i>\'[...] This resource calls itself \'SITE DESCRIPTION\' and [...]</i>, where SITE DESCRIPTION is specified here. If left blank, the site name will be used (currently \'@sitename\').', array('@sitename' => variable_get('site_name', $base_url))),
  );

  // Site redirect if a login fails
  $form['raven_login_fail_redirect'] = array(
    '#type' => 'textfield',
    '#title' => t('Login failure redirect'),
    '#field_prefix' => $base_url . '/',
    '#default_value' => variable_get('raven_login_fail_redirect'),
    '#description' => t('If a login fails, they will be redirected to this page.'),
    '#required' => FALSE,
  );

  return system_settings_form($form);
}
