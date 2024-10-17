GEM_VERSION_PLATFORM_REGEXP = /
  \A
  (.*?)
  -((?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\.(?:0|[1-9]\d*).*?)
  (?:-(java|(?:aarch|arm|x)(?:86)?(?:_)?(?:64)?-(?:darwin|linux|mingw32|mingw-ucrt)))?
  \.gem
  \z
/ix

namespace :audit do
  desc 'This tasks audits vendored gems, comparing file digests with published ones'
  task :gems do
    require 'digest'
    require 'git'
    require 'highline/import'
    require 'json'
    require 'nokogiri'
    require 'open-uri'

    git_base = Git.open('.')
    git_user_name = git_base.config('user.name')
    failed = false

    Dir['vendor/cache/*.gem'].each do |path|
      file_digest = Digest::SHA256.file(path).hexdigest
      file_name = File.basename(path)
      matchdata = GEM_VERSION_PLATFORM_REGEXP.match(file_name)
      gem_name = matchdata[1]
      gem_version = matchdata[2]
      gem_platform = matchdata[3]

      begin
        api_url = "https://rubygems.org/api/v2/rubygems/#{gem_name}/versions/#{gem_version}.json" \
                  "?platform=#{gem_platform || 'ruby'}"
        api_result = JSON.parse(URI.parse(api_url).read)
        published_checksum = api_result['sha']

        if api_result['yanked'] == true
          puts HighLine.new.color("Yanked Version: #{path} (#{api_url})", :red)
          failed = true
        elsif published_checksum == file_digest
          release = git_base.log.object(path).to_s

          system "bundle exec rake audit:safe release='#{release}' file='#{path}' " \
                 "reviewed_by='#{git_user_name}' " \
                 "comments='Checksum matches published version on rubygems.org (#{file_digest})'"
        else
          puts HighLine.new.color("Digest Mismatch: #{path} (#{api_url})", :red)
          puts HighLine.new.color("Published Digest: #{published_checksum}", :red)
          puts HighLine.new.color("File Digest: #{file_digest}", :red)
          failed = true
        end
      rescue OpenURI::HTTPError
        puts HighLine.new.color("Not Found: #{path} (#{api_url})", :yellow)
      end
    end

    exit(false) if failed
  end
end
