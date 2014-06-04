define ->
  Settings =
    window: (global or this)
    redirectTo: (url)-> Settings.window.location.replace(url)
    get_param_name: 'analytics_session'
    cookies:
      first_party_enabled: true
      version: 1
      yogurt:
        name: 'yogurt_session'
      analytics:
        name: 'analytics_session'
        duration: 60 * 60 * 24 * 7 #In seconds: one week
    url:
      base: 'http://analytics.local:9000'
      analytics_session:
        create: (yogurt_session)->
          "#{Settings.url.base}/track/create?yogurt_session=#{yogurt_session}"
        connect: -> "#{Settings.url.base}/track/connect"
      beacon: (analytics_session)->
        "#{Settings.url.base}/track/actions/create?#{Settings.get_param_name}=#{analytics_session}"
      utils:
        third_party_step1: -> "#{Settings.url.base}/track/check/third_party/step_1.js"
        third_party_step2: -> "#{Settings.url.base}/track/check/third_party/step_2.js"
    api:
      settings:
        key: 'settings'
        set_account: 'setAccount'
        set_callback: 'setCallback'
        redirect_to: 'redirectTo'
      yogurt:
        key: 'yogurt'
        product_click: 'productClick'
      site:
        key: 'site'
        send_pageview: 'sendPageview'
      ecommerce:
        key: 'ecommerce'
        add_item: 'addItem'
        add_transaction: 'addTransaction'
      shop_code_key: '_setAccount'
      redirect_key: 'redirect'

  Settings.actions_queue = (Settings.window.sa?.q or [])
  Settings.url.current   = Settings.window.location.href

  return Settings
