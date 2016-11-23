Ne.destroy_all
User.destroy_all
Branch.destroy_all

users = User.create! [
  { username: "artem", password: "qweQWE123!@#", state: "active", privilege: "admin" },
  { username: "userA", password: "qweQWE123!@#", state: "active", privilege: "user" }
]

User.first.nes.create! [
	{name: 'SAN-5', ip: '135.121.44.33', ectype: 'ARMADA', version:'17.14-20', system:'BACKBONE'},
	{name: 'SAN-6', ip: '135.121.44.34', ectype: 'ECX', version: '17.10-20', system:'BACKBONE'},
	{name: 'SAN-7', ip: '135.121.44.27', ectype: 'PSS4', version: '17.12-20', system:'SLIM'},
	{name: 'SAN-10',ip: '135.121.44.252', ectype: 'PSS4', version: '17.14-40', system:'SLIM'}
]

User.first.branches.create! [
	{name: '9.0-0', completed: true, root: '/pssnfs/', http: 'http://...com'}
]

Ne.all.each do |ne|
  ne.user = users.first
  ne.save!
end

Branch.all.each do |branch|
	branch.user = users.first
	branch.save!
end