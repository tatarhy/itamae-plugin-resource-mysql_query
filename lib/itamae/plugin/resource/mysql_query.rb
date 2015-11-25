require 'itamae'
require 'tempfile'

module Itamae
  module Plugin
    module Resource
      class MysqlQuery < ::Itamae::Resource::Base
        class Error < StandardError; end

        define_attribute :action, default: :run
        define_attribute :user, type: String, default: ''
        define_attribute :password, type: String, default: ''
        define_attribute :query, type: String, default: '', default_name: true

        def pre_action
          case @current_action
          when :run
            attributes.executed = true
          end

          send_tempfile
        end

        def set_current_attributes
          current.executed = false
        end

        def action_run(options)
          user_opt = attributes.user.empty? ? '' : "-u#{attributes.user}"
          password_opt = attributes.password.empty? ? '' : "-p#{attributes.password}"

          begin
            run_command(%Q{mysql #{user_opt} #{password_opt} < #{@temppath}})
          ensure
            run_specinfra(:remove_file, @temppath)
          end

          updated!
        end

        private

        def send_tempfile
          begin
            f = Tempfile.open('itamae')
            f.write(attributes.query)
            f.close
            src = f.path

            @temppath = ::File.join(runner.tmpdir, Time.now.to_f.to_s)
            backend.send_file(src, @temppath)
          ensure
            f.unlink if f
          end
        end
      end
    end
  end
end
