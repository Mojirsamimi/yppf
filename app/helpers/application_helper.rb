module ApplicationHelper

  def header(text)
    content_for(:header) { text.to_s }
  end
  def lov(domain)
    Listofvalue.where(lov_domain: domain).pluck(:lov_value, :lov_key)
  end
  def value_for_key(domain,key)
    Listofvalue.where(lov_domain: domain,lov_key: key).pluck(:lov_value).first
  end
  def currentYear
    Date.today.year
  end
  def currentMonth
    Date.today.month
  end
end
