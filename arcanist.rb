require 'formula'

class Arcanist < Formula
  homepage 'http://phabricator.org/'
  url 'https://github.com/facebook/arcanist/tarball/master'
  sha1 'f099168aa82c1c1f5a6fd8f8b8f32e9237e7b309'
  version '0.1'

  depends_on 'libphutil'

  head 'https://github.com/facebook/arcanist.git'
  
  def install
    # Get the location of libphutil so you can link arcanist to them
    var = `brew --prefix libphutil`.strip

    # Create the path where arcanist will look for libphutil
    FileUtils.mkdir_p 'externals/includes'

    # Link arcanist to libphutil
    cd "externals/includes" do
      File.symlink(var, "libphutil")
    end
    
    # Remove Windows scripts - BOOM!
    rm_rf Dir['bin/*.bat']

    prefix.install Dir['*']
  end

  def test
    system "true"
  end
end
