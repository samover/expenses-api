u1 = User.create(email: 'user@example.com', password: 'password')
u2 = User.create(email: 'user2@example.com', password: 'password')
 
c1 = Category.create(name: 'Food')
c2 = Category.create(name: 'Drinks')
c3 = Category.create(name: 'Transport')

e1 = u1.expenses.create(title: 'Shopping at Lidl', date: Date.parse('3rd of February'), amount: 57.50, category: c1)
e2 = u1.expenses.create(title: 'Coffee with friends', date: Date.parse('10/02/2016'), amount: 3.99, category: c2)
e3 = u2.expenses.create(title: 'Shopping at Colruyt', date: Date.parse('01/01/2016'), amount: 19.25, category: c2)
e4 = u1.expenses.create(title: 'Diesel', date: Date.parse('15/02/2016'), amount: 35.89, category: c3)
