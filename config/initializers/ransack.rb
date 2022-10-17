Ransack.configure do |c|
  # Change default search parameter key name.
  # Default key name is :q
#   c.search_key = :query
    c.custom_arrows = {
      up_arrow: '<i class="bi bi-arrow-up"></i>',
      down_arrow: '<i class="bi bi-arrow-down"></i>'
    }
end