class NlTaskwarrior < Formula
  desc "Feature-rich console based todo list manager"
  homepage "https://taskwarrior.org/"

  head "https://github.com/NonLogicalDev/fork.util.taskwarrior.git", :branch => "stable", :shallow => false

  option "without-gnutls", "Don't use gnutls; disables sync support"
  depends_on "cmake" => :build
  depends_on "gnutls" => :recommended

  needs :cxx11

  def install
    args = std_cmake_args
    args << "-DENABLE_SYNC=OFF" if build.without? "gnutls"
    system "cmake", ".", *args
    system "make", "install"
    bash_completion.install "scripts/bash/task.sh"
    zsh_completion.install "scripts/zsh/_task"
    fish_completion.install "scripts/fish/task.fish"
  end

  test do
    touch testpath/".taskrc"
    system "#{bin}/task", "add", "Write", "a", "test"
    assert_match "Write a test", shell_output("#{bin}/task list")
  end
end
