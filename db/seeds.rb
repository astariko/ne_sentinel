Ne.destroy_all
User.destroy_all
Branch.destroy_all
Job.destroy_all

users = User.create! [
  { username: "artem", password: "qweQWE123!@#", state: "active", privilege: "admin" },
  { username: "userA", password: "qweQWE123!@#", state: "active", privilege: "user" }
]

User.first.nes.create! [
	{name: 'SAN-5', ip: '135.121.44.33', ectype: 'ARMADA', version:'17.14-20', system:'BACKBONE', branch_name:'9.0-0'},
	{name: 'SAN-6', ip: '135.121.44.34', ectype: 'ECX', version: '17.10-20', system:'BACKBONE', branch_name:'9.0-0'},
	{name: 'SAN-7', ip: '135.121.44.27', ectype: 'PSS4', version: '17.12-20', system:'SLIM', branch_name:'9.0-0'},
	{name: 'SAN-10',ip: '135.121.44.252', ectype: 'PSS4', version: '17.14-40', system:'SLIM', branch_name:'9.0-0'},
	{name: 'Self',ip: '127.0.0.1', ectype: 'PSS4', version: '10.14-40', system:'SLIM', branch_name:'9.0-0'}
]

User.first.branches.create! [
	{name: '9.0-0', completed: true, root: '/pssnfs/', http: 'http://...com'}
]

Ne.all.each do |ne|
  ne.user = users.first
  ne.save!
end

job = Job.create! [
	{status: 'done'}
]
