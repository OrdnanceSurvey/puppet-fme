Puppet::Type.newtype(:fme_repository_item) do
  desc "Puppet type that manages FME repository item"

  ensurable

  autorequire(:file) do
    Fme::Helper.settings_file
  end

  autorequire(:fme_repository) do
    self[:repository]
  end

  def self.title_patterns
    [
      [
        /^(.*)\/(.*)$/, # pattern to parse <repository>/<item>
        [
          [:repository, lambda{|x| x} ],
          [:item,       lambda{|x| x} ]
        ]
      ],
      [
        /(.*)/, # Catch all workaround to avoid 'No set of title patterns matched the title'
        [
          [:dummy, lambda{|x| ""} ]
        ]
      ]
    ]
  end

  validate do
    fail "'name' should not be used" unless @original_parameters[:name].nil? or @original_parameters[:name] == "#{@original_parameters[:repository]}/#{@original_parameters[:item]}"
    if match = @title.match(/^(.*)\/(.*)$/) # rubocop:disable Lint/AssignmentInCondition
      fail "'repository' parameter #{self[:repository]} must match resource title #{@title} or be omitted" unless match.captures[0] == self[:repository]
      fail "'item' parameter #{self[:item]} must match resource title #{@title} or be omitted" unless match.captures[1] == self[:item]
    end
    fail "source is required when ensure is present" if self[:ensure] == :present and self[:source].nil?
  end

  newparam(:dummy) do
    validate { |value| fail "dummy parameter shouldn't be used" unless value.empty? }
  end

  newparam(:repository, :namevar => true) do
    desc "Name of the repository containing the item"
  end

  newparam(:item, :namevar => true) do
    desc "The name of the item"
    newvalues(/[^\/]+\.(?:|fmw|fds|fmx|fmwt)/)
  end

  newparam(:name, :namevar => true) do
    desc "The default namevar"
    defaultto ""
    munge do |value|
      if value.empty? and resource[:repository] and resource[:item]
       "#{resource[:repository]}/#{resource[:item]}"
      else
        fail "Use resource name style <repository>/<item> OR specify both 'repository' and 'item'" unless value.match /^(.*)\/(.*)$/
        value
      end
    end
  end

  newparam(:source) do
    desc "The file to upload.  Must be the absolute path to a file."
    validate do |value|
      fail "'source' file path must be fully qualified, not '#{value}'" unless Puppet::Util.absolute_path?(value)
    end
  end

  newproperty(:description) do
    desc "The item's description. Read-only"
    validate { |val| fail "description is read-only" }
  end

  newproperty(:item_title) do
    desc "The item's title. Read-only"
    validate { |val| fail "item_title is read-only" }
  end

  newproperty(:type) do
    desc "The item's type. Read-only"
    validate { |val| fail "type is read-only" }
  end

  newproperty(:last_save_date) do
    desc "The item's lastSaveDate. Read-only"
    validate { |val| fail "last_save_date is read-only" }
  end
end