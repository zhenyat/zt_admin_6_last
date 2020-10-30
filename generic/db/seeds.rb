begin
  if (User.present? and not User.exists?)
    User.create first_name: 'Bob', last_name: 'Dummy', role: 2, email: 'dummy@mail.ru',  password: '123123123', password_confirmation: '123123123'
    puts "===== Done: 'User' record(s)"
  end
rescue
  puts "===== Achtung! 'User' entity does not exist"
end

begin
  if (Product.present? and not Product.exists?)
    Product.create([
      { name:   'hemp_paste', 
        title:  'Паста конопляная Классическая 200 г',
        sku:    'kpl-hmp-chc-02-1',
        price:  '288.00',
        description: 'Страна производитель:Россия. \nОтличная возможность украсить свой день уникальным видом пасты из очищенных семян конопли. Слегка кедровый вкус и ореховый аромат откроют вам новый вид лакомства в пастах. Наш конопляный продукт создаётся без процессов термообработки, что позволяет сохранить максимум полезных свойств. Продукт не содержит красители, консерванты и ароматизаторы.'
      },
      { name:   'hemp_mask_grey', 
        title:  'Серая конопляная маска 3-слойная',
        sku:    'acc-msk3-gr',
        price:  '198.00',
        description: 'Цвета: серый, бежевый. Состав: 55% конопля; 45% хлопок.'
      }
    ])
    puts "===== Done: 'Product' record(s)"
  end
rescue
  puts "===== Achtung! 'Product' entity does not exist"
end
