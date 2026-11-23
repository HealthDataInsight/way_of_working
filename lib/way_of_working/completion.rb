# frozen_string_literal: true

module WayOfWorking
  # Shell completion. The shell scripts are thin: on every Tab they call
  # `way_of_working __complete <words>`, which walks the live Thor command tree,
  # so commands from plugins and opt-in features always show up.
  module Completion
    SCRIPTS = {
      'bash' => <<~'BASH',
        _way_of_working() {
          local IFS=$'\n'
          COMPREPLY=($(way_of_working __complete "${COMP_WORDS[@]:1:COMP_CWORD}" 2>/dev/null))
        }
        complete -F _way_of_working way_of_working
      BASH
      'zsh' => <<~ZSH
        _way_of_working() {
          local -a candidates
          candidates=(${(f)"$(way_of_working __complete "${(@)words[2,CURRENT]}" 2>/dev/null)"})
          compadd -a candidates
        }
        compdef _way_of_working way_of_working
      ZSH
    }.freeze

    def self.script(shell)
      SCRIPTS.fetch(shell) { raise Thor::Error, "Unsupported shell #{shell.inspect}, use bash or zsh" }
    end

    # words: everything typed after `way_of_working`, the last being the word being completed.
    # ponytail: completes command names and option switches only, not option values.
    def self.candidates(words)
      *typed, current = words
      klass, command = resolve(typed)
      return [] unless klass

      names = if command
                command.options.values.flat_map { |option| [option.switch_name, *option.aliases] }
              else
                klass.all_commands.reject { |_name, cmd| cmd.hidden? }.keys
              end
      names.select { |name| name.start_with?(current.to_s) }.sort
    end

    # Walks the typed words down the Thor tree to the innermost class and, once one
    # is typed, its command. Returns nil for an unknown word.
    def self.resolve(typed)
      klass = Cli
      typed.reject { |word| word.start_with?('-') }.each do |word|
        unless klass.subcommand_classes.key?(word)
          command = klass.all_commands[word]
          return command && [klass, command]
        end

        klass = klass.subcommand_classes[word]
      end
      [klass, nil]
    end
  end
end
