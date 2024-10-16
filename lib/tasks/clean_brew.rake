namespace :clean do
  desc 'This task lists true outdated/unused brew packages, updates or removes them'
  task :brew, [:package, :safe_version] do |_t, args|
    package = args[:package]
    safe_version = args[:safe_version]

    if package.nil? || safe_version.nil?
      puts 'Error: Both package and safe_version are required.'
      next
    end

    # Update homebrew
    `brew update`

    # Upgrade the package
    puts "Upgrading #{package}..."
    `brew upgrade #{package}`

    # Compare current package version with safe_version
    current_version = get_current_version(package)
    puts "Current version of #{package}: #{current_version}" if current_version
    return if Gem::Version.new(current_version) >= Gem::Version.new(safe_version)

    # Check dependencies
    return if any_dependencies?(package)

    # User confirmation
    puts "#{package} is unused and outdated (#{current_version}) < #{safe_version}. \nDo you want to remove it (y/n)?"
    response = $stdin.gets.chomp.downcase

    # Remove package
    return unless response == 'y'

    puts "Removing #{package}..."
    `brew uninstall #{package}`
  end
end

def get_current_version(package)
  info = `brew info #{package}`

  return unless info =~ /#{package}:\s+\w+\s+([\d\._]+)/

  # TODO: test it works for various version formats

  Regexp.last_match(1)
end

def any_dependencies?(package)
  dependencies = `brew deps --installed`.split("\n").flat_map do |line|
    line.split(':').last.strip.split
  end.uniq

  dependencies.include?(package)
end
