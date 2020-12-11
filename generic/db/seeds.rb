begin
  if (User.present? and not User.exists?)
    User.create first_name: 'Bob',  last_name: 'Dummy',  role: 2, email: 'dummy@mail.ru',  password: '123123123', password_confirmation: '123123123'
    User.create first_name: 'Alex', last_name: 'Petrov', role: 0, email: 'alex@gmail.com', password: '123123123', password_confirmation: '123123123'
    puts "===== Create 'User' record(s)"
  end
rescue
  puts "----- Achtung! Something went wrong ('User' entity does not exist?)"
end

begin
  if (Sample.present? and not Sample.exists?)
    Sample.create([
      { name:   'hemp_paste', 
        title:  'Паста конопляная Классическая 200 г',
        price:  288.00,
        quantity: 14
      },
      { name:   'hemp_mask_grey', 
        title:  'Серая конопляная маска 3-слойная',
        price:  198.00
      },
      { name:   'hemp_hat', 
        title:  'Шляпа оранжевая из конопли',
        price:  1088.00,
        quantity: 9
      },
      { name:   'hemp_bag', 
        title:  'Рюкзак из конопли Нарантан',
        price:  3188.00,
        quantity: 9
      }
    ])
    puts "===== Create 'Sample' record(s)"
  end
rescue
  puts "----- Achtung! Something went wrong ('Sample' entity does not exist?)"
end
