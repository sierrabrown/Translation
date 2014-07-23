json.array!(@jobs) do |job|
	json.partial!("job", :job => job)
end