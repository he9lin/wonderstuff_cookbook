require 'spec_helper'

describe "wonderstuff::default" do
  let(:chef_run) do
    runner = ChefSpec::Runner.new.converge(described_recipe)
  end

  it "installs the lighttpd package" do
    expect(chef_run).to install_package 'lighttpd'
  end

  it "creates a webpage to be served" do
    file = '/var/www/index.html'
    expect(chef_run).to create_cookbook_file(file).with(
      user:  'www-data',
      group: 'www-data'
    )
    expect(chef_run).to render_file(file).with_content \
      'Wonderstuff Design is a boutique graphics design agency.'
  end

  it "starts the lighttpd service" do
    expect(chef_run).to start_service 'lighttpd'
  end

  it "enables the lighttpd service" do
    expect(chef_run).to enable_service 'lighttpd'
  end
end
