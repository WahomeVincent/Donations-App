# User
user1 = User.create(
  name: 'John Doe',
  email: 'john@example.com',
  password: 'as64cbv' # Replace 'password' with the actual password you want to set
)

user2 = User.create(
  name: 'Jane Smith',
  email: 'jane@example.com',
  password: '5rgftr' # Replace 'password' with the actual password you want to set
)

user3 = User.create(
  name: 'Michael Johnson',
  email: 'michael@example.com',
  password: '678gvbhj' # Replace 'password' with the actual password you want to set
)

# Role
role1 = Role.create(
  role_type: 'Admin',
  user_id: user1.id
)

role2 = Role.create(
  role_type: 'Donor',
  user_id: user2.id
)

role3 = Role.create(
  role_type: 'Charity',
  user_id: user3.id
)

# Donor
donor1 = Donor.create(
  name: 'John Donor',
  email: 'johndonor@example.com',
  mobile: '123-456-7890'
)

donor2 = Donor.create(
  name: 'Jane Donor',
  email: 'janedonor@example.com',
  mobile: '987-654-3210'
)

donor3 = Donor.create(
  name: 'Michael Donor',
  email: 'michaeldonor@example.com',
  mobile: '987-654-3210'
)

# Administrator
administrator1 = Administrator.create(
  name: 'Adam',
  mobile: '123-456-7890',
  email: 'adam1@gmail.com'
)

administrator2 = Administrator.create(
  name: 'Nancy',
  mobile: '987-654-3210',
  email: 'nancy@gmail.com'
)

# Charity
charity1 = Charity.create(
  name: 'Charity for Children',
  image: 'charity1.jpg', # Replace 'charity1.jpg' with the image file name or URL
  description: 'Helping children with education and healthcare',
  email: 'childrencharity@example.com',
  approved: true,
  phonenumber: '123-456-7890',
  administrator_id: administrator1.id
)

charity2 = Charity.create(
  name: 'Clean Water Charity',
  image: 'charity2.jpg', # Replace 'charity2.jpg' with the image file name or URL
  description: 'Providing clean water and sanitation facilities',
  email: 'cleanwater@example.com',
  approved: false,
  phonenumber: '987-654-3210',
  administrator_id: administrator1.id
)

charity3 = Charity.create(
  name: 'Environmental Charity',
  image: 'charity3.jpg', # Replace 'charity3.jpg' with the image file name or URL
  description: 'Promoting environmental conservation',
  email: 'environment@example.com',
  approved: true,
  phonenumber: '987-654-3210',
  administrator_id: administrator2.id
)

# Beneficiary
beneficiary1 = Beneficiary.create(
  name: 'Charity for Children',
  image: 'beneficiary1.jpg',
  description: 'Supporting girls education in underprivileged communities',
  email: 'girlseducation@example.com',
  phonenumber: '123-456-7890',
  charity_id: charity1.id
)

beneficiary2 = Beneficiary.create(
  name: 'Clean Water Initiative',
  image: 'beneficiary2.jpg',
  description: 'Providing clean water access to rural areas',
  email: 'waterinitiative@example.com',
  phonenumber: '987-654-3210',
  charity_id: charity2.id
)

# Account
account1 = Account.create(
  name: 'John Doe Account',
  image: 'account1.jpg', # Replace 'account1.jpg' with the image file name or URL
  mobile: '123-456-7890',
  email: 'foundation@example.com',
  account_number: 'ACCT123',
  user_id: user1.id,
  donor_id: donor1.id,
  charity_id: charity1.id
)

account2 = Account.create(
  name: 'Jane Smith Account',
  image: 'account2.jpg', # Replace 'account2.jpg' with the image file name or URL
  mobile: '987-654-3210',
  email: 'trust@example.com',
  account_number: 'ACCT456',
  user_id: user2.id,
  donor_id: donor2.id,
  charity_id: charity2.id
)

account3 = Account.create(
  name: 'Michael Johnson Account',
  image: 'account3.jpg', # Replace 'account3.jpg' with the image file name or URL
  mobile: '987-654-3210',
  email: 'michael@example.com',
  account_number: 'ACCT789',
  user_id: user3.id,
  donor_id: donor3.id,
  charity_id: charity3.id
)

# Donation
donation1 = Donation.create(
  amount: 100.00,
  donor_id: donor1.id,
  charity_id: charity1.id,
  repeat_donation: false,
  anonymous: true
)

donation2 = Donation.create(
  amount: 50.00,
  donor_id: donor2.id,
  charity_id: charity2.id,
  repeat_donation: true,
  anonymous: false
)

puts 'All seeds created successfully.'
