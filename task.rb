item_list = {
  milk:   { unit_price: 3.97, sale_qty: 2, sale_price: 5.00 },
  bread:  { unit_price: 2.17, sale_qty: 3, sale_price: 6.00 },
  banana: { unit_price: 0.99 },
  apple:  { unit_price: 0.89 }
}
p "Please enter all the items purchased separated by a comma"

input = gets.chomp
items = input.split(",").map { |item| item.strip.downcase.to_sym }

cart = Hash.new(0)

items.each do |item|
  if item_list.key?(item)
    cart[item] += 1
  end
end

total_amount_with_discount = 0.0
total_amount_without_discount = 0.0

puts "\n"
printf "%-8s %-10s %-10s\n", "Item", "Quantity", "Price"
puts "--------------------------"

cart.each do |item, qty|
  details = item_list[item]

  if details[:sale_qty]
    sale_sets, remainder = qty.divmod(details[:sale_qty])

    discounted_amount = sale_sets * details[:sale_price]
    remain_amount = remainder * details[:unit_price]

    charged_amount = discounted_amount + remain_amount
    original_amount = qty * details[:unit_price]
  else
    charged_amount = qty * details[:unit_price]
    original_amount = charged_amount
  end

  total_amount_with_discount += charged_amount
  total_amount_without_discount += original_amount

  printf "%-10s %-8d $%-10.2f\n", item.capitalize, qty, charged_amount
end

puts "--------------------------"
puts "Total price : $#{total_amount_with_discount.round(2)}"
puts "You Saved $#{(total_amount_without_discount - total_amount_with_discount).round(2)} today."

