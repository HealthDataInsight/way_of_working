namespace :ways_of_working do
  namespace :linter  do
    desc "Runs the MegaLinter runner"
    task :run do
      system('time npx mega-linter-runner --remove-container')
    end
  end
end
