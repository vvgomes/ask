task :deploy do
  execute = ->(cmd) do
    puts "$ #{cmd}"
    abort unless system(cmd)
  end
  puts "# deploing to heroku..."
  app = 'askapp' 
  execute.("heroku maintenance:on -a #{app}")
  execute.("git push heroku master")
  execute.("heroku maintenance:off -a #{app}")
  puts "# deploy successful 🍺:"
end

